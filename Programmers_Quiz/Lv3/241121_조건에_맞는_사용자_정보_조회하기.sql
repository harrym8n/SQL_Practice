# 중고 거래 게시물을 3건 이상 등록한 사용자의 사용자 ID, 닉네임, 전체주소, 전화번호를 조회
# 전체 주소는 시, 도로명 주소, 상세 주소 함께 출력
# 전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력
# 결과는 회원 ID를 기준으로 내림차순 정렬

SELECT ugu.USER_ID, ugu.NICKNAME, CONCAT(ugu.CITY, ' ',ugu.STREET_ADDRESS1,' ', ugu.STREET_ADDRESS2) as '전체주소', CONCAT(SUBSTR(ugu.TLNO,1,3),'-',SUBSTR(ugu.TLNO,4,4),'-',SUBSTR(ugu.TLNO,8,4)) as '전화번호'
FROM USED_GOODS_BOARD ugb, USED_GOODS_USER ugu
WHERE ugb.WRITER_ID = ugu.USER_ID
GROUP BY ugu.USER_ID
HAVING COUNT(ugb.BOARD_ID) >= 3
ORDER BY ugu.USER_ID DESC