# 17세 미만 아동이 혼자 와서 볼 수 없는 영화 중 모음으로 끝나지 않는 영화 조회

SELECT
  title
FROM
  film
WHERE
  rating IN('NC-17', 'R')
  AND title NOT LIKE '%A'
  AND title NOT LIKE '%E'
  AND title NOT LIKE '%I'
  AND title NOT LIKE '%O'
  AND title NOT LIKE '%U'