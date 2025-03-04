-- 각 게임 개발사의 주력 플랫폼과 해당 플랫폼의 판매량 합계를 집계
-- 주력 플랫폼 = 보통 판매량이 가장 많은 플랫폼
WITH rank_t AS (
  SELECT
    developer_id,
    platform_id,
    RANK() OVER (PARTITION BY developer_id ORDER BY SUM(sales_na + sales_eu + sales_jp + sales_other) DESC) as rnk,
    SUM(sales_na + sales_eu + sales_jp + sales_other) as total
  FROM
    games
  GROUP BY
    developer_id, platform_id
  ORDER BY 
    developer_id, total DESC
)

SELECT
  t2.name as developer, t3.name as platform, t1.total as sales
FROM 
  rank_t t1,
  companies t2,
  platforms t3 
WHERE
  t1.rnk = 1 AND
  t1.developer_id = t2.company_id AND
  t1.platform_id = t3.platform_id