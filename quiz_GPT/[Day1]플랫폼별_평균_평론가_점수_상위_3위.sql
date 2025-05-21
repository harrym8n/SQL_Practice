-- GPT 출제
-- [문제 2] 플랫폼별 평균 평론가 점수 상위 3위
-- games, platforms 테이블을 활용하여 플랫폼별로 등록된 게임들의 평균 평론가 점수(critic_score)를 계산하시오.
-- 단, 평균 평론가 수(critic_count)가 10명 이상인 게임만 포함하며, 평균 평론가 점수는 소수점 둘째 자리까지 반올림하시오.
-- 상위 3개 플랫폼의 이름과 평균 평론가 점수를 출력하시오.

SELECT
  plt.name,
  ROUND(AVG(critic_score),2) AS avg_critic_score
FROM 
  games gm, platforms plt
WHERE
  gm.platform_id = plt.platform_id AND
  gm.critic_count >= 10
GROUP BY
  gm.platform_id
ORDER BY
  avg_critic_score DESC LIMIT 3