-- Query the median of the Northern Latitudes (LAT_N) from STATION
-- Round result to 4 decimal places

SELECT
  ROUND(t.LAT_N, 4)
FROM 
  (SELECT LAT_N, ROW_NUMBER() OVER(ORDER BY LAT_N) as rnk 
   FROM STATION) t
WHERE 
  t.rnk = ((SELECT ROW_NUMBER() OVER(ORDER BY LAT_N DESC) as rnk 
			FROM STATION 
			ORDER BY rnk DESC LIMIT 1)+1)/2