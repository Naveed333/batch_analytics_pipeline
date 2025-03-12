--  Hive SQL with sample analytical queries (e.g., monthly active users)

-- Monthly Active Users by Region
SELECT 
  year, 
  month, 
  region, 
  COUNT(DISTINCT user_id) AS active_users
FROM fact_user_actions
GROUP BY year, month, region;
