SELECT 
	pt_name, pt_no, gend_cd, age, COALESCE(tlno,'NONE')as tlno
FROM 
	patient
WHERE 
	age<=12 and gend_cd = 'W'
ORDER BY 
	age DESC, pt_name