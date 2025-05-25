-- GPT 출제
-- 최근 6개월 간 가장 많이 출금한 고객 TOP 5

-- transactions, accounts, customers 테이블을 활용
-- 최근 6개월 이내에 ‘출금(withdrawal)’ 거래 총액이 가장 많은 고객 상위 5명의 이름, 총 출금 금액
-- 출금액 기준으로 내림차순 정렬


SELECT
	c.name AS customer_name,
	SUM(t.amount) AS sum_amount
FROM
	accounts a
JOIN transactions t ON a.account_id = t.account_id
JOIN customers c ON a.customer_id = c.customer_id
WHERE
	t.transaction_type = 'withdrawal' AND
	t.transaction_date >= CURDATE() - INTERVAL 6 MONTH
GROUP BY
	c.customer_id, c.name
ORDER BY
	sum_amount DESC LIMIT 5