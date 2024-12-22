-- 2015년 이후에 발매한 게임 중 누락된 평점 정보가 있는 게임에 대해서 같은 장르를 가진 전체 게임의 평균 평점과 평균 평론가/사용자 수를 사용해 누락된 정보를 채우는 쿼리
-- 쿼리 결과에는 누락된 평점 정보가 있는 게임만 포함
-- 평론가와 사용자 평점 평균은 소수점 아래 넷째 자리에서 반올림 해 셋째 자리까지 출력되어야 하고, 사용자 수는 올림하여 자연수로 출력

WITH average_t AS
(
SELECT genre_id, ROUND(AVG(critic_score),3) as avg_critic_score, 
        CEIL(AVG(critic_count)) as avg_critic_count, 
        ROUND(AVG(user_score),3) as avg_user_score, 
        CEIL(AVG(user_count)) as avg_user_count
FROM games
GROUP BY genre_id
)

SELECT t1.game_id, t1.name, 
       IFNULL(t1.critic_score, t2.avg_critic_score) as critic_score, 
       IFNULL(t1.critic_count, t2.avg_critic_count) as critic_count,
       IFNULL(t1.user_score, t2.avg_user_score) as user_score, 
       IFNULL(t1.user_count, t2.avg_user_count) as user_count
FROM games t1 INNER JOIN average_t t2
ON t1.genre_id = t2.genre_id
WHERE t1.year >= 2015 AND
      (t1.critic_score IS NULL OR
      t1.user_score IS NULL)