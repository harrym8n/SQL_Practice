-- [문제 5] 개발사별 평균 사용자 점수 TOP 5
-- games와 companies 테이블을 조인하여, 개발사(developer)의 평균 사용자 점수(user_score)가 높은 상위 5개 개발사를 출력하시오.
-- 단, 사용자 수(user_count)가 1000명 이상인 게임만 포함하고, 평균 사용자 점수는 소수 둘째 자리까지 반올림하시오.

SELECT
  c.name AS company_name,
  ROUND(AVG(gm.user_score),2) as avg_user_score
FROM 
  games gm,
  companies c
WHERE
  gm.developer_id = c.company_id AND
  gm.user_count >= 1000
GROUP BY
  gm.developer_id
ORDER BY  
  avg_user_score DESC LIMIT 5