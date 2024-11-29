# 더 이상 업그레이드할 수 없는 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력
# 아이템 ID를 기준으로 내림차순 정렬           

SELECT item_id, item_name, rarity
FROM ITEM_INFO
WHERE item_id NOT IN (SELECT DISTINCT PARENT_ITEM_ID as item_id
                      FROM ITEM_TREE
                      WHERE PARENT_ITEM_ID is NOT NULL)
ORDER BY item_id DESC