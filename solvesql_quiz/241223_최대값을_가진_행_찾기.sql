-- 가장 큰 x 값을 가지는 데이터와 가장 큰 y 값을 가지는 데이터의 id를 출력
-- 오름차순 정렬

SELECT
  t1.id
FROM 
  points t1,
  (SELECT id, MAX(x) as x FROM points) t2,
  (SELECT id, MAX(y) as x FROM points) t3
WHERE
  t1.id = t2.id OR
  t1.id = t3.id
ORDER BY
  t1.id