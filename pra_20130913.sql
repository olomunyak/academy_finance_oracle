
-- 81�⵵�� �Ի��� ��ī������ ������� ������
-- �̸�, ����, �Ի���, �޿�, �μ���, ����
-- ������ ����ϰ� �Ի��� ��������(����)���� ����
SELECT E.ENAME, E.JOB, E.HIREDATE, E.SAL, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'CHICAGO'
WHERE TO_CHAR(E.HIREDATE, 'YYYY') = '1981'
ORDER BY E.HIREDATE DESC;
