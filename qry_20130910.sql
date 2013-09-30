
-- ��ü ��������� ���
SELECT *
FROM EMP;

-- ������̺��� �μ���ȣ�� 30�� ������� ���
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 30;

-- ����̸��� SMITH�� ����� ���
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE ENAME = 'SMITH';

-- ����̸��� A�� ���ԵǾ� �ִ� ��� ���
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE ENAME LIKE '%A%';

-- �̸��� A�� �����ϰ� �߰��� A�� ���Ե� ������� ���ϱ�
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE ENAME LIKE 'A%A%';

-- �μ���ȣ�� 30�̰� ������ CLERK�� ������� ���ϱ�
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 30
AND JOB = 'CLERK';

-- 1 + 2 * 3
SELECT 1 + 2 * 3
FROM DUAL;

-- Ŀ�̼��� �޴� ������� �ѱ޿��� ��������� ���Ͻÿ�
SELECT EMPNO, ENAME, SAL, COMM, SAL + COMM AS TOTAL, DEPTNO 
FROM EMP
WHERE COMM IS NOT NULL;

-- ��ü ����� Ŀ�̼ǰ� �޿��� ���� ���Ͻÿ�
SELECT EMPNO, ENAME, SAL, COMM, SAL + NVL(COMM,0) AS TOTAL, DEPTNO 
FROM EMP;

-- ��ü ����� Ŀ�̼ǰ� �޿��� ���� ���ϰ� �����ȣ�� ���� �������� �����Ͻÿ�
SELECT EMPNO, ENAME, SAL, COMM, SAL + NVL(COMM,0) AS TOTAL, DEPTNO 
FROM EMP
ORDER BY EMPNO DESC;
