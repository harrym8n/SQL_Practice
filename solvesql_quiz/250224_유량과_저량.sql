-- 연도별로 새롭게 소장하게 된 작품의 수
-- 연도별 누적 소장 작품 수를 계산하여 조회

SELECT
  STRFTIME('%Y', acquisition_date) as 'Acquisition year',
  COUNT(artwork_id) as 'New acquisitions this year (Flow)',
  SUM(COUNT(artwork_id)) OVER (ORDER BY STRFTIME('%Y', acquisition_date)) as 'Total collection size (Stock)'
FROM
  artworks
WHERE
  STRFTIME('%Y', acquisition_date) is not null
GROUP BY
  STRFTIME('%Y', acquisition_date)