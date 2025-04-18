WITH CTE AS
(
SELECT 
	author, year,
	LEAD(year,1) OVER (PARTITION BY author ORDER BY author, year) AS next,
	(LEAD(year,1) OVER (PARTITION BY author ORDER BY author, year) - year) AS diff
FROM 
	books
WHERE
	genre = 'Fiction'
GROUP BY 
	author, year
ORDER BY
	author, year
)

SELECT 
	author, MAX(next) as year, (sum(diff)+1) as depth
FROM 
	CTE
WHERE 
	diff =1
GROUP BY 
	author
HAVING 
	sum(diff) >=4