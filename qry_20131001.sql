-- 문제1)
-- 월별 입사자들이 가장많은 월의 가장 많은 인원이 포함된
-- 부서 사원들의 급여 평균을 구하시오

-- 1. 무엇을 구하는가? --> 사원들의 급여평균
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 --> DEPT
-- 4. 조건찾기 -->  월별 입사자들이 가장많은 월의 가장 많은 인원이 포함된 부서
-- 5. 필요한 데이터만 가져오기 --> 
-- 6. 키테이블 기준 쿼리작성 


--1.월별 입사자들이 가장 많은 월
SELECT HMONTH
FROM (
      SELECT HMONTH, CNT, RANK() OVER(ORDER BY CNT DESC) AS RNK
      FROM (
            SELECT TO_CHAR(HIREDATE, 'MM') AS HMONTH, COUNT(*) AS CNT
            FROM EMP
            GROUP BY TO_CHAR(HIREDATE, 'MM')
           )
     )
WHERE RNK = 1;

--2.월별 입사자들이 가장 많은 월에 입사한 사원들의 사원정보
SELECT *  
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = (
                                  SELECT HMONTH
                                  FROM (
                                        SELECT HMONTH, CNT, RANK() OVER(ORDER BY CNT DESC) AS RNK
                                        FROM (
                                              SELECT TO_CHAR(HIREDATE, 'MM') AS HMONTH, COUNT(*) AS CNT
                                              FROM EMP
                                              GROUP BY TO_CHAR(HIREDATE, 'MM')
                                             )
                                  )
                                  WHERE RNK = 1
                                );

--3.월별 입사자들이 가장 많은 월의 가장 많이 입사한 부서
--사원들의 급여 평균을 구하시오
SELECT AVG(SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = ( SELECT DNAME
                  FROM (SELECT DNAME, CNT, RANK() OVER(ORDER BY CNT DESC) RNK
                        FROM (SELECT D.DNAME, COUNT(*) AS CNT
                              FROM EMP E INNER JOIN DEPT D
                                                 ON E.DEPTNO = D.DEPTNO
                              WHERE TO_CHAR(HIREDATE, 'MM') = ( SELECT HMONTH
                                                                FROM (SELECT HMONTH, CNT, RANK() OVER(ORDER BY CNT DESC) AS RNK
                                                                      FROM (SELECT TO_CHAR(HIREDATE, 'MM') AS HMONTH, COUNT(*) AS CNT
                                                                            FROM EMP
                                                                            GROUP BY TO_CHAR(HIREDATE, 'MM')))
                                                                WHERE RNK = 1)
                              GROUP BY D.DNAME))
                  WHERE RNK = 1 );
                               
--문제2)
--KING을 상급자로 둔 사원들의 급여 평균을 구하고
--그 평균 이상인 사원들의 급여를 30% 감봉하고 KING과 KING을
--상급자로 둔 사원들을 제외하고 출력하시오

-- 1. 무엇을 구하는가? --> 사원들의 급여평균
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 --> 
-- 4. 조건찾기 -->  KING을 상급자로 둔 사원들, KING과 KING을 상급자로 둔 사원들을 제외하고 출력
-- 5. 필요한 데이터만 가져오기 --> 
-- 6. 키테이블 기준 쿼리작성 

--1.KING을 상급자로 둔 사원들의 급여 평균
SELECT AVG(E1.SAL)
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO
WHERE E2.ENAME IN ('KING');

--2.KING을 상급자로 둔 사원들의 급여 평균을 구하고
--그 평균 이상인 사원들의 급여를 30% 감봉
SELECT E.*, KEMP.*,
       CASE WHEN E.SAL > KEMP.SAL
            THEN E.SAL * 0.7
            ELSE E.SAL
       END SAL
FROM EMP E INNER JOIN (
                        SELECT AVG(E1.SAL) AS SAL
                        FROM EMP E1 INNER JOIN EMP E2
                                           ON E1.MGR = E2.EMPNO
                        WHERE E2.ENAME IN ('KING')
                      ) KEMP
                   ON 1 = 1;

--3.KING을 상급자로 둔 사원들의 급여 평균을 구하고
--그 평균 이상인 사원들의 급여를 30% 감봉                   
-- KING과 KING을 상급자로 둔 사원들을 제외하고 출력하시오                   
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, /* KEMP.SAL, */
       CASE WHEN E.SAL >= KEMP.SAL
            THEN E.SAL * 0.7
            ELSE E.SAL
       END RESAL
FROM EMP E LEFT OUTER JOIN (SELECT AVG(E1.SAL) AS SAL
                            FROM EMP E1 INNER JOIN EMP E2
                                                ON E1.MGR = E2.EMPNO
                                                AND E2.ENAME IN ('KING')) KEMP
                        ON 1 = 1
           INNER JOIN EMP E3
                   ON E.MGR = E3.EMPNO
                   AND E3.ENAME NOT IN ('KING')
WHERE E.ENAME NOT IN ('KING');

--문제2) (위의 문제해석 및 풀이가 틀려서 다시 작성)
--KING을 상급자로 둔 사원들의 급여 평균을 구하고
--그 평균 이상인 사원들의 급여를 30% 감봉하고 KING과 KING을
--상급자로 둔 사원들을 제외하고 출력하시오
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, E.SAL * 0.7 AS RESAL
FROM EMP E INNER JOIN (
                        SELECT AVG(E1.SAL) AS SAL
                        FROM EMP E1 INNER JOIN EMP E2
                                           ON E1.MGR = E2.EMPNO
                        WHERE E2.ENAME IN ('KING')
                      ) KEMP
                   ON 1 = 1
           INNER JOIN EMP E3
                   ON E.MGR = E3.EMPNO
                   AND E3.ENAME NOT IN ('KING')
WHERE E.SAL > KEMP.SAL
AND E.ENAME NOT IN ('KING');