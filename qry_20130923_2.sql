
-- ��������
SELECT *
FROM EMP E INNER JOIN SALGRADE SG
                   ON E.SAL >= SG.LOSAL
                   AND E.SAL <= SG.HISAL;

-- ��������
-- SALGRADE���� ������ �ɸ� 1��޺��� �ɸ��� �Ǿ� �ִ�.
-- �׷��� ������ ���� �ʾƵ� ������ �Ǿ��ִ�.
SELECT E.ENAME, E.SAL, SG.GRADE, SG.LOSAL, SG.HISAL
FROM EMP E INNER JOIN SALGRADE SG
                   ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- �ڰ�����(�ڰ�����)                   
-- SELECT�� �����ͳ����� ���� ���̺��� �񱳴� �ƴϴ�.
-- �׷��� ���� ���̺� ������ ������ �����ϴ�.
-- �׷� ��� �ڰ����� ��� �Ѵ�.(�� �ȿ��� ���� �����Ѵ�.)
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MNO, E2.ENAME AS MNAME
FROM EMP E1 LEFT OUTER JOIN EMP E2
                         ON E1.MGR = E2.EMPNO;
-- EMP���� ������ �����Ϳ� EMP���� ������ �����͸� ���� ������
-- ������ ���� ������ 14 * 14 �� ������ �ȴ�.
-- �ٵ� �� LEFT OUTER JOIN �� �ɾ���?
-- �ֳ��ϸ� INNER JOIN�� �ɾ� ������ KING�� ����ڰ� ���� ������
-- ������ �ʰ� �ȴ�.

-- ���ι���� ��������, ��������, �ڰ������� �ִ�.
-- �������� �˸� ��� �ؼ����� �����͸� �� �����ü� �ִ�.