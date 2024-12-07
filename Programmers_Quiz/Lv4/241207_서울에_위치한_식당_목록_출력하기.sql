# 서울에 위치한 식당들의 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회
# 리뷰 평균점수는 소수점 세 번째 자리에서 반올림 해주시고 결과는 평균점수를 기준으로 내림차순 정렬
# 평균점수가 같다면 즐겨찾기수를 기준으로 내림차순 정렬

SELECT t1.REST_ID, t1.REST_NAME, t1.FOOD_TYPE, t1.FAVORITES, t1.ADDRESS, t2.SCORE
FROM REST_INFO t1, (SELECT REST_ID, ROUND(AVG(REVIEW_SCORE),2) as SCORE
                    FROM REST_REVIEW
                    GROUP BY REST_ID) t2
WHERE t1.REST_ID = t2.REST_ID AND
      t1.ADDRESS LIKE '서울%'
ORDER BY t2.SCORE DESC, t1.FAVORITES DESC