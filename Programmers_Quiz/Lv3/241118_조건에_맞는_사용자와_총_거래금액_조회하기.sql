# 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회
# 결과는 총거래금액을 기준으로 오름차순 정렬

SELECT ugu.USER_ID, ugu.NICKNAME, SUM(ugb.PRICE) as TOTAL_SALES
FROM USED_GOODS_BOARD ugb, USED_GOODS_USER ugu
WHERE ugb.WRITER_ID = ugu.USER_ID AND ugb.STATUS ='DONE'
GROUP BY ugu.USER_ID
HAVING SUM(ugb.PRICE) >= 700000
ORDER BY TOTAL_SALES