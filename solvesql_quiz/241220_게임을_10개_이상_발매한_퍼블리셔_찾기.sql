-- 퍼블리셔로 참여한 게임이 10개 이상인 회사의 이름을 출력(ORACLE)

SELECT t1.name
FROM companies t1, games t2
WHERE t1.company_id = t2.publisher_id
GROUP BY t1.name
HAVING COUNT(t2.game_id) >= 10