-- chatGPT 출제

WITH base AS
(
SELECT
	FORMAT(transaction_date, 'yyyy-MM-DD') AS transaction_date,
	SUM(amount) AS total_send_amount
FROM
	transactions
WHERE
	(transaction_date BETWEEN '2025-06-01' AND '2025-06-30') AND
	transaction_type='send'
GROUP BY
	FORMAT(transaction_date, 'yyyy-MM-DD')
), lag_base AS
(
SELECT
	transaction_date,
	total_send_amount,
	LAG(total_send_amount) OVER(ORDER BY transaction_date) AS prev_amount
FROM
	base
)

SELECT
	transaction_date,
	total_send_amount,
	ROUND(((total_send_amount - prev_amount) * 1.0 / prev_amount) * 100, 2) AS 'day_over_day_change (%)',
	CASE 
		WHEN ABS((total_send_amount - prev_amount) * 1.0 / prev_amount)>=0.3 THEN 'Y'
		ELSE 'N'
	END AS is_anomaly
FROM 
	lag_base
WHERE
	prev_amount IS NOT NULL
ORDER BY
	transaction_date