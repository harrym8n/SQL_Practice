-- chatGPT
-- 기준 연도: order_date가 2024년
-- 주문 상태: status = 'completed'
-- 카테고리별(group by category)로 묶고, 판매 수량 합계 기준으로 상위 1개 상품 조회
-- 결과는 카테고리, 상품 이름, 총 판매 수량으로 출력
-- 동점이 있을 경우 모두 출력

WITH quantity_table AS
(
SELECT
	o.product_id,
	SUM(oi.quantity) AS total_quantity
FROM
	orders o
	JOIN order_items oi ON o.order_id = oi.order_id
WHERE
	o.status = 'completed' AND
	YEAR(o.order_date) = 2024
GROUP BY
	o.product_id
), rank AS
(
SELECT
	p.category,
	p.name,
	qt.total_quantity,
	RANK() OVER(PARTITION BY p.category ORDER BY qt.total_quantity DESC) AS rank_quantity
FROM
	quantity_table qt
	JOIN products p ON qt.product_id = p.product_id
)

SELECT category, name,total_quantity
FROM rank
WHERE rank_quantity = 1