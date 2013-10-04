--sql-developer에서 F10
--FULL - 첫번째부터 끝까지 읽어들인다.
--필터와 정렬들이 나온다.

-- 계획을 실행하면서 측정하겠다.
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
                        -- 급여등급별 사원수가 가장 많은 등급을 제외한 사원들의 평균
                        SELECT AVG(E.SAL) AS RESAL
                        FROM EMP E INNER JOIN SALGRADE S
                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                        WHERE S.GRADE NOT IN (
                                                -- 급여등급별 사원수가 가장 많은 급여등급 
                                                SELECT G.GRADE 
                                                FROM (
                                                        -- 급여등급별 사원수 및 순위
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