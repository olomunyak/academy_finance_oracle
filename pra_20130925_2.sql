
-- DALLAS�� �����ϴ� ������� ��ü �޿� �հ� �� �������
-- ������ ������� �޿� ���� ���Ͽ� �� ���̸� ���ϰ� ����
-- ���� �̻��� �޿��� �޴� ������� �޿��� �������̸�ŭ
-- �����Ͽ� ��ü ����� ������ ����Ͻÿ�.
-- ��� : ���, �̸�, ����, �޿�
-- ���� : ��� ����

-- Ǯ��1 
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
                   
                   
--                   

SELECT SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.LOC IN ('DALLAS');               

SELECT SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.LOC NOT IN ('DALLAS');

SELECT E.*, DAL.SAL, NONDAL.SAL
FROM EMP E LEFT OUTER JOIN (SELECT SUM(E.SAL) AS SAL
                            FROM EMP E INNER JOIN DEPT D
                                                ON E.DEPTNO = D.DEPTNO
                            WHERE D.LOC IN ('DALLAS') ) DAL
                        ON 1 = 1
           LEFT OUTER JOIN (SELECT SUM(E.SAL) AS SAL
                            FROM EMP E INNER JOIN DEPT D
                                                ON E.DEPTNO = D.DEPTNO
                            WHERE D.LOC NOT IN ('DALLAS') ) NONDAL
                        ON 1 = 1
                            
