
-- 1. �� ����� ���, �̸�, ����, ����, MGR, MGR�� �̸��� ����Ͻÿ�
-- ��, MGR�� NULL�� �ƴ� ����� ���
SELECT E1.EMPNO, E1.ENAME, E1.JOB, E1.SAL, E1.MGR, E2.ENAME AS MNAME
FROM EMP E1 LEFT OUTER JOIN EMP E2
                         ON E1.MGR = E2.EMPNO
WHERE E1.MGR IS NOT NULL;                         

-- 2. MGR�� NULL�� �ƴ� ����� �̸�, �ٹ���, ����, Ŀ�̼�, ����+Ŀ�̼�, �������, ���� ���
-- ������ް� ������ ����+Ŀ�̼����� ���
-- ������ 7% �� Ŀ�̼��� NULL�� ����� Ŀ�̼����� 120 ����
SELECT E.ENAME, 
       D.LOC, 
       E.SAL, 
       NVL(E.COMM, 120) AS COMM, 
       E.SAL+NVL(E.COMM, 120) AS TOTAL, 
       SA.GRADE, 
       (E.SAL+NVL(E.COMM, 120)) * 0.07 AS TAX 
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
           INNER JOIN SALGRADE SA
                   ON E.SAL+NVL(E.COMM, 120) BETWEEN SA.LOSAL AND SA.HISAL
WHERE E.MGR IS NOT NULL;

-- 3. �ſ� 16�� ������ �Ի��� ����� �̸��� �Ի糯¥ ǥ��
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE, 'DD') <= 16;
