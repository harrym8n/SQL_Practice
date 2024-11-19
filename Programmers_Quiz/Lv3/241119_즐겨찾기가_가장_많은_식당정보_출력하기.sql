# 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회 
# 음식 종류를 기준으로 내림차순 정렬

SELECT ri.FOOD_TYPE, ri.REST_ID, ri.REST_NAME, ri.FAVORITES
FROM REST_INFO as ri, (SELECT FOOD_TYPE,MAX(FAVORITES) as FAVORITES
                 FROM REST_INFO
                 GROUP BY FOOD_TYPE) as mf
WHERE ri.FOOD_TYPE = mf.FOOD_TYPE AND
      ri.FAVORITES = mf.FAVORITES
ORDER BY ri.FOOD_TYPE DESC