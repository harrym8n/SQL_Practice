-- chatGPT 출제
-- 2024년 한 해 동안 완료된 주문만 분석
-- 고객별 총 구매 건수와 총 구매 금액을 기준으로 다음과 같이 레벨을 구분하세요:
	-- 총 주문 5회 이상 또는 총 금액이 1,000,000원 이상 → ‘VIP’
	-- 총 주문 3회 이상 5회 미만 또는 총 금액 500,000원 이상 1,000,000원 미만 → ‘General’
	-- 외 → ‘Low’
-- 고객별 첫 주문일(order_date)을 기준으로 오름차순 정렬하여 상위 10명의 고객 이름, 충성도 레벨, 총 구매 건수, 총 구매 금액을 출력

WITH base AS 
(
SELECT
  o.order_id,
  o.customer_id,
  o.order_date,
  (oi.quantity * oi.price) AS total_amount
FROM
  orders o
  JOIN order_items oi ON o.order_id = oi.order_id
WHERE
  YEAR(o.order_date)=2024
), group AS
(
SELECT
  c.customer_id,
  c.name,
  CASE
    WHEN SUM(total_amount) >= 1000000 THEN 'VIP'
    WHEN SUM(total_amount) >= 500000 THEN 'General'
  ELSE 'Low'
  END AS loyalty_level,
  COUNT(DISTINCT b.order_id) AS total_orders,
  SUM(total_amount) AS total_amount
FROM
  base b
  JOIN customers c ON b.customer_id = c.customer_id
GROUP BY
  c.customer_id, c.name
), first_order AS
(
SELECT customer_id, MIN(order_date) AS first_date
FROM base
GROUP BY customer_id
)

SELECT
  g.name,
  g.loyalty_level,
  g.total_orders,
  g.total_amount
FROM
  group g
  JOIN first_order fo ON g.customer_id = fo.customer_id
ORDER BY 
  fo.first_date LIMIT 10