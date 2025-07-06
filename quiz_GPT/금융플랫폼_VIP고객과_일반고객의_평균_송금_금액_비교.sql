-- chatGPT 출제

WITH user_log AS
(
SELECT
	user_id,
	SUM(amount) AS total_amount
FROM 
	transactions
WHERE
	(transaction_date BETWEEN '2025-04-01' AND '2025-06-30') AND
	transaction_type = 'send'
GROUP BY
	user_id
), segment AS 
(
SELECT
	user_id,
	CASE
		WHEN total_amount >= 1000000 THEN 'VIP'
		ELSE '일반'
	END AS user_segment
FROM
	user_log
), segment_month AS
(
SELECT
	t.user_id,
	t.transaction_date,
	t.amount,
	s.user_segment
FROM
	transactions t 
	LEFT JOIN segment s ON t.user_id = s.user_id
WHERE
	(t.transaction_date BETWEEN '2025-04-01' AND '2025-06-30') AND
	t.transaction_type = 'send'
)

SELECT
	user_segment,
	FORMAT(transaction_date, '%Y-%m') AS month,
	ROUND(AVG(amount),2) AS avg_send_amount
FROM
	segment_month
GROUP BY
	user_segment,
	FORMAT(transaction_date, '%Y-%m')
ORDER BY
	user_segment,
	FORMAT(transaction_date, '%Y-%m')