# 도서정보 테이블(BOOK), 저자정보 테이블(AUTHOR)
# '경제' 카테고리에 속하는 도서들의 도서 ID(BOOK_ID), 저자명(AUTHOR_NAME), 출판일(PUBLISHED_DATE) 리스트를 출력
# 결과는 출판일을 기준으로 오름차순 정렬

SELECT b.BOOK_ID, a.AUTHOR_NAME, DATE_FORMAT(b.PUBLISHED_DATE, '%Y-%m-%d') as PUBLISHED_DATE
FROM BOOK b, AUTHOR a
WHERE b.AUTHOR_ID = a.AUTHOR_ID AND CATEGORY = '경제'
ORDER BY PUBLISHED_DATE