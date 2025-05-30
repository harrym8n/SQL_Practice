-- GPT 출제
-- 상품 이름, 지역, 평균 평점을 기준으로 2024년에 예약이 확인된(confirmed) 국내 숙박 상품 중,
-- 리뷰 평점이 가장 높은 상위 3개를 조회하는 SQL 쿼리를 작성
-- 리뷰 1건 이상 + 평균평점은 소수점 둘째 자리까지 반올림, 평점기준 내림차순 정렬

-- <설계한 논리>
-- 1. trips, bookings JOIN해서 상품유형 '숙박', 지역 '국내', 예약년도 '2024', 예약상태 'confirmed' 숙박상품 테이블 생성
-- 2. reviews에서 trip_id로 groupby해서 리뷰 1건 이상인 여행상품의 평균평점 집계
-- 3. 위 두 테이블 JOIN해서 최종 결과 조회


WITH target_trip AS
(
SELECT
	t.trip_id,
	t.name,
	t.region
FROM
	trips t
	JOIN bookings b ON t.trip_id = b.trip_id
WHERE
	t.category = '숙박' AND
	b.status = 'confirmed' AND
	t.region = '국내' AND
	YEAR(b.booking_date) = 2024
), avg_review_table AS
(
	SELECT
		trip_id,
		ROUND(AVG(rating),2) AS avg_rating
	FROM
		reviews
	GROUP BY
		trip_id
	HAVING
		COUNT(DISTINCT review_id) >= 1
)

SELECT
	tt.name AS trip_name,
	tt.region,
	art.avg_rating
FROM
	target_trip tt
	JOIN avg_review_table art ON tt.trip_id = art.trip_id
ORDER BY
	art.avg_rating DESC LIMIT 3