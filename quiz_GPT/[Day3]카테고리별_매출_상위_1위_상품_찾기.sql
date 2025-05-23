-- GPT 생성 문제
-- 카테고리별 매출 상위 1위 상품 찾기
-- 각 상품 카테고리(category)별로, 매출(= 수량 × 단가)이 가장 높은 상품 1개 산출
-- 주문 상태가 completed인 주문만 포함
-- 상품 이름(name), 카테고리, 총 매출을 함께 출력

WITH CTE AS
(
SELECT
	p.name,
	p.category,
	SUM(oi.quantity * oi.price) AS total_sales,
	RANK() OVER(PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.price) DESC) AS sales_rank
FROM
	orders o
JOIN order_items oi ON  o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id 
WHERE o.status = 'completed'
GROUP BY p.product_id, p.category, p.name
)

SELECT 
	name,
	category,
	total_sales
FROM
	CTE
WHERE
	sales_rank = 1