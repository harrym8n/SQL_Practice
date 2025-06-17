-- 2024년 한 해 동안 completed 상태의 주문을 기준
-- 고객 분할(주문 5회 이상 또는 총 구매 금액이 1,000,000원 이상/ 그외)
-- 각 그룹별로 평균 구매 금액

WITH CTE AS 
(
SELECT
	o.customer_id,
	COUNT(DISTINCT o.order_id) AS order_cnt,
	SUM(oi.quantity*oi.price) AS total_amount
FROM
	orders o 
	JOIN order_items oi ON o.order_id = oi.order_id
WHERE
	YEAR(o.order_date) = 2024 AND
	o.status = 'completed'
GROUP BY
	o.customer_id
)


SELECT
	CASE
		WHEN order_cnt >= 5 OR total_amount >= 1000000 THEN 'VIP'
		ELSE 'General'
	END AS customer_type,
	AVG(total_amount) AS avg_total_amount
FROM
	CTE
GROUP BY
	customer_type