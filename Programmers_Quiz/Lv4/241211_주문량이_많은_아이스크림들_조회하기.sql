# 7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회
SELECT t1.FLAVOR
FROM FIRST_HALF t1, (SELECT FLAVOR, SUM(TOTAL_ORDER) as TOTAL_ORDER
                     FROM JULY
                     GROUP BY FLAVOR) t2
WHERE t1.FLAVOR = t2.FLAVOR
ORDER BY (t1.TOTAL_ORDER + t2.TOTAL_ORDER) DESC LIMIT 3