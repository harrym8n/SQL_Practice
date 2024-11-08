# 물고기의 종류 별 물고기의 이름과 잡은 수를 출력
# 물고기의 이름 컬럼명은 FISH_NAME, 잡은 수 컬럼명은 FISH_COUNT로 설정
# 결과는 잡은 수 기준으로 내림차순 정렬

SELECT COUNT(*) as FISH_COUNT, fni.FISH_NAME
FROM FISH_INFO fi, FISH_NAME_INFO fni
WHERE fi.fish_type = fni.fish_type
GROUP BY fni.FISH_NAME
ORDER BY FISH_COUNT desc