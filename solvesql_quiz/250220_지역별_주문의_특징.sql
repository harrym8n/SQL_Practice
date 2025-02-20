-- 자역별, 특정 카테고리별 주문 건수

SELECT
  t1.region as Region,
  COUNT(DISTINCT t1.Furniture) as 'Furniture',
  COUNT(DISTINCT t1.Office_Supplies) as 'Office Supplies',
  COUNT(DISTINCT t1.Technology) as 'Technology'
FROM
  (SELECT
    region,
    CASE WHEN category == 'Furniture' THEN order_id END as 'Furniture',
    CASE WHEN category == 'Office Supplies' THEN order_id END as 'Office_Supplies',
    CASE WHEN category == 'Technology' THEN order_id END as 'Technology'
  FROM
    records) t1
GROUP BY
  t1.region
ORDER BY
  t1.region