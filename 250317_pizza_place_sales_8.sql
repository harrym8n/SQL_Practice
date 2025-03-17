-- 날짜별로 피자 주문 건수와 총 주문 수량 조회
SELECT
	t1.date,
    COUNT(DISTINCT t1.order_id) AS pizza_order_cnt,
    SUM(t2.quantity) AS sum_quantity
FROM 
	orders t1,
    order_details t2
WHERE
	t1.order_id = t2.order_id
GROUP BY
	t1.date
ORDER BY
	t1.date