
-- "급여 등급이 2등급에서 4등급까지의 사원들을 골라
-- 그 사원들의 상급자"를 뺀 나머지 전체 사원의 급여를
-- 1.7배 인상시켜 출력하시요
-- 출력 : 이름, 업무, 급여등급, 급여, 인상급여
-- 정렬 : 이름 오름차순, 업무 내림차순 

-- 풀이1 
SELECT E.ENAME, E.JOB, SA.GRADE, E.SAL, E.SAL * 1.7 AS UPSAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
WHERE E.EMPNO NOT IN (SELECT E.MGR
                      FROM EMP E INNER JOIN SALGRADE SA
                                         ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
                                        AND SA.GRADE IN (2, 3, 4))
ORDER BY E.ENAME ASC, E.JOB DESC;

-- 풀이2
SELECT E.ENAME, E.JOB, S.GRADE, E.SAL, E.SAL*1.7 AS SAL2
FROM EMP E INNER JOIN SALGRADE S
                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.EMPNO NOT IN (SELECT E.MGR
                      FROM EMP E INNER JOIN SALGRADE S
                                         ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                        AND S.GRADE BETWEEN 2 AND 4);

-- 풀이3
SELECT E3.ENAME, E3.JOB, SA2.GRADE, E3.SAL, E3.SAL * 1.7 AS SAL2
FROM EMP E3 INNER JOIN (SELECT E4.ENAME
                        FROM EMP E4
                        WHERE E4.ENAME NOT IN (SELECT /*E1.ENAME,*/ E2.ENAME
                                               FROM EMP E1 INNER JOIN SALGRADE SA
                                                                   ON E1.SAL BETWEEN SA.LOSAL AND SA.HISAL
                                                                   AND SA.GRADE BETWEEN 2 AND 4
                                                           INNER JOIN EMP E2
                                                                   ON E1.MGR = E2.EMPNO) ) MGR
                    ON E3.ENAME = MGR.ENAME
            INNER JOIN SALGRADE SA2
                    ON E3.SAL BETWEEN SA2.LOSAL AND SA2.HISAL
ORDER BY E3.ENAME, E3.JOB DESC;