#!/bin/sh
while true; do
  mongodump --host mongo --port 27017 --username root --password root --gzip --archive=/backup/mongodb/db_backup_$(date +%Y%m%d_%H%M%S).gz
  sleep 86400
done
