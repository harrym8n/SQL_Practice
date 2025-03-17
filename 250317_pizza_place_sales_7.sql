-- 가격이 15보다 크면 Expensive, 그렇지 않으면 Affordable로 표시하여 조회

SELECT
	*,
	CASE
		WHEN price > 15 THEN 'Expensive'
		ELSE 'Affordable'
    END AS price_category
FROM
	pizzas