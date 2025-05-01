SELECT
	warehouse_id, warehouse_name, address, IFNULL(freezer_YN, 'N')
FROM
	food_warehouse
WHERE
	address like '경기도%'
ORDER BY
	warehouse_id