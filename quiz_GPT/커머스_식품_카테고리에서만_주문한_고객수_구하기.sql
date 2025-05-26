WITH customer_order_category AS (
    SELECT
        c.customer_id,
        p.category
    FROM
        customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE
        o.status = 'completed'
        AND YEAR(o.order_date) = 2024
    GROUP BY
        c.customer_id,
        p.category
)

SELECT
    COUNT(DISTINCT customer_id) AS pure_food_customer_count
FROM
    customer_order_category
GROUP BY
    customer_id
HAVING
    COUNT(DISTINCT category) = 1
    AND MAX(category) = '식품'