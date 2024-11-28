# 평균 길이가 33cm 이상인 물고기들을 종류별로 분류하여 잡은 수, 최대 길이, 물고기의 종류를 출력
# 결과는 물고기 종류에 대해 오름차순으로 정렬
# 10cm이하의 물고기들은 10cm로 취급하여 평균 길이를 구해주세요.
# 컬럼명은 물고기의 종류 'FISH_TYPE', 잡은 수 'FISH_COUNT', 최대 길이 'MAX_LENGTH'


SELECT COUNT(*) as FISH_COUNT, MAX(t1.LENGTH) as MAX_LENGTH, t1.FISH_TYPE
FROM (SELECT IFNULL(LENGTH, 10) as LENGTH, ID, TIME, FISH_TYPE
      FROM FISH_INFO) as t1
GROUP BY t1.FISH_TYPE
HAVING AVG(t1.LENGTH) >= 33
ORDER BY t1.FISH_TYPE