SELECT
	book_id, DATE_FORMAT(published_date,'%Y-%m-%d')
FROM
	book
WHERE
	published_date like '2021%' and category = '인문'
ORDER BY
	published_date