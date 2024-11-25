# 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회
# 첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬
# 기본적인 파일경로는 /home/grep/src/ 이며, 게시글 ID를 기준으로 디렉토리가 구분되고, 파일이름은 파일 ID, 파일 이름, 파일 확장자로 구성되도록 출력
# 조회수가 가장 높은 게시물은 하나만 존재

SELECT CONCAT('/home/grep/src/',ugf.BOARD_ID,'/',ugf.FILE_ID,ugf.FILE_NAME,ugf.FILE_EXT) as FILE_PATH
FROM (SELECT BOARD_ID, VIEWS
      FROM USED_GOODS_BOARD
      ORDER BY VIEWS DESC LIMIT 1) ugb, USED_GOODS_FILE ugf
WHERE ugb.BOARD_ID = ugf.BOARD_ID
ORDER BY ugf.FILE_ID DESC