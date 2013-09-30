
-- �����Լ�
SELECT COUNT(*)
FROM EMP;

SELECT COUNT(*) 
FROM EMP
WHERE JOB = 'CLERK';

-- GROUP BY
-- ~�� ~�� ������ ���϶�
-- ������ �����
-- SELECT�� �ü� �ִ°� ���� �Լ� �̿ܿ��� GROUP BY �� ����� �͸� �� �� �ִ�.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- ������ �޿��� ��
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- ��ü �޿��� ��
SELECT /*JOB,*/ SUM(SAL)
FROM EMP
--GROUP BY JOB
ORDER BY JOB;

-- ��ü �޿��� ���
SELECT ROUND(AVG(SAL),2)
FROM EMP;

-- ������ �޿��� ���
SELECT JOB, ROUND(AVG(SAL),2)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- �������� �Ի��� ����� ��
-- GROUP BY�� ���鼭 ORDER BY�� �� ��쿡�� SELECT�� ����Ǿ��ִ� �÷��� ORDER BY�� �� �� �ִ�.
-- ORDER BY�� SELECT�� �ִ� �͸� �����ü� �ִ�. ���� �����Լ� ���� ���ٸ� SELECT�� ����Ǿ� ���� ���� �͵� �� �� �ִ�.
-- �����Լ��� ��ٴ� ���� GROUP BY�� ����� �͸� ����Ҽ� �ִ�(SELECT������, ORDER BY�� ����)�� ����.
SELECT TO_CHAR(HIREDATE, 'YYYY'), COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
ORDER BY TO_CHAR(HIREDATE, 'YYYY'); 

-- 1) �μ��� �޿� ����� ���Ͻÿ�.
-- �⼮ : �μ���, �޿����
-- ���� : �μ��� ����
SELECT D.DNAME, AVG(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME
ORDER BY D.DNAME DESC;

-- 2) �μ���, ������ �޿��հ踦 ���Ͻÿ�.
-- ��� : �μ���, ������, �޿��հ�
-- ���� : �μ��� ����, ������ ����
SELECT D.DNAME, E.JOB, SUM(SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME, E.JOB
ORDER BY D.DNAME, E.JOB DESC;

-- ������ �ְ�޿�
SELECT JOB, MAX(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- ������ �ּұ޿�
SELECT JOB, MIN(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- �޿���޺� �� �����, �ּұ޿�, �ְ�޿�, �޿�����, �޿������ ���Ͻÿ�
-- ��� : �޿����, �� �����, �ּұ޿�, �ְ�޿�, �޿�����, �޿����
-- ���� : �޿���� ����
SELECT SA.GRADE, 
       COUNT(E.EMPNO) AS CNT, 
       MIN(E.SAL) AS MIN_SAL, 
       MAX(E.SAL) AS MAX_SAL, 
       SUM(E.SAL) AS SUM_SAL, 
       AVG(E.SAL) AS AVG_SAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
GROUP BY SA.GRADE
ORDER BY SA.GRADE ASC;


