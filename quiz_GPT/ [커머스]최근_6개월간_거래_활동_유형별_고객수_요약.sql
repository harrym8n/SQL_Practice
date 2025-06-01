-- GPT  출제
-- 최근 6개월 동안 거래 활동을 한 고객 중, 입금만 한 고객, 출금만 한 고객, 입금과 출금을 모두 한 고객
-- 세 가지 유형으로 분류하고, 각 유형별 고객 수 산출
-- 분석 기준일: 2024-12-31 (최근 6개월 = 2024-07-01 ~ 2024-12-31)
-- 거래 유형은 transactions.transaction_type 기준
-- 각 고객은 중복 없이 한 유형으로만 분류되어야 함


WITH deposit_customers AS (
    SELECT DISTINCT customer_id
    FROM transactions
    WHERE transaction_type = 'deposit'
      AND transaction_date BETWEEN '2024-07-01' AND '2024-12-31'
),
withdrawal_customers AS (
    SELECT DISTINCT customer_id
    FROM transactions
    WHERE transaction_type = 'withdrawal'
      AND transaction_date BETWEEN '2024-07-01' AND '2024-12-31'
),
all_customers AS (
    SELECT customer_id FROM deposit_customers
    UNION
    SELECT customer_id FROM withdrawal_customers
),
tagged_customers AS (
    SELECT
        ac.customer_id,
        CASE
            WHEN dc.customer_id IS NOT NULL AND wc.customer_id IS NULL THEN '입금만'
            WHEN dc.customer_id IS NULL AND wc.customer_id IS NOT NULL THEN '출금만'
            WHEN dc.customer_id IS NOT NULL AND wc.customer_id IS NOT NULL THEN '입출금모두'
        END AS activity_type
    FROM all_customers ac
    LEFT JOIN deposit_customers dc ON ac.customer_id = dc.customer_id
    LEFT JOIN withdrawal_customers wc ON ac.customer_id = wc.customer_id
)

SELECT
    activity_type,
    COUNT(*) AS customer_count
FROM tagged_customers
GROUP BY activity_type
ORDER BY FIELD(activity_type, '입금만', '출금만', '입출금모두');