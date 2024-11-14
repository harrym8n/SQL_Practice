# 2022년 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회
# 출고여부는 2022년 5월 1일까지 출고완료로 이후 날짜는 출고 대기로 미정이면 출고미정으로 출력, 결과는 주문 ID를 기준으로 오름차순 정렬

SELECT ORDER_ID, PRODUCT_ID, DATE_FORMAT(OUT_DATE, '%Y-%m-%d'),
    CASE WHEN OUT_DATE < '2022-05-02 00:00:00' THEN '출고완료'
         WHEN OUT_DATE >= '2022-05-02 00:00:00' THEN '출고대기'
         WHEN OUT_DATE is NULL THEN '출고미정'
         END as '출고여부'
FROM FOOD_ORDER
ORDER BY ORDER_ID