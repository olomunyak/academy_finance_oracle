
-- �̱ۺ�
SELECT *
FROM BOARD_LIST;

-- �ζ��κ�
SELECT *
FROM (
      SELECT B.BOARD_TXTNUM, B.MEM_ID, B.BOARD_CGY, B.BOARD_TIT, B.BOARD_CTN, B.BOARD_REGIDATE, B.BOARD_HITS, RANK() OVER(ORDER BY B.BOARD_TXTNUM ASC) AS RNK
      FROM BOARD B INNER JOIN MEMBER M
                           ON B.MEM_ID = M.MEM_ID
      ORDER BY RNK DESC
);

-- ��Ī�ؼ� ���� �Ҹ��� �ֵ�
-- �ᱹ�� ���������� ����.
-- �̱ۺ�� �ζ��κ�� ���̰� ����. ������ ���̰� ���°� ���׸�������� ���.
-- Ư���̸����� ��������� �̱ۺ�� Ǯ��� �ζ��κ��.
-- �����Ϳ� �並 �������°� �����ϰ� ���ϰ��� ���̴�. 
-- ����Ǿ� �ִ���? �������? �����Ǿ��� ���̳�? �� �並 �����Ѵ�.

-- ���� ���� �̱ۺ�� �ζ��κ䰡 �ִ�.
-- ������ ����Ŭ�� ��� ���׸�������� �䵵 �ִ�.
-- ��� ������ �����Ϳ� �̸��� �ٿ� �������̴�.
-- ���׸���������� ������ �����͸� ������ ���� ���̴�.

SELECT *
FROM (
      SELECT B.BOARD_TXTNUM, B.MEM_ID, B.BOARD_CGY, B.BOARD_TIT, B.BOARD_CTN, B.BOARD_REGIDATE, B.BOARD_HITS, RANK() OVER(ORDER BY B.BOARD_TXTNUM ASC) AS RNK
      FROM BOARD B INNER JOIN MEMBER M
                           ON B.MEM_ID = M.MEM_ID
      ORDER BY RNK DESC
     ) A INNER JOIN BOARD B
                 ON A.BOARD_TXTNUM = B.BOARD_TXTNUM;