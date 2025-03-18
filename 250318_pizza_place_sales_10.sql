-- 각 피자 종류의 총 수익 계산, 수익이 높은 순서대로 조회
SELECT
	t2.pizza_type_id,
	SUM(t1.quantity * t2.price) AS total_revenue
FROM 
	order_details t1
LEFT JOIN pizzas t2 ON t1.pizza_id = t2.pizza_id
GROUP BY 
	t2.pizza_type_id
ORDER BY
	total_revenue DESC