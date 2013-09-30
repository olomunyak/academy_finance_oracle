
-- CASE문
-- CASE문에서 WHEN과 THEN은 항상 같이 나온다.
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


-- DALLAS에 업무하는 사원들의 전체 급여 합과 그 사원들을
-- 제외한 사원들의 급여 합을 구하여 두 차이를 구하고 구한
-- 차이 이상의 급여를 받는 사원들의 급여를 구한차이만큼
-- 감봉하여 전체 사원의 정보를 출력하시오.
-- 출력 : 사번, 이름, 업무, 급여
-- 정렬 : 사번 역순

-- 1. 무엇을 구하는가? --> 전체 사원의 정보
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 --> DEPT
-- 4. 조건찾기 --> 1. 급여차이를 구한다 (급여차이 =  DALLAS에 근무하는 사원들을 제외한 급여합 - DALLAS에 근무하는 사원들의 급여합)
--                2. 사원들의 급여가 급여차이보다 클 경우 그 급여에서 차이를 뺀다
-- 5. 필요한 데이터만 가져오기 --> 사번, 이름, 업무, 급여
-- 6. 키테이블 기준 쿼리작성
-- 7. 실행 및 검증
---- 1. 급여차이를 구한다.
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
SELECT D.LOC, SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO                 
GROUP BY D.LOC;

---- 달라스에 근무하는 사원들의 급여합
SELECT SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'DALLAS';           

---- 달라스가 아닌 곳에서 근무하는 사원들의 급여합
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
---- 2. 사원들의 급여가 급여차이보다 클 경우 그 급여에서 차이를 뺀다
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