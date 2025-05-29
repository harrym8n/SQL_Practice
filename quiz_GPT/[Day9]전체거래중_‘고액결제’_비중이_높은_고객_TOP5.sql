-- chatGPT 출제
-- 고액 결제를 자주 하는 고객을 식별하자. 고액 결제는 단건 결제 금액이 100만 원 이상인 거래로 정의한다.
-- 전체 거래 수 대비 고액 결제 비율이 높은 고객을 찾아, 비율 기준 내림차순 정렬 후 TOP 5를 출력

WITH tx_summary AS (
    SELECT
        c.customer_id,
        c.name,
        COUNT(t.transaction_id) AS total_tx,
        SUM(CASE WHEN t.amount >= 1000000 THEN 1 ELSE 0 END) AS high_value_tx
    FROM customers c
    JOIN transactions t ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, c.name
)

SELECT
    name,
    total_tx,
    high_value_tx,
    ROUND((high_value_tx / total_tx), 2) AS high_value_ratio
FROM tx_summary
ORDER BY high_value_ratio DESC LIMIT 5