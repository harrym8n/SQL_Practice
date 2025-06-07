-- chatGPT 출제
-- 2025년 6월 1일 기준, 최근 3개월(3/1 ~ 5/31) 동안의 구매 이력을 바탕으로 고객을 다음과 같이 3가지 그룹으로 나눠주세요.
-- ‘충성 고객’: 최근 3개월간 3회 이상 구매 AND 총 구매금액 ≥ 300,000원
-- ‘일반 고객’: 최근 3개월간 1~2회 구매
-- ‘이탈 고객’: 최근 3개월간 구매 0회

WITH agg_order AS 
(
SELECT
	customer_id,
	COUNT(DISTINCT order_id) AS order_cnt,
	SUM(amount) AS sum_amount
FROM
	orders
WHERE
	(status = 'completed') AND
	(DATE_FORMAT(order_date, '%Y-%m-%d') BETWEEN '2025-03-01' AND '2025-05-31')
GROUP BY
	customer_id
), segment_table AS
(
SELECT
	c.customer_id,
	CASE 
		WHEN ao.order_cnt >= 3 AND ao.sum_amount >= 300000 THEN '충성 고객'
		WHEN ao.order_cnt >= 1 THEN '일반 고객'
		ELSE '이탈 고객'
	END AS group_type
FROM
	customers c
	LEFT JOIN agg_order ao ON c.customer_id = ao.customer_id
)

SELECT group_type, COUNT(DISTINCT customer_id) AS customer_count
FROM segment_table
GROUP BY group_type