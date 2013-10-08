
-- SEQUENCE
-- ���� ���� ȹ��
SELECT BOARD_SEQ.CURRVAL
FROM DUAL;

-- ���� ���� ȹ��
SELECT BOARD_SEQ.NEXTVAL
FROM DUAL;

-- INSERT
INSERT INTO MEMBER(MEM_ID, MEM_NAME, MEM_PW) 
VALUES('A', 'A', '1234');

-- TRANSACTION
-- ������ ����������� ���ư���.
ROLLBACK;

-- ���� �۾��� �����Ų��.
COMMIT;

INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID ,BOARD_TIT, BOARD_CTN)
VALUES(BOARD_SEQ.NEXTVAL, 'A', '�̰� �����ϸ�', '���ô�');

SELECT B.BOARD_TXTNUM, B.MEM_ID, B.BOARD_TIT, B.BOARD_CTN, 
       B.BOARD_REGIDATE, B.BOARD_HITS
FROM BOARD B INNER JOIN MEMBER M
                     ON B.MEM_ID = M.MEM_ID;

-- VALUES�� ���������� ���� �ִ�. 
-- �����Ͱ� �ƴϱ� ������ VALUES�� �����Ѵ�.
-- INSERT INTO ���� ���������� ������ VALUES�� �� ��� �Ѵ�.
-- ������ Ÿ�Ը� ������ �� ���� �ִ�.
INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID ,BOARD_TIT, BOARD_CTN)
(SELECT BOARD_SEQ.NEXTVAL, 'A', '�̰� �����ϸ�2', '���ô�.2'
       FROM DUAL);
-- DATA�̰� 3�ܰ� - ETL
-- 1. E EXTRACT(����)
-- 2. T TRANSFORM(��ȯ)
-- 3. L LOAD(����)

-- ����� �ٸ� �����ͳ� �ٸ� ��Ű���� ���� �����´�. TEST�������ٰ� SCOTT��Ű���� �����´�.
--1. ���̺���� �ҷ��´�.
--2. ������� ���̺� ���߾ SELECT�ؼ� ��ȯ�۾��� �Ѵ�. VARCHAR2 --> TO_DATE
--3. ������� ���̺� �����Ѵ�.

-- SCOTT������ EMP���̺��� �������ڴ�.
-- ��Ű����.���̺��
-- ���ϰ����� ��� ��Ű������ �������� �ʰ� ���̺�� �����ش�.
SELECT *
FROM SCOTT.EMP;

-- �� ������ ������ �Ӹ� �ƴ϶� �ٸ� ������ �����͵� ������ �ü� �־�� �Ѵ�.
SELECT *
FROM SCOTT.EMP E INNER JOIN BOARD B
                         ON 1 = 1;
                         
-- UPDATE
UPDATE BOARD SET BOARD_TIT = '�Ͼ��',
                 BOARD_CTN = '�л����̿�!!!'
WHERE BOARD_TXTNUM = 8;

COMMIT;

-- DELETE
DELETE FROM BOARD
WHERE BOARD_TXTNUM = 9;

COMMIT;


