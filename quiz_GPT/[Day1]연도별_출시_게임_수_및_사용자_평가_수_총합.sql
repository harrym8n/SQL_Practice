-- GPT 출제
-- [문제 3] 연도별 출시 게임 수 및 사용자 평가 수 총합
-- games 테이블에서 연도별로 출시된 게임 수와 총 사용자 평가 수(user_count)를 구하시오.
-- 단, 연도(year)는 오름차순 정렬하고, 사용자 평가 수가 NULL인 게임은 제외하시오.

SELECT
  year,
  COUNT(DISTINCT game_id) as game_cnt,
  SUM(user_count) AS sum_user_cnt
FROM 
  games
WHERE
  user_count IS NOT NULL
GROUP BY
  year
ORDER BY
  year