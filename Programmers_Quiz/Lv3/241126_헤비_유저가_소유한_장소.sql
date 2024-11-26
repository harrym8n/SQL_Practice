# "헤비 유저" 공간을 둘 이상 등록한 사람
# 헤비 유저가 등록한 공간의 정보를 아이디 순으로 조회
SELECT p.ID, p.NAME, p.HOST_ID
FROM (SELECT HOST_ID
    FROM PLACES
    GROUP BY HOST_ID
    HAVING COUNT(*) >= 2
    ORDER BY HOST_ID) hi, PLACES p
WHERE hi.HOST_ID = p.HOST_ID
ORDER BY p.ID