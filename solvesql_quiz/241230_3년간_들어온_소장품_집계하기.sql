-- 각 분류에 대해 연도별 추가된 소장품 수를 집계하는 쿼리를 작성
-- 각 행은 분류(classification) 컬럼 기준으로 오름차순 정렬
-- 집계하는 3년간 추가된 특정 분류의 소장품이 없더라도 해당 분류와 집계 내역을 결과 테이블에서 누락시키지 말고 포함

WITH whole_t as
(
SELECT classification
FROM artworks
GROUP BY classification
),

t_2014 as
(
SELECT classification, COUNT(*) as 'a'
FROM artworks
WHERE acquisition_date LIKE '2014-%'
GROUP BY classification
ORDER BY 1
),

t_2015 as
(
SELECT classification, COUNT(*) as 'b'
FROM artworks
WHERE acquisition_date LIKE '2015-%'
GROUP BY classification
ORDER BY 1
),

t_2016 as
(
SELECT classification, COUNT(*) as 'c'
FROM artworks
WHERE acquisition_date LIKE '2016-%'
GROUP BY classification
ORDER BY 1
)

SELECT t1.classification, IFNULL(t2.a,0) as '2014', IFNULL(t3.b,0) as '2015', IFNULL(t4.c, 0) as '2016'
FROM whole_t t1
LEFT OUTER JOIN t_2014 t2 ON t1.classification = t2.classification
LEFT OUTER JOIN t_2015 t3 ON t1.classification = t3.classification
LEFT OUTER JOIN t_2016 t4 ON t1.classification = t4.classification