# 월별 잡은 물고기의 수와 월을 출력
# 잡은 물고기 수 컬럼명은 FISH_COUNT, 월 컬럼명은 MONTH로
# 결과는 월을 기준으로 오름차순 정렬
# 단, 월은 숫자형태 (1~12) 로 출력하며 9 이하의 숫자는 두 자리로 출력하지 않습니다. 
# 잡은 물고기가 없는 월은 출력하지 않습니다.

SELECT COUNT(*) as FISH_COUNT, MONTH(TIME) as MONTH
FROM FISH_INFO
GROUP BY MONTH(TIME)
ORDER BY MONTH(TIME)