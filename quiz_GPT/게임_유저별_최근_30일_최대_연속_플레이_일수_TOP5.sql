-- chatGPT
-- 고객별 재구매 여부 및 전체 재구매율 계산


WITH customer_order AS
(
SELECT
	c.customer_id,
	COUNT(DISTINCT o.order_id) AS cnt_order
FROM
	customers c
	LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE
	YEAR(o.order_date) = 2024 AND
	o.status = 'completed'
), segment AS
(
SELECT
	customer_id,
	CASE 
		WHEN cnt_order = 1 THEN 'once'
		WHEN cnt_order >= 2 THEN 'twice'
	END AS segment_name
FROM
	customer_order
) ratio AS
(
SELECT
	COUNT(DISTINCT customer_id) AS total_customers,
	(SELECT COUNT(DISTINCT customer_id) FROM segment WHERE segment_name = 'twice') AS repeat_customers
FROM
	segment
)

SELECT *, ROUND((repeat_customers/total_customers)*100, 2) AS repeat_rate
FROM ratio