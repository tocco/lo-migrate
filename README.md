# Migrate Large Objects from Postgres to S3

[![Build Status](https://travis-ci.org/pgerber/lo-migrate.svg?branch=master)](https://travis-ci.org/pgerber/lo-migrate)
[![codecov](https://codecov.io/gh/pgerber/lo-migrate/branch/master/graph/badge.svg)](https://codecov.io/gh/pgerber/lo-migrate)

This software is used by [Tocco AG](https://www.tocco.ch) the creator of the
[Tocco Business Framework](https://www.tocco.ch/software/branchenlosungen/ubersicht) to transition from
[Postgres Large Object](https://www.postgresql.org/docs/current/static/largeobjects.html) storage to an AWS S3 compatible
storage ([Ceph Object Storage](https://ceph.com/ceph-storage/object-storage/)). In addition, the key for referencing
binaries is updated from SHA1 to SHA2.

# Usage

## Available Command Line Arguments


```
$ ./lo_migrate_cli --help
Postgres Large Object to S3 Migrator

USAGE:
    lo_migrate_cli [OPTIONS] --s3-url <URL> --access-key <KEY> --secret-key <KEY> --bucket <NAME> --pg-url <URL>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --commit-chunk <INT>        Number of SHA2 hashes commited per DB transaction
        --committer-queue <INT>     Size of the committer queue
        --committer-threads <INT>   Number of committer threads
        --in-mem-max <INT>          Max. size of Large Object to keep in memory (in KiB)
    -i, --interval <SECS>           Interval in which stats are shown (in secs)
    -p, --pg-url <URL>              Url to connect to postgres (postgresql://USER:PASS@HOST/DB_NAME)
        --receiver-queue <INT>      Size of the receiver queue
        --receiver-threads <INT>    Number of receiver threads
    -k, --access-key <KEY>          S3 access key
    -b, --bucket <NAME>             Name of the S3 bucket
    -s, --secret-key <KEY>          S3 secret key
    -u, --s3-url <URL>              URL to S3 endpoint
        --storer-queue <INT>        Size of the storer queue
        --storer-threads <INT>      Number of storer threads
```

## Example

Migrate binaries from database **nice2_ecap** to the **ecap** bucket:

```bash
lo_migrate_cli --pg-url postgresql://ecap@postgres.tocco.ch/nice2_ecap --access-key my_key --secret-key my_secret --bucket ecap --s3-url "https://s3.tocco.ch"
```

## Debugging

Logging can be enabled via `RUST_LOG` environment variable, for instance `RUST_LOG=lo_migrate=info` enables all info
messages. Logging is provided [env_logger](https://crates.io/crates/env_logger) whose
[documentation](doc.rust-lang.org/log/env_logger) provides more examples.

# Installation

## Compiling the Code

This code uses features only available in the nightly builds of the Rust Compiler. Nightly is unstable and breaking
changes may be introduced at any time. You may want to install a particular verison of nightly to make sure it keeps
compiling. See also [Troubleshooting](#troubleshooting).

1. install [rustup](https://www.rustup.rs/) (use default settings)
3. clone this repository: `$ git clone https://github.com/pgerber/lo-migrate.git`
4. cd into the newly checked out repository: `$ cd lo-migrate`
5. build the code:  `$ cargo build --release`
6. execute the binary: `$ cargo run --release -- …` ('…' are the parameters passed on to the executable)

   You can also run the binary directly, it is located at `target/release/lo_migrate_cli`.

## Troubleshooting

* If compilation of openssl-sys fails, make sure you have the dev packages for openSSL or LibreSSL installed as well as
  the pkg-config build tool. On Debian  based systems you can do so via `$ sudo apt-get install libssl-dev
  pkg-config`. See [openssl-sys](https://github.com/sfackler/rust-openssl)' README for more details.

# Design

The objects are represented as [`lo`][lo]`::`[`Lo`][lo]s within the software. This objects are passed through multiple
groups of thread workers. To allow the [`Lo`][lo]s to be passed from thread to thread
[multi-reader and multi-writer queues](https://crates.io/crates/two-lock-queue) are used.

## Worker Threads

The [`Lo`][lo]s are passed from thread group to thread group in this order:

1. **The Observer Thread ([`thread`][thread]`::`[`Observer`][observer])**  
   This is just a single thread that reads the list of Large Object from the _nice_binary table. It creates the initial
   [`Lo`][lo] objects containing the sha1 hash, oid, mime type and size of the object. Then, it passes them on to the
   next thread group.

   info: The queue between [`Observer`][observer] and [`Receiver`][receiver] is referred to as **receiver** queue
   throughout the code.

2. **The Receiver Threads ([`thread`][thread]`::`[`Receiver`][receiver])**  
   Threads in this group fetch the Large Objects from Postgres and embed the data in the [`Lo`][lo] objects. For files
   larger than 1 MiB (configurable), the data is written to a temporary file, smaller object are kept in memory.
   Additionally, the SHA2 hash of the object is calculated and also stored on the [`Lo`][lo]s. [`Lo`][lo]s are then
   passed on to the next thread group.

   info: The queue between [`Receiver`][receiver] and [`Storer`][storer] is referred to as **storer** queue throughout
   the code.

3. **The Storer Threads ([`thread`][thread]`::`[`Storer`][storer])**  
   This group of threads is responsible for writing the data to the S3 storage and setting the correct meta data (SHA2
   hash, mime type, etc.). After dropping the data held in memory and removing temporary files the [`Lo`][lo]o are
   passed on to the next thread group.

   info: The queue between [`Storer`][storer] and [`Committer`][committer] is referred to as **committer** queue
   throughout the code.

4. **The Committer Threads ([`thread`][thread]`::`[`Committer`][committer])**  
   This thread commits the generated SHA2 hashes to the database. By default, committing 100 hashes per transaction.
   Afterwards, the [`Lo`][lo] objects are dropped for good.

Only objects that have no SHA2 set are copied and the hash is only set once the object is in the S3 storage. This way
copying can be stopped and resumed at any time without risking any data loss.

## The Monitor Thread
This thread, [`thread`][thread]`::`[`Monitor`][monitor], shows the number of [`Lo`][lo]s processed by each thread group,
status of the queue and the total amount of object migrated. To enable global stats, the atomic counters in
[`thread`][thread]`::`[`ThreadStat`][thread] are shared amongst all threads. It is the threads' responsibility to
increase their respective counters.

Message printed by the monitor thread look like this:
```
*******************************************************************
    Status at 2017-03-10 10:10:53 (updated every: 10s), ETA: 2017-03-10 11:15:33  (1h 04m 40s)

Progress Overview:
    0.01%, 1200 of 22618378 object have been migrated

Processed Objects by Thread Pools:
    observer thread   - processed:    9752, current speed:  892.7 Lo/s, average speed:  441.7 Lo/s
    receiver threads  - processed:    1558, current speed:  142.6 Lo/s, average speed:   70.6 Lo/s
    storer threads    - processed:    1432, current speed:  131.1 Lo/s, average speed:   64.9 Lo/s
    committer threads - processed:    1200, current speed:  109.8 Lo/s, average speed:   54.4 Lo/s

Queue Usage:
    receive queue     - used   8192 of   8192, 100.00% full, changed by:  +4235
    store queue       - used    532 of   1024,  11.82% full, changed by:    -50
    commit queue      - used     83 of   8192,   0.39% full, changed by:    +32
    commit queue      - used      0 of   8192,   0.00% full, changed by:     +0
```


[lo]: src/lo.rs
[committer]: src/thread/commit.rs
[monitor]: src/thread/monitor.rs
[observer]: src/thread/observe.rs
[receiver]: src/thread/receive.rs
[storer]: src/thread/store.rs
[thread]: src/thread/mod.rs
