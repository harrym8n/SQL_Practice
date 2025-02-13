-- 2000년 이후의 메달 수상 기록만 고려했을 때, 메달을 수상한 올림픽 참가 선수 중 2개 이상의 국적으로 메달을 수상한 기록이 있는 선수의 이름을 조회

SELECT
  t3.name
FROM
  records t1, games t2, athletes t3
WHERE
  t1.game_id = t2.id AND
  t1.athlete_id = t3.id AND
  t2.year >= 2000 AND 
  t1.medal IS NOT NULL
GROUP BY
  t1.athlete_id
HAVING
  COUNT(DISTINCT t1.team_id) >= 2
ORDER BY
  t3.name