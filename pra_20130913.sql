
-- 81년도에 입사한 시카고지역 사원들의 정보를
-- 이름, 직무, 입사일, 급여, 부서명, 지역
-- 순으로 출력하고 입사일 내림차순(역순)으로 정렬
SELECT E.ENAME, E.JOB, E.HIREDATE, E.SAL, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'CHICAGO'
WHERE TO_CHAR(E.HIREDATE, 'YYYY') = '1981'
ORDER BY E.HIREDATE DESC;
