--  Hive DDL for creating star schema (fact + dimension tables)
-- Fact Table for User Actions (Using Parquet format)
CREATE TABLE fact_user_actions (
  user_id STRING,
  content_id STRING,
  action STRING,
  timestamp TIMESTAMP,
  device STRING,
  region STRING,
  session_id STRING,
  category STRING,
  title STRING,
  length INT,
  artist STRING
)
STORED AS PARQUET;

-- Insert data from raw tables into the fact table
INSERT OVERWRITE TABLE fact_user_actions
SELECT
  r.user_id,
  r.content_id,
  r.action,
  CAST(r.timestamp AS TIMESTAMP) AS timestamp,
  r.device,
  r.region,
  r.session_id,
  c.category,
  c.title,
  c.length,
  c.artist
FROM raw_user_logs r
JOIN raw_content_metadata c ON r.content_id = c.content_id;

-- Dimension Table for Content Metadata
CREATE TABLE dim_content (
  content_id STRING,
  title STRING,
  category STRING,
  length INT,
  artist STRING
)
STORED AS PARQUET;

-- Insert data from raw content metadata into the dimension table
INSERT OVERWRITE TABLE dim_content
SELECT DISTINCT content_id, title, category, length, artist FROM raw_content_metadata;
