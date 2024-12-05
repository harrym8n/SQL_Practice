# 2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역을 조회하는 SQL문을 작성
# 진료예약번호, 환자이름?, 환자번호, 진료과코드, 의사이름?, 진료예약일시 항목이 출력
# 결과는 진료예약일시를 기준으로 오름차순 정렬

SELECT t2.APNT_NO, t1.PT_NAME, t2.PT_NO, t2.MCDP_CD, t2.DR_NAME, t2.APNT_YMD
FROM PATIENT as t1, (SELECT a.APNT_NO, a.PT_NO, a.MCDP_CD, a.MDDR_ID, d.DR_NAME, a.APNT_YMD
                  FROM APPOINTMENT a, DOCTOR d
                  WHERE a.MDDR_ID = d.DR_ID AND
                  DATE_FORMAT(a.APNT_YMD,'%Y-%m-%d') = '2022-04-13' AND
                  a.APNT_CNCL_YN = 'N' AND
                  a.MCDP_CD = 'CS') as t2
WHERE t1.PT_NO = t2.PT_NO
ORDER BY t2.APNT_YMD asc