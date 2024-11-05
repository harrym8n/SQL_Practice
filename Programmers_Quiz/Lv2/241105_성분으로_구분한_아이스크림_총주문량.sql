# 상반기 동안 각 아이스크림 성분 타입과 성분 타입에 대한 아이스크림의 총주문량 조회
# 총주문량이 작은 순서대로 정렬
# 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정

SELECT ii.INGREDIENT_TYPE, SUM(fh.TOTAL_ORDER) as TOTAL_ORDER
FROM FIRST_HALF as fh, ICECREAM_INFO as ii
WHERE fh.FLAVOR = ii.FLAVOR
GROUP BY ii.INGREDIENT_TYPE
ORDER BY fh.TOTAL_ORDER