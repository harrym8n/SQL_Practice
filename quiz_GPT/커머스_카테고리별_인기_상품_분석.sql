-- chatGPT
-- 2024년 한 해 동안 판매된 상품들 중, 카테고리별로 판매 수량이 가장 높은 상품을 1개씩 조회
-- 기간: 2024년 (YEAR(order_date) = 2024)
-- 조건: orders.status = 'completed'
-- 기준: category 별 총 판매 수량(quantity) 합산
-- 출력: category, product_name, total_quantity

WITH CTE AS 
(
SELECT
	p.category,
	p.name AS product_name,
	SUM(oi.quantity) AS total_quantity
FROM
	orders o 
	JOIN order_items oi ON o.order_id = oi.order_id
	JOIN products p ON oi.product_id = p.product_id
WHERE
	YEAR(o.order_date) = 2024 AND
	o.status = 'completed'
GROUP BY
	p.category,
	p.name
), rank_CTE AS
(
SELECT
	category,
	product_name,
	total_quantity,
	DENSE_RANK() OVER(PARTITION BY category ORDER BY total_quantity) AS rnk
FROM
	CTE
)

SELECT category, product_name, total_quantity
FROM rank_CTE
WHERE rnk = 1