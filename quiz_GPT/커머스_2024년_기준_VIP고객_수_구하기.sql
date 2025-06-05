-- chatGPT 출제
-- 2024년 한 해 동안 completed 상태의 주문이 총 3회 이상
-- 2024년 주문 상품 총 구매 금액(quantity × price)의 합이 500,000원 이상
-- 연도: order_date가 2024년인 주문만 포함
-- 주문 상태: status = 'completed'
-- 고객 단위 집계 필요
-- 결과는 VIP 고객 수 1개 숫자로 출력(컬럼명: vip_customer_count)

WITH total_amount_CTE AS 
(
SELECT
	o.order_id,
	SUM(oi.quantity*oi.price) AS total_amount
FROM 
	orders o 
	JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
	o.order_id
)


SELECT
	COUNT(DISTINCT o.customer_id) AS vip_customer_count
FROM
	orders o
	JOIN total_amount_CTE ta ON o.order_id = ta.order_id
WHERE
	YEAR(o.order_date) = 2024 AND
	o.status = 'completed'
GROUP BY
	o.customer_id
HAVING
	COUNT(DISTINCT o.order_id) >= 3 AND
	SUM(ta.total_amount) >= 500000