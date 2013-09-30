
-- �μ��� �Ҽӵ� ������� �������
-- �������� ���
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- �μ��� �Ҽӵ� ������� �������
-- inner join ���
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO;

-- �޶��� �μ��� �Ҽӵ� ������� �������
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'DALLAS';

-- �޶��� �μ��� �Ҽӵ� �������� ��������
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'DALLAS'
WHERE E.JOB = 'CLERK';

-- ��ī���� �ٹ��ϰ� �ִ� �����ڵ��� ��������� ���Ͻÿ�.
-- ������� : ���, �̸�, ����, �޿� Ŀ�̼�, �μ���, ����
-- ���� : �޿� ��������
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, E.COMM, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'CHICAGO'
WHERE E.JOB = 'MANAGER'
ORDER BY E.SAL DESC;
