
-- 출제한문제
-- 달라스나 시카고에 근무하는 1981년도에 입사한 사원들의 월별 최대급여, 최소급여, 급여의 합, 급여의 평균 출력
-- 출력 : 월, 사원수, 최대급여, 최소급여, 급여총합, 급여평균
-- 정렬 : 월 정순
SELECT TO_CHAR(E.HIREDATE, 'MM') AS HMONTH,
       COUNT(E.EMPNO) AS CNT,
       MAX(E.SAL) AS MAX_SAL, 
       MIN(E.SAL) AS MIN_SAL, 
       SUM(E.SAL) AS SUM_SAL,
       AVG(E.SAL) AS AVG_SAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC IN ('DALLAS', 'CHICAGO')
WHERE TO_CHAR(E.HIREDATE, 'YYYY') = 1981
GROUP BY TO_CHAR(HIREDATE, 'MM')
ORDER BY TO_CHAR(HIREDATE, 'MM') ASC;

-- 받은문제
-- 각 근무지별 점원들의 수와 평균 급여
-- 단, 평균 급여는 소수점 두자리
-- 출력 : 근무지, 사원 수, 평균 급여
-- 정렬 : 근무지별 오름차순
SELECT D.LOC, COUNT(E.EMPNO) AS CNT, AVG(E.SAL) AS AVG_SAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK'                   
GROUP BY D.LOC                   
ORDER BY D.LOC;