-- 카테고리별 총 판매 수량을 계산, 가장 많이 팔린 카테고리 조회
SELECT
	t3.category,
	SUM(t1.quantity) AS total_quantity
FROM order_details t1
JOIN pizzas t2 ON t1.pizza_id = t2.pizza_id
JOIN pizza_types t3 ON t2.pizza_type_id = t3.pizza_type_id
GROUP BY t3.category
ORDER BY total_quantity DESC LIMIT 1