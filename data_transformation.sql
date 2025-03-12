--  Hive SQL for data transformations (inserting into star schema)

-- Convert timestamp from string to proper timestamp type
INSERT OVERWRITE TABLE fact_user_actions
SELECT
  user_id,
  content_id,
  action,
  CAST(timestamp AS TIMESTAMP),
  device,
  region,
  session_id,
  category,
  title,
  length,
  artist
FROM raw_user_logs;
