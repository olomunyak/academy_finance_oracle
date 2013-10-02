
--급여등급별 사원수가 가장 많은 등급을 제외한 사원들의 평균을 구하고
--전체 사원 중 구한 평균 이상인 사원들의 급여를 50% 감봉하여
--급여순위별로 출력

-- 1. 무엇을 구하는가? --> 평균 이상인 사원들을 급여순위별로 사원 출력
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 --> SALGRADE
-- 4. 조건찾기 -->  급여등급별 사원수가 가장 많은 등급을 제외한 사원들의 평균
--                 전체 사원 중 구한 평균 이상인 사원들의 급여를 50% 감봉
--                 급여순위별로 출력
-- 5. 필요한 데이터만 가져오기
-- 6. 키테이블 기준 쿼리작성 


--1. 급여등급별 사원수
SELECT S.GRADE, COUNT(*) AS CNT, RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
FROM EMP E INNER JOIN SALGRADE S
                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY S.GRADE;                   

--2. 가장 많은 등급을 제외한 사원들의 평균
SELECT AVG(E.SAL)
FROM EMP E INNER JOIN SALGRADE S
                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE S.GRADE NOT IN (SELECT G.GRADE
                      FROM (SELECT S.GRADE, COUNT(*) AS CNT, RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
                            FROM EMP E INNER JOIN SALGRADE S
                                               ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                            GROUP BY S.GRADE) G
                      WHERE RNK = 1);


--3. 전체 사원 중 구한 평균 이상인 사원들의 급여를 50% 감봉해서 급여순위별로 출력
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.SAL * 0.5 AS SALDOWN, E.COMM, E.DEPTNO
FROM EMP E INNER JOIN ( SELECT AVG(E.SAL) AS RESAL
                        FROM EMP E INNER JOIN SALGRADE S
                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                        WHERE S.GRADE NOT IN (SELECT G.GRADE
                                              FROM (SELECT S.GRADE, COUNT(*) AS CNT, RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
                                                    FROM EMP E INNER JOIN SALGRADE S
                                                                       ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                                    GROUP BY S.GRADE) G
                                              WHERE RNK = 1)) A
                   ON 1 = 1
WHERE E.SAL > A.RESAL
ORDER BY E.SAL DESC;

-->결과
--급여등급별 사원수가 가장 많은 등급을 제외한 사원들의 평균을 구하고
--전체 사원 중 구한 평균 이상인 사원들의 급여를 50% 감봉하여
--급여순위별로 출력
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