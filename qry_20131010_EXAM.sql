

SELECT E.ENAME, E.JOB, D.DNAME, E.SAL
FROM EMP E INNER JOIN (
                        SELECT AVG(SAL) AS ASAL
                        FROM EMP E INNER JOIN DEPT D
                                           ON E.DEPTNO = D.DEPTNO
                        WHERE D.DNAME NOT IN (
                                              SELECT D.DNAME
                                              FROM ( SELECT DEPTNO 
                                                     FROM EMP
                                                     WHERE JOB = 'PRESIDENT'
                                                   )E INNER JOIN DEPT D
                                                                 ON E.DEPTNO = D.DEPTNO
                                             )
                      ) SA
                   ON 1 = 1
           INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.DNAME NOT IN (
                                      SELECT D.DNAME
                                      FROM ( SELECT DEPTNO 
                                             FROM EMP
                                             WHERE JOB = 'PRESIDENT'
                                           )E INNER JOIN DEPT D
                                                         ON E.DEPTNO = D.DEPTNO
                  )
WHERE SAL >= ASAL
;





