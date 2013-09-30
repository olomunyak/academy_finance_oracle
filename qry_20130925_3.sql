
-- CASE��
-- CASE������ WHEN�� THEN�� �׻� ���� ���´�.
SELECT ENAME,
       JOB,
       SAL,
       CASE WHEN JOB = 'CLERK'
            THEN SAL * 1.1
            WHEN JOB = 'PRESIDENT'
            THEN SAL * 0.9
            ELSE SAL
       END AS RESAL
FROM EMP;


-- DALLAS�� �����ϴ� ������� ��ü �޿� �հ� �� �������
-- ������ ������� �޿� ���� ���Ͽ� �� ���̸� ���ϰ� ����
-- ���� �̻��� �޿��� �޴� ������� �޿��� �������̸�ŭ
-- �����Ͽ� ��ü ����� ������ ����Ͻÿ�.
-- ��� : ���, �̸�, ����, �޿�
-- ���� : ��� ����

-- 1. ������ ���ϴ°�? --> ��ü ����� ����
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� --> DEPT
-- 4. ����ã�� --> 1. �޿����̸� ���Ѵ� (�޿����� =  DALLAS�� �ٹ��ϴ� ������� ������ �޿��� - DALLAS�� �ٹ��ϴ� ������� �޿���)
--                2. ������� �޿��� �޿����̺��� Ŭ ��� �� �޿����� ���̸� ����
-- 5. �ʿ��� �����͸� �������� --> ���, �̸�, ����, �޿�
-- 6. Ű���̺� ���� �����ۼ�
-- 7. ���� �� ����
---- 1. �޿����̸� ���Ѵ�.
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
SELECT D.LOC, SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO                 
GROUP BY D.LOC;

---- �޶󽺿� �ٹ��ϴ� ������� �޿���
SELECT SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'DALLAS';           

---- �޶󽺰� �ƴ� ������ �ٹ��ϴ� ������� �޿���
SELECT SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.LOC NOT IN ('DALLAS');           

SELECT 
     (SELECT SUM(E.SAL) AS SAL1
      FROM EMP E INNER JOIN DEPT D
                         ON E.DEPTNO = D.DEPTNO
      WHERE D.LOC NOT IN ('DALLAS'))
      -
     (SELECT SUM(E.SAL)
      FROM EMP E INNER JOIN DEPT D
                         ON E.DEPTNO = D.DEPTNO
      WHERE D.LOC = 'DALLAS') AS RESAL
FROM DUAL;
---- 2. ������� �޿��� �޿����̺��� Ŭ ��� �� �޿����� ���̸� ����
SELECT E.EMPNO, 
       E.ENAME, 
       E.JOB, 
--       E.SAL,
       CASE WHEN E.SAL >= 7275
            THEN E.SAL - (E.SAL - 7275)
            ELSE E.SAL
       END AS RESAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
----


SELECT E.EMPNO, 
       E.ENAME, 
       E.JOB, 
       CASE WHEN E.SAL >= (

                            SELECT 
                                 (SELECT SUM(E.SAL) AS SAL1
                                  FROM EMP E INNER JOIN DEPT D
                                                     ON E.DEPTNO = D.DEPTNO
                                  WHERE D.LOC NOT IN ('DALLAS'))
                                  -
                                 (SELECT SUM(E.SAL)
                                  FROM EMP E INNER JOIN DEPT D
                                                     ON E.DEPTNO = D.DEPTNO
                                  WHERE D.LOC = 'DALLAS') AS RESAL
                            FROM DUAL
       
                          )
            THEN E.SAL - (E.SAL - (
            
                                    SELECT 
                                         (SELECT SUM(E.SAL) AS SAL1
                                          FROM EMP E INNER JOIN DEPT D
                                                             ON E.DEPTNO = D.DEPTNO
                                          WHERE D.LOC NOT IN ('DALLAS'))
                                          -
                                         (SELECT SUM(E.SAL)
                                          FROM EMP E INNER JOIN DEPT D
                                                             ON E.DEPTNO = D.DEPTNO
                                          WHERE D.LOC = 'DALLAS') AS RESAL
                                    FROM DUAL            
            
                                  ))
            ELSE E.SAL
       END AS RESAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;