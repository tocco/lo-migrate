//! receive thread implementation
//!
//! The receiver thread receives [`Lo`]s from the observer thread. Then it retrieves the Large
//! Object and stores them in memory or as temporary file, depending on size. Once this is done
//! it pushes the [`Lo`]s storer thread.

use postgres::Connection;
use postgres::error as sql_error;
use digest::Digest;
use error::Result;
use two_lock_queue;
use std::sync::Arc;
use super::*;

pub struct Receiver<'a> {
    stats: &'a ThreadStat,
    conn: &'a Connection,
}

impl<'a> Receiver<'a> {
    pub fn new(thread_stat: &'a ThreadStat, conn: &'a postgres::Connection) -> Self {
        Receiver {
            stats: thread_stat,
            conn: conn,
        }
    }

    pub fn start_worker<D>(&self,
                           rx: Arc<two_lock_queue::Receiver<Lo>>,
                           tx: Arc<two_lock_queue::Sender<Lo>>,
                           size_threshold: i64)
                           -> Result<()>
        where D: Digest + Default
    {
        // receive from observer thread
        while let Ok(mut lo) = rx.recv() {
            trace!("processing large object: {:?}", lo);

            // retrieve Large Object from Postgres
            match lo.retrieve_lo_data::<D>(self.conn, size_threshold) {
                Ok(_) => {
                    // global counter of received objects
                    self.stats.lo_received.fetch_add(1, Ordering::Relaxed);

                    // pass on `Lo` to storer thread
                    tx.send(lo)?;
                }
                Err(e @ MigrationError::InvalidObject(_)) => {
                    error!("Failed to fetch object: {}.", e);
                    self.stats.lo_failed.fetch_add(1, Ordering::Relaxed);
                }
                Err(MigrationError::PgError(ref err))
                    if err.as_db()
                        .map(|e| e.code == sql_error::UNDEFINED_OBJECT)
                        .unwrap_or(false) =>
                {
                    error!("Object with loid {} missing in database.", lo.oid());
                    self.stats.lo_failed.fetch_add(1, Ordering::Relaxed);
                }
                Err(e) => return Err(e),
            }

            // thread cancellation point
            self.stats.cancellation_point()?;
        }

        info!("thread has completed its mission, sender hung up queue");
        Ok(())
    }
}
