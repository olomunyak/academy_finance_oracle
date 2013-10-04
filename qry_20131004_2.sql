--sql-developer���� F10
--FULL - ù��°���� ������ �о���δ�.
--���Ϳ� ���ĵ��� ���´�.

-- ��ȹ�� �����ϸ鼭 �����ϰڴ�.
EXPLAIN PLAN FOR
SELECT E.EMPNO, 
       E.ENAME, 
       E.JOB, 
       E.MGR, 
       E.HIREDATE, 
       E.SAL, 
       E.SAL * 0.5 AS SALDOWN, 
       E.COMM, 
       E.DEPTNO
FROM EMP E INNER JOIN ( 
                        -- �޿���޺� ������� ���� ���� ����� ������ ������� ���
                        SELECT AVG(E.SAL) AS RESAL
                        FROM EMP E INNER JOIN SALGRADE S
                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                        WHERE S.GRADE NOT IN (
                                                -- �޿���޺� ������� ���� ���� �޿���� 
                                                SELECT G.GRADE 
                                                FROM (
                                                        -- �޿���޺� ����� �� ����
                                                        SELECT S.GRADE, 
                                                               COUNT(*) AS CNT, 
                                                               RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
                                                        FROM EMP E INNER JOIN SALGRADE S
                                                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                                        GROUP BY S.GRADE
                                                     ) G
                                                WHERE RNK = 1
                                              )
                      ) SA
                   ON 1 = 1
WHERE E.SAL >= SA.RESAL
ORDER BY E.SAL DESC;

SELECT * FROM TABLE(dbms_xplan.display());