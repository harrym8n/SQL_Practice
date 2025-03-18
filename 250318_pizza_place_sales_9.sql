-- 각 피자 타입의 재료가 몇 가지인지 조회

SELECT
	pizza_type_id,
	(CHAR_LENGTH(ingredients) - CHAR_LENGTH(REPLACE(ingredients,",","")) +1) AS type_ingredients_cnt
FROM 
	pizza_types
ORDER BY
	pizza_type_id