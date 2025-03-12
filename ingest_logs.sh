#!/bin/bash

# Accept the date parameter in YYYY-MM-DD format
DATE=$1

# Parse year, month, and day
YEAR=$(echo $DATE | cut -d'-' -f1)
MONTH=$(echo $DATE | cut -d'-' -f2)
DAY=$(echo $DATE | cut -d'-' -f3)

# Define the local directory where logs are stored
LOCAL_LOGS_DIR="logs/$DATE"

# Define the HDFS base directories
HDFS_LOGS_DIR="/raw/logs/$YEAR/$MONTH/$DAY"
HDFS_METADATA_DIR="/raw/metadata/$YEAR/$MONTH/$DAY"

# Create the necessary HDFS directories
hdfs dfs -mkdir -p $HDFS_LOGS_DIR
hdfs dfs -mkdir -p $HDFS_METADATA_DIR

# Ingest the log files (CSV/JSON) into HDFS
hdfs dfs -put $LOCAL_LOGS_DIR/* $HDFS_LOGS_DIR/
hdfs dfs -put $LOCAL_LOGS_DIR/*metadata $HDFS_METADATA_DIR/

echo "Logs ingested into HDFS under /raw/logs/$YEAR/$MONTH/$DAY and /raw/metadata/$YEAR/$MONTH/$DAY"
