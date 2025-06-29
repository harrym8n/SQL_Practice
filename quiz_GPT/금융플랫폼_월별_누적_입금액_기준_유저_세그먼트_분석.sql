-- chatGPT
-- 유저의 월별 입금 누적 금액을 기준으로 고객을 세그먼트화하고 관리하고자 함

WITH total_amount AS
(
SELECT
	user_id,
	DATE_FORMAT(transaction_date, '%Y-%m') AS month,
	SUM(amount) AS amount
FROM
	transactions
WHERE
 	transaction_date >= '2024-01-01' AND
 	transaction_date < '2024-07-01' AND
 	transaction_type = 'deposit'
), 
cumulative_deposit AS
(
SELECT
	user_id,
	month,
	SUM(amount) OVER(PARTITION BY month ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_sum
FROM
	total_amount
),
segment_label AS
(
SELECT
	user_id,
	month,
	CASE
		WHEN cum_sum >= 1000000 THEN 'High Value'
		WHEN cum_sum >= 500000 THEN 'Mid Value'
		WHEN cum_sum >= 1 THEN 'Low Value'
	END AS segment
FROM
	cumulative_deposit
)

SELECT month, segment, COUNT(DISTINCT user_id) AS user_count
FROM segment_label
GROUP BY month, segment
ORDER BY month, segment