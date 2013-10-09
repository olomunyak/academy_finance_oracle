
-- unique
INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID, BOARD_TIT, BOARD_CTN, BOARD_REGIDATE)
VALUES(BOARD_SEQ.NEXTVAL, 'A', '111', '111', TO_DATE('1999-01-01'));

-- index

-- MEMBER데이터 입력
INSERT INTO MEMBER(MEM_ID, MEM_NAME, MEM_PW)
VALUES('ROLENSE', 'JANIFFER ROLENSE', '12341234');

-- CODE데이터 입력
INSERT INTO CODE(CD_BGCGY, CD_SMCGY, CD_CODENAME, CD_SEQ)
VALUES(2, 2, '광고', 8);

-- BOARD데이터 입력
INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID, BOARD_CGY, BOARD_TIT, BOARD_CTN)
VALUES(BOARD_SEQ.NEXTVAL, 'K', 0, '케빈이야기', '케빈은 12살');

-- UPDATE데이터 수정
UPDATE CODE SET CD_CODECMT = '광고'
WHERE CD_SEQ = 8;

-- SELECT
SELECT *
FROM BOARD B INNER JOIN MEMBER M
                     ON B.MEM_ID = M.MEM_ID
ORDER BY BOARD_TXTNUM DESC;

SELECT B.BOARD_TXTNUM, B.MEM_ID, B.BOARD_CGY, B.BOARD_TIT, B.BOARD_CTN, B.BOARD_REGIDATE, B.BOARD_HITS, RANK() OVER(ORDER BY B.BOARD_TXTNUM ASC) AS RNK
FROM BOARD B INNER JOIN MEMBER M
                     ON B.MEM_ID = M.MEM_ID
ORDER BY RNK DESC;


-- 소분류로 매핑하고 대분류로 필터를 준다. 그렇게 하면 원하는데로 가져다 쓸 수 있다.
-- 쿼리를 짤때는 필터를 선언해놓고(필요한 부분은 다 짜놓고) 불러온다.
-- SELECT에서 가장 중요한 것은 '필요한 부분만 가져다 쓴다'는 것이다.

-- 일반적인 VIEW는 단순한 쿼리를 줄여놓은 것에 불과하다.
-- 긴 쿼리가 한번에 준다.
-- 쿼리를 줄일때 쓰는 방법이 VIEW다.
-- VIEW는 쿼리를 죽이는 역할밖에 안된다. 그냥 쿼리 자체를 미리 저장해 놓은 것이다.
SELECT *
FROM BOARD_LIST;
-- 싱글뷰(일반적으로 보는 단독적인 뷰다.)
-- 싱글뷰는 단순 뷰 기능만 한다.
-- 마테리얼라이즈 뷰(물질뷰, MVIEW) - 테이블같이 실질적으로 공간을 차지하고 있는 뷰다.
-- 사용하면 속도는 확연히 빠르지만 그만큼 저장 공간을 가져간다.
COMMIT;
