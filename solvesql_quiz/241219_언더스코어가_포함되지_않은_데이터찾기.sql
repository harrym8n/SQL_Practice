# page_location 컬럼의 값이 언더스코어('_')를 포함하지 않는 경우만 출력 
# page_location 컬럼만 있어야 하고, 중복되는 값은 1번만 출력
# page_location 로 오름차순 출력

SELECT DISTINCT page_location
FROM ga
WHERE page_location NOT LIKE '%#_%' ESCAPE '#'
ORDER BY page_location