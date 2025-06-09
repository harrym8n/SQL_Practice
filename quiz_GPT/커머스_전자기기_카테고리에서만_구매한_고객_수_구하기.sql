-- chatGPT 출제
WITH CTE AS 
(
SELECT
	o.customer_id
FROM
	orders o
	JOIN order_items oi ON o.order_id=p.order_id
	JOIN products p ON oi.product_id=p.product_id
WHERE
	YEAR(o.order_date) = 2024 AND
	o.status='completed'
GROUP BY
	o.customer_id
HAVING
	COUNT(DISTINCT p.category) = 1
), CTE_2 AS
(
SELECT
	o.customer_id
FROM
	orders o
	JOIN order_items oi ON o.order_id=p.order_id
	JOIN products p ON oi.product_id=p.product_id
WHERE
	YEAR(o.order_date) = 2024 AND
	o.status='completed' AND
	p.category = '전자기기'
GROUP BY
	o.customer_id
)

SELECT COUNT(DISTINCT t1.customer_id) AS exclusive_customer_count
FROM CTE t1
JOIN CTE_2 t2 ON t1.customer_id = t2.customer_id