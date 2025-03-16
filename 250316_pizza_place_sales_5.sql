-- 피자별 총 수익 산출

SELECT
	t1.pizza_id,
	SUM(t1.quantity * t2.price) AS total_revenue
FROM 
	order_details t1, pizzas t2
WHERE 
	t1.pizza_id = t2.pizza_id
GROUP BY 