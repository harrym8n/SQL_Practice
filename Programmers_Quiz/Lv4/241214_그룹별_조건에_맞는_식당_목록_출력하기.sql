# 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회
# 회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성
# 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬
SELECT t3.MEMBER_NAME, t5.REVIEW_TEXT, DATE_FORMAT(t5.REVIEW_DATE, '%Y-%m-%d') as REVIEW_DATE
FROM MEMBER_PROFILE t3,(SELECT t1.MEMBER_ID
                        FROM (SELECT MEMBER_ID, COUNT(*) as COUNT
                              FROM REST_REVIEW
                              GROUP BY MEMBER_ID) as t1
                        WHERE t1.COUNT = (SELECT MAX(COUNT) 
                                          FROM (SELECT MEMBER_ID, COUNT(*) as COUNT
                                                FROM REST_REVIEW
                                                GROUP BY MEMBER_ID) t2))t4,
     REST_REVIEW t5 
WHERE t3.MEMBER_ID = t4.MEMBER_ID AND t4.MEMBER_ID = t5.MEMBER_ID
ORDER BY t5.REVIEW_DATE, t5.REVIEW_TEXT