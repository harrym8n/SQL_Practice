-- chatGPT 출제
-- 월별 순입금 분석 및 음수 잔고 유저 수 확인

WITH user_amount AS
(
SELECT
	DATE_FORMAT(transaction_date, '%Y-%m') AS month,
	user_id,
	SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) AS total_deposit,
	SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS total_withdrawal
FROM
	transactions
WHERE
	transaction_date >= '2024-01-01' AND 
	transaction_date < '2024-07-01'
GROUP BY
	user_id,
	DATE_FORMAT(transaction_date, '%Y-%m')
)

SELECT month, COUNT(DISTINCT user_id) AS negative_balance_users
FROM user_amount
WHERE total_deposit - total_withdrawal < 0
GROUP BY month
ORDER BY month