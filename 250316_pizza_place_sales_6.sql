-- 각 카테고리의 평균 피자 종류 개수 산출
SELECT
	AVG(t.pizza_type_cnt) AS avg_pizza_type_cnt
FROM 
	(SELECT category, COUNT(DISTINCT pizza_type_id) AS pizza_type_cnt
	FROM pizza_types 
	GROUP BY category) t;