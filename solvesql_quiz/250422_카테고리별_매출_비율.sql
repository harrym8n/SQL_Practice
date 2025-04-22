-- 서브 카테고리 별 매출액을 계산
-- 그 매출액이 각 서브 카테고리가 속해있는 카테고리 안에서 비중을 얼마나 차지하는지
-- 전체 매출액에서는 비중을 얼마나 차지하는지 계산
WITH CTE AS 
(
SELECT
  category,
  sub_category,
  ROUND((SUM(sales) OVER (PARTITION BY sub_category)),2) AS sales_sub_category,
  ROUND((SUM(sales) OVER (PARTITION BY category)),2) AS sales_category,
  ROUND((SELECT SUM(sales) FROM records),2) AS sales_total,
  ROUND((((SUM(sales) OVER (PARTITION BY sub_category)) / (SUM(sales) OVER (PARTITION BY category)))*100),2) AS pct_in_category,
  ROUND((((SUM(sales) OVER (PARTITION BY sub_category)) / (SELECT SUM(sales) FROM records))*100),2) AS pct_in_total
FROM
  records
)

SELECT DISTINCT *
FROM CTE