-- 코드를 입력하세요
SELECT ugb.title, ugb.board_id, ugr.reply_id, ugr.writer_id, ugr.contents, DATE_FORMAT(ugr.created_date,'%Y-%m-%d')
FROM used_goods_board ugb, used_goods_reply ugr
WHERE ugb.board_id = ugr.board_id AND
      ugb.created_date LIKE '2022-10%'
ORDER BY ugr.created_date, ugb.title