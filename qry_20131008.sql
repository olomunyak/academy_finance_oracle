
-- SEQUENCE
-- 현재 숫자 획득
SELECT BOARD_SEQ.CURRVAL
FROM DUAL;

-- 다음 숫자 획득
SELECT BOARD_SEQ.NEXTVAL
FROM DUAL;

-- INSERT
INSERT INTO MEMBER(MEM_ID, MEM_NAME, MEM_PW) 
VALUES('A', 'A', '1234');

-- TRANSACTION
-- 마지막 적용시점까지 돌아간다.
ROLLBACK;

-- 현재 작업을 적용시킨다.
COMMIT;

INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID ,BOARD_TIT, BOARD_CTN)
VALUES(BOARD_SEQ.NEXTVAL, 'A', '이게 성공하면', '쉽시다');

SELECT B.BOARD_TXTNUM, B.MEM_ID, B.BOARD_TIT, B.BOARD_CTN, 
       B.BOARD_REGIDATE, B.BOARD_HITS
FROM BOARD B INNER JOIN MEMBER M
                     ON B.MEM_ID = M.MEM_ID;

-- VALUES에 서브쿼리도 들어갈수 있다. 
-- 데이터가 아니기 때문에 VALUES는 제거한다.
-- INSERT INTO 에서 서브쿼리를 쓸때는 VALUES를 빼 줘야 한다.
-- 갯수와 타입만 맞으면 다 들어갈수 있다.
INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID ,BOARD_TIT, BOARD_CTN)
(SELECT BOARD_SEQ.NEXTVAL, 'A', '이게 성공하면2', '쉽시다.2'
       FROM DUAL);
-- DATA이관 3단계 - ETL
-- 1. E EXTRACT(추출)
-- 2. T TRANSFORM(변환)
-- 3. L LOAD(적재)

-- 추출시 다른 데이터나 다른 스키마의 것을 가져온다. TEST계정에다가 SCOTT스키마를 가져온다.
--1. 테이블들을 불러온다.
--2. 집어넣을 테이블에 맞추어서 SELECT해서 변환작업을 한다. VARCHAR2 --> TO_DATE
--3. 집어넣을 테이블에 적재한다.

-- SCOTT계정의 EMP테이블을 가져오겠다.
-- 스키마명.테이블명
-- 동일계정의 경우 스키마명은 적어주지 않고 테이블명만 적어준다.
SELECT *
FROM SCOTT.EMP;

-- 내 계정의 데이터 뿐만 아니라 다른 계정의 데이터도 가지고 올수 있어야 한다.
SELECT *
FROM SCOTT.EMP E INNER JOIN BOARD B
                         ON 1 = 1;
                         
-- UPDATE
UPDATE BOARD SET BOARD_TIT = '일어나라',
                 BOARD_CTN = '학생들이여!!!'
WHERE BOARD_TXTNUM = 8;

COMMIT;

-- DELETE
DELETE FROM BOARD
WHERE BOARD_TXTNUM = 9;

COMMIT;


