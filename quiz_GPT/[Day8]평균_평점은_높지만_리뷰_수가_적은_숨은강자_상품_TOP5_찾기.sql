-- GPT 출제
-- 평점이 높은데도 리뷰 수가 상대적으로 적어 주목받지 못하는 상품을 찾기
-- 1.평균 평점이 4.5 이상
-- 2.리뷰 수가 전체 상품 중 하위 50%에 해당하는 상품
-- 3.해당 조건을 만족하는 상품 중 평점이 높은 순서로 상위 5개 출력

WITH agg_review AS
(
	SELECT
		p.product_id,
		p.name,
		COUNT(DISTINCT review_id) AS cnt_review,
		AVG(r.rating) AS avg_rating
	FROM 
		reviews r
		JOIN products p ON r.product_id = p.product_id
	GROUP BY
		p.product_id, p.name
	HAVING
		AVG(r.rating) >= 4.5
), review_final AS
(
	SELECT
		*,
		PERCENT_RANK() OVER(ORDER BY cnt_review) AS percent
	FROM
		agg_review
)


SELECT
	name,
	avg_rating
FROM
	review_final
WHERE
	percent <= 0.5
ORDER BY
	avg_rating DESC LIMIT 5