
-- ����1)
-- �������� �޿������ �������ÿ�. ��, �̸��� S�� ����
-- ����� 7500 �̻��̰� �ٹ����� ������ �ƴ� ����� �������ÿ�
-- ��� : ���, �̸�, �μ�, ���, �޿�, ����ּҰ�, ����ִ밪
-- ���� : ��� ����, �޿� ����, �μ���ȣ ����

-- 1. ������ ���ϴ°�? --> �������� �޿����(���, �̸�, �μ�, ���, �޿�, ����ּҰ�, ����ִ밪) 
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� --> SALGRADE, DEPT
-- 4. ����ã�� --> ����, ���7500�̻�, �̸��� S�� ����, �ٹ����� ������ �ƴ� ���
-- 5. �ʿ��� �����͸� �������� 
-- 6. Ű���̺� ���� �����ۼ� 

--1.��ü����� �޿����
SELECT E.EMPNO, E.ENAME, D.DNAME, SA.GRADE, E.SAL, SA.LOSAL, SA.HISAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
           INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC NOT IN ('NEW YORK');

--2.�������� �޿������ �������ÿ�.
--�̸��� S�� ����
--����� 7500 �̻��̰� 
--�ٹ����� ������ �ƴ� ����� �������ÿ�
SELECT E.EMPNO, E.ENAME, D.DNAME, SA.GRADE, E.SAL, SA.LOSAL, SA.HISAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
           INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC NOT IN ('NEW YORK')
WHERE E.JOB = 'CLERK' 
AND E.ENAME LIKE '%S%'
AND E.EMPNO >= 7500;

--3.�������� �޿������ �������ÿ�.
--�̸��� S�� ����
--����� 7500 �̻��̰� 
--�ٹ����� ������ �ƴ� ����� �������ÿ�
--��� ����, �޿� ����, �μ���ȣ ����
SELECT E.EMPNO, E.ENAME, D.DNAME, SA.GRADE, E.SAL, SA.LOSAL, SA.HISAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
           INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC NOT IN ('NEW YORK')
WHERE E.JOB = 'CLERK' 
AND E.ENAME LIKE '%S%'
AND E.EMPNO >= 7500 
ORDER BY SA.GRADE ASC, E.SAL DESC, E.DEPTNO ASC;


-- ����2)
-- KING�� ������ ������� �޿� �ִ�ġ�� �ּ�ġ�� ���ϰ� �� ���̸� 
-- ���Ͽ� ��ü �޿� ��հ��� ���̸� ���Ͻÿ�

-- 1. ������ ���ϴ°�? --> �޿�����
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� --> 
-- 4. ����ã�� --> KING�� ������ ���
-- 5. �ʿ��� �����͸� �������� 
-- 6. Ű���̺� ���� �����ۼ� 

--1.KING�� ������ ������� �޿� �ִ�ġ�� �ּ�ġ, ����
SELECT MAX(SAL), MIN(SAL), MAX(SAL) - MIN(SAL)
FROM EMP
WHERE ENAME NOT IN ('KING');

--2.��ü �޿����
SELECT AVG(SAL)
FROM EMP;

--3.KING�� ������ ������� �޿� �ִ�ġ�� �ּ�ġ�� ����,
--��ü �޿����
SELECT SU.SUB, AV.SAVG
FROM (SELECT MAX(SAL) - MIN(SAL) AS SUB
      FROM EMP
      WHERE ENAME NOT IN ('KING')) SU LEFT OUTER JOIN (SELECT AVG(SAL) AS SAVG
                                                      FROM EMP) AV
                                                  ON 1 = 1;

--4.KING�� ������ ������� �޿� �ִ�ġ�� �ּ�ġ�� ���� ��
--��ü �޿���հ��� ����                                                   
SELECT CASE WHEN SU.SUB > AV.SAVG
            THEN SU.SUB - AV.SAVG
            ELSE AV.SAVG - SU.SUB
       END AS SUB
FROM (SELECT MAX(SAL) - MIN(SAL) AS SUB
      FROM EMP
      WHERE ENAME NOT IN ('KING')) SU LEFT OUTER JOIN (SELECT AVG(SAL) AS SAVG
                                                       FROM EMP) AV
                                                   ON 1 = 1;
