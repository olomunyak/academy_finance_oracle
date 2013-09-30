
-- 집계함수
SELECT COUNT(*)
FROM EMP;

SELECT COUNT(*) 
FROM EMP
WHERE JOB = 'CLERK';

-- GROUP BY
-- ~별 ~별 갯수를 구하라
-- 업무별 사원수
-- SELECT에 올수 있는건 집계 함수 이외에는 GROUP BY 에 선언된 것만 쓸 수 있다.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- 업무별 급여의 합
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- 전체 급여의 합
SELECT /*JOB,*/ SUM(SAL)
FROM EMP
--GROUP BY JOB
ORDER BY JOB;

-- 전체 급여의 평균
SELECT ROUND(AVG(SAL),2)
FROM EMP;

-- 업무별 급여의 평균
SELECT JOB, ROUND(AVG(SAL),2)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- 연도별로 입사한 사원의 수
-- GROUP BY를 쓰면서 ORDER BY를 쓸 경우에는 SELECT에 선언되어있는 컬럼만 ORDER BY에 올 수 있다.
-- ORDER BY는 SELECT에 있는 것만 가져올수 있다. 만약 집게함수 없이 쓴다면 SELECT에 선언되어 있지 않은 것도 쓸 수 있다.
-- 집계함수를 썼다는 것은 GROUP BY에 선언된 것만 사용할수 있다(SELECT에선언, ORDER BY에 선언)는 얘기다.
SELECT TO_CHAR(HIREDATE, 'YYYY'), COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
ORDER BY TO_CHAR(HIREDATE, 'YYYY'); 

-- 1) 부서별 급여 평균을 구하시오.
-- 출석 : 부서명, 급여평균
-- 정렬 : 부서명 역순
SELECT D.DNAME, AVG(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME
ORDER BY D.DNAME DESC;

-- 2) 부서별, 업무별 급여합계를 구하시오.
-- 출력 : 부서명, 업무명, 급여합계
-- 정렬 : 부서명 정순, 업무명 정순
SELECT D.DNAME, E.JOB, SUM(SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME, E.JOB
ORDER BY D.DNAME, E.JOB DESC;

-- 업무별 최고급여
SELECT JOB, MAX(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- 업무별 최소급여
SELECT JOB, MIN(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- 급여등급별 총 사원수, 최소급여, 최고급여, 급여총합, 급여평균을 구하시오
-- 출력 : 급여등급, 총 사원수, 최소급여, 최고급여, 급여총합, 급여평균
-- 정렬 : 급여등급 정순
SELECT SA.GRADE, 
       COUNT(E.EMPNO) AS CNT, 
       MIN(E.SAL) AS MIN_SAL, 
       MAX(E.SAL) AS MAX_SAL, 
       SUM(E.SAL) AS SUM_SAL, 
       AVG(E.SAL) AS AVG_SAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
GROUP BY SA.GRADE
ORDER BY SA.GRADE ASC;


