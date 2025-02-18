WITH tmp AS
(
SELECT
  t1.NAME,
  CASE
    WHEN t2.name in  ('PS3', 'PS4', 'PSP', 'PSV') THEN 'Sony'
    WHEN t2.name in  ('Wii', 'WiiU', 'DS', '3DS') THEN 'Nintendo'
    WHEN t2.name in  ('X360', 'XONE') THEN 'Microsoft'
  END as platform_classification
FROM
  games t1,
  platforms t2
WHERE
  t1.platform_id = t2.platform_id AND
  t1.year >= 2012
)

SELECT DISTINCT name as name
FROM tmp
GROUP BY name
HAVING count(DISTINCT platform_classification) >= 2