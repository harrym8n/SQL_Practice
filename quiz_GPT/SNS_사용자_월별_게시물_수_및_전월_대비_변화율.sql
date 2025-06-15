-- chatGPT 출제
-- 2024년 데이터 기반 월별 총 게시물 수와 전월 대비 게시물 수 변화율(%)을 계산해 출력
WITH CTE AS 
(
SELECT
	DATE_FORMAT(post_date, '%Y-%m') AS post_month,
	COUNT(DISTINCT post_id) AS total_posts
FROM
	posts
WHERE
	YEAR(post_date) = 2024
GROUP BY
	DATE_FORMAT(post_date, '%Y-%m')
ORDER BY
	post_month
)

SELECT
	post_month,
	total_posts,
	LAG(total_posts) OVER(ORDER BY post_month) AS prev_month_posts,
	ROUND(
		CASE
			WHEN LAG(total_posts) OVER(ORDER BY post_month) IS NULL THEN NULL
			WHEN LAG(total_posts) OVER(ORDER BY post_month) = 0 THEN NULL
			ELSE (total_posts - LAG(total_posts) OVER(ORDER BY post_month))/
			LAG(total_posts) OVER(ORDER BY post_month) * 100
		END, 2) AS post_growth_rate
FROM 
	CTE
ORDER BY
	post_month
