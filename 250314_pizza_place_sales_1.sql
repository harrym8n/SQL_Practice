-- pizza_id의 길이가 10 미만인 피자 조회
SELECT 
	DISTINCT pizza_id
FROM 
	order_details
WHERE 
	pizza_id IN 
		(SELECT pizza_id
		FROM pizzas 
		WHERE size < 10)