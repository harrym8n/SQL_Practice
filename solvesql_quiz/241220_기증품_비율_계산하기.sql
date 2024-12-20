-- (ORACLE) 소장품 중 부분 기증품을 포함한 기증품의 비율이 얼마나 되는지 계산
-- 기증품의 비율은 백분율로 계산
-- 소수점 아래 넷째 자리에서 반올림 해 셋째 자리까지 표시 


-- 풀이1. with as 절로 테이블 2개 만들어서 비율 구하기
with
  gift_t as (
    SELECT
      COUNT(*) as data
    FROM
      artworks
    WHERE
      credit LIKE '%gift%'
  ),
  whole_t as (
    SELECT
      COUNT(*) as data
    FROM
      artworks
  )
SELECT
  ROUND(((
        CAST((SUM(IFNULL(t1.data, 0))) as float) / 
        SUM(IFNULL(t2.data, 0))) * 100),3) as ratio
FROM
  gift_t t1 FULL OUTER
  JOIN whole_t t2 ON t1.data = t2.data


  -- 풀이2. 단순 서브쿼리 이용
SELECT
  ROUND(
    ((
      (SELECT COUNT(*)
      FROM artworks
      WHERE credit LIKE '%gift%')*1.0 / COUNT(*))*100)
      ,3) as ratio
  FROM artworks
