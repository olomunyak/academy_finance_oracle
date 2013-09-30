
-- �����ѹ���
-- �޶󽺳� ��ī�� �ٹ��ϴ� 1981�⵵�� �Ի��� ������� ���� �ִ�޿�, �ּұ޿�, �޿��� ��, �޿��� ��� ���
-- ��� : ��, �����, �ִ�޿�, �ּұ޿�, �޿�����, �޿����
-- ���� : �� ����
SELECT TO_CHAR(E.HIREDATE, 'MM') AS HMONTH,
       COUNT(E.EMPNO) AS CNT,
       MAX(E.SAL) AS MAX_SAL, 
       MIN(E.SAL) AS MIN_SAL, 
       SUM(E.SAL) AS SUM_SAL,
       AVG(E.SAL) AS AVG_SAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC IN ('DALLAS', 'CHICAGO')
WHERE TO_CHAR(E.HIREDATE, 'YYYY') = 1981
GROUP BY TO_CHAR(HIREDATE, 'MM')
ORDER BY TO_CHAR(HIREDATE, 'MM') ASC;

-- ��������
-- �� �ٹ����� �������� ���� ��� �޿�
-- ��, ��� �޿��� �Ҽ��� ���ڸ�
-- ��� : �ٹ���, ��� ��, ��� �޿�
-- ���� : �ٹ����� ��������
SELECT D.LOC, COUNT(E.EMPNO) AS CNT, AVG(E.SAL) AS AVG_SAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK'                   
GROUP BY D.LOC                   
ORDER BY D.LOC;