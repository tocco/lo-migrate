#![cfg(feature = "postgres_tests")]
#![cfg(feature = "s3_tests")]

extern crate hyper;
extern crate lo_migrate;
extern crate log;
extern crate postgres;
extern crate rusoto_credential;
extern crate rusoto_s3;
extern crate rustc_serialize as serialize;
extern crate sha2;
extern crate simple_logger;
extern crate two_lock_queue as queue;

mod common;
use common::*;

use hyper::Client;
use rusoto_credential::StaticProvider;
use rusoto_s3::{GetObjectRequest, S3, S3Client};
use serialize::hex::ToHex;
use sha2::{Digest, Sha256};
use std::sync::Arc;
use lo_migrate::thread::{Committer, Counter, Observer, Receiver, Storer, ThreadStat};

// sha256 hashes of clean_data.sql sorted by OID (DB column data)
const SHA256_HEX: [&str; 5] = ["927927d87145e11e602a5cab6d2b6d5d533764f844de45efb776931f2cc7c742",
                               "e86ae2fd5056fcd75f6a9ed884fdc23d880be6d5de6159901e564ed19b12aa00",
                               "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
                               "e97a63c34bb2299e977ec5aea161f49ffdd3c6a719c8838504e20f8a8db85ae2",
                               "2bf30d0b24a4ac96b21da2bf401f2e16063839cec8263e7f3397b6fafbac02ad"];

// mime types of clean_data.sql sorted by OID (DB column data)
const MIME_TYPES: [&str; 5] = ["", "octet/stream", "octet/stream", "text/plain", "octet/stream"];

/// Test complete migration from Postgres to S3
#[test]
fn migration() {
    simple_logger::init().unwrap();

    let stats = ThreadStat::new();
    let pg_conn = postgres_conn();
    let (s3_client, bucket_name) = s3_conn();

    // create database
    pg_conn.batch_execute(include_str!("clean_data.sql")).unwrap();

    // count large objects
    let counter = Counter::new(&stats, &pg_conn);
    counter.start_worker().unwrap();
    // 7 and 8 include two invalid hashes
    assert_eq!(extract_stats(&stats), (Some(6), Some(5), 0, 0, 0, 0, 0));

    // get list of large objects
    let (rcv_tx, rcv_rx) = queue::unbounded();
    let observer = Observer::new(&stats, &pg_conn);
    observer.start_worker(Arc::new(rcv_tx), 1024).unwrap();
    assert_eq!(extract_stats(&stats), (Some(6), Some(5), 5, 0, 0, 0, 0));

    // fetch large objects from postgres
    let (str_tx, str_rx) = queue::unbounded();
    let receiver = Receiver::new(&stats, &pg_conn);
    receiver.start_worker::<Sha256>(Arc::new(rcv_rx), Arc::new(str_tx), 28).unwrap();
    assert_eq!(extract_stats(&stats), (Some(6), Some(5), 5, 5, 0, 0, 0));

    // store objects to S3
    let (cmt_tx, cmt_rx) = queue::unbounded();
    let storer = Storer::new(&stats, 5 * 1024 * 1024 + 3);
    storer.start_worker(Arc::new(str_rx), Arc::new(cmt_tx), &s3_client, &bucket_name)
        .unwrap();
    assert_eq!(extract_stats(&stats), (Some(6), Some(5), 5, 5, 5, 0, 0));

    // commit sha256 hashes to postgres
    let committer = Committer::new(&stats, &pg_conn);
    committer.start_worker(Arc::new(cmt_rx), 2).unwrap();
    assert_eq!(extract_stats(&stats), (Some(6), Some(5), 5, 5, 5, 5, 0));

    // verify sha256 hashes
    let sha2_hashes: Vec<String> = pg_conn.query("SELECT sha2 FROM _nice_binary WHERE sha2 <> \
                '0000000000000000000000000000000000000000000000000000000000000000' AND sha2 IS \
                NOT NULL ORDER BY data",
               &[])
        .unwrap()
        .iter()
        .map(|row| row.get(0))
        .collect();
    assert_eq!(&sha2_hashes, &SHA256_HEX);

    // verify S3 bucket content
    for (sha256, mime_type) in SHA256_HEX.iter().zip(&MIME_TYPES) {
        assert_object_in_store(&s3_client, &bucket_name, sha256, mime_type);
    }
}

fn assert_object_in_store(client: &S3Client<StaticProvider, Client>,
                          bucket_name: &str,
                          expected_sha256: &str,
                          mime: &str) {
    let request = GetObjectRequest {
        bucket: bucket_name.to_string(),
        key: expected_sha256.to_string(),
        ..Default::default()
    };
    let response = client.get_object(&request).unwrap();
    let mut actual_sha256 = Sha256::default();
    let mut body = Vec::new();
    response.body.unwrap().read_to_end(&mut body).unwrap();
    actual_sha256.input(&body);

    assert_eq!(expected_sha256, &actual_sha256.result().to_hex());
    assert_eq!(&response.content_type.unwrap(), mime);
}
