
-- unique
INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID, BOARD_TIT, BOARD_CTN, BOARD_REGIDATE)
VALUES(BOARD_SEQ.NEXTVAL, 'A', '111', '111', TO_DATE('1999-01-01'));

-- index

-- MEMBER������ �Է�
INSERT INTO MEMBER(MEM_ID, MEM_NAME, MEM_PW)
VALUES('ROLENSE', 'JANIFFER ROLENSE', '12341234');

-- CODE������ �Է�
INSERT INTO CODE(CD_BGCGY, CD_SMCGY, CD_CODENAME, CD_SEQ)
VALUES(2, 2, '����', 8);

-- BOARD������ �Է�
INSERT INTO BOARD(BOARD_TXTNUM, MEM_ID, BOARD_CGY, BOARD_TIT, BOARD_CTN)
VALUES(BOARD_SEQ.NEXTVAL, 'K', 0, '�ɺ��̾߱�', '�ɺ��� 12��');

-- UPDATE������ ����
UPDATE CODE SET CD_CODECMT = '����'
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


-- �Һз��� �����ϰ� ��з��� ���͸� �ش�. �׷��� �ϸ� ���ϴµ��� ������ �� �� �ִ�.
-- ������ ©���� ���͸� �����س���(�ʿ��� �κ��� �� ¥����) �ҷ��´�.
-- SELECT���� ���� �߿��� ���� '�ʿ��� �κи� ������ ����'�� ���̴�.

-- �Ϲ����� VIEW�� �ܼ��� ������ �ٿ����� �Ϳ� �Ұ��ϴ�.
-- �� ������ �ѹ��� �ش�.
-- ������ ���϶� ���� ����� VIEW��.
-- VIEW�� ������ ���̴� ���ҹۿ� �ȵȴ�. �׳� ���� ��ü�� �̸� ������ ���� ���̴�.
SELECT *
FROM BOARD_LIST;
-- �̱ۺ�(�Ϲ������� ���� �ܵ����� ���.)
-- �̱ۺ�� �ܼ� �� ��ɸ� �Ѵ�.
-- ���׸�������� ��(������, MVIEW) - ���̺��� ���������� ������ �����ϰ� �ִ� ���.
-- ����ϸ� �ӵ��� Ȯ���� �������� �׸�ŭ ���� ������ ��������.
COMMIT;
