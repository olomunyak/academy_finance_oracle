
EXPLAIN PLAN FOR
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL * 0.5 AS RE_SAL, E.COMM, E.DEPTNO
FROM EMP E INNER JOIN ( SELECT AVG(E.SAL) AS AVG_SAL
                        FROM EMP E INNER JOIN ( SELECT S.GRADE, 
                                                       S.LOSAL, 
                                                       S.HISAL, 
                                                       RANK() OVER(ORDER BY COUNT(E.EMPNO) DESC) AS GRADE_RNK
                                                FROM EMP E INNER JOIN SALGRADE S
                                                                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                                GROUP BY S.GRADE, S.LOSAL, S.HISAL) S
                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                           AND S.GRADE_RNK != 1) S
                   ON E.SAL >= S.AVG_SAL
ORDER BY  E.SAL * 0.5 DESC;

SELECT * FROM TABLE(dbms_xplan.display());

--

EXPLAIN PLAN FOR
SELECT S.GRADE, 
       S.LOSAL, 
       S.HISAL, 
       RANK() OVER(ORDER BY COUNT(E.EMPNO) DESC) AS GRADE_RNK
FROM EMP E INNER JOIN SALGRADE S
                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY S.GRADE, S.LOSAL, S.HISAL;

SELECT * FROM TABLE(dbms_xplan.display());