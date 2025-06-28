-- chatGPT 출제

WITH total_amount AS
(
SELECT
	user_id,
	SUM(amount) AS sum_amount
FROM
	transactions
WHERE
	transaction_date >= '2024-01-01' AND
	transaction_date < '2024-07-01' AND
	transaction_type = 'deposit'
GROUP BY
	user_id
), segment AS
(
SELECT
	user_id,
	CASE
		WHEN sum_amount >= 1000000 THEN 'High'
		WHEN sum_amount >= 500000 THEN 'Medium'
		WHEN sum_amount >= 1 THEN 'Low'
	END AS segment
FROM
	total_amount
)

SELECT segment, COUNT(DISTINCT user_id) AS user_count
FROM segment
GROUP BY segment