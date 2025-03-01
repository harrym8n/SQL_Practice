SELECT
  ROUND(SUM(total_bill) / COUNT(DISTINCT day), 2) as avg_sales
FROM
  tips