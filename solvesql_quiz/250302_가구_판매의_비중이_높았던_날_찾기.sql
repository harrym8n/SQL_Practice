-- 일별 주문 수가 10개 이상인 날 중
-- ‘Furniture’ 카테고리 주문의 비율이 40% 이상 이었던 날
-- Furniture 카테고리의 주문 비율은 백분율로 계산하며, 반올림하여 소수점 둘째자리까지만 출력
-- Furniture 카테고리의 주문 비율 내림차순, 날짜 순 정렬

-- 임시테이블 생성, 서브쿼리로 해결
WITH tmp AS (
    SELECT
      t1.order_date,
      t2.order_id,
      t2.category
    FROM
      (SELECT order_date
        FROM records
        GROUP BY order_date
        HAVING COUNT(DISTINCT order_id) >= 10) t1,
      records t2
    WHERE
      t1.order_date = t2.order_date)

SELECT
  t1.order_date,
  t2.cnt as furniture,
  ROUND((t2.cnt*1.0 / t1.total_cnt*1.0)*100,2) as furniture_pct
FROM
  (SELECT order_date, COUNT(DISTINCT order_id) as total_cnt
  FROM tmp 
  GROUP BY order_date) t1,
  (SELECT order_date, COUNT(DISTINCT order_id) as cnt
  FROM tmp
  WHERE category = 'Furniture'
  GROUP BY order_date) t2
WHERE
  t1.order_date = t2.order_date AND
  (t2.cnt*1.0 / t1.total_cnt*1.0) >= 0.4
ORDER BY
  furniture_pct DESC,
  t1.order_date


-- CASE WHEN 구문으로 해결
SELECT
  order_date,
  COUNT(DISTINCT(CASE WHEN category = 'Furniture' THEN order_id END)) as furniture,
  ROUND((COUNT(DISTINCT(CASE WHEN category = 'Furniture' THEN order_id END))*1.0 / COUNT(DISTINCT order_id)*1.0)*100,2) as furniture_pct
FROM
  records
GROUP BY
  order_date
HAVING
  COUNT(DISTINCT order_id) >= 10 AND
  (COUNT(DISTINCT(CASE WHEN category = 'Furniture' THEN order_id END))*1.0 / COUNT(DISTINCT order_id)*1.0) >= 0.4
ORDER BY
  furniture_pct DESC,
  order_date