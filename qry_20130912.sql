
-- 부서에 소속된 사원들의 사원정보
-- 셀프조인 사용
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 부서에 소속된 사원들의 사원정보
-- inner join 사용
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO;

-- 달라스의 부서에 소속된 사원들의 사원정보
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'DALLAS';

-- 달라스의 부서에 소속된 점원들의 점원정보
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'DALLAS'
WHERE E.JOB = 'CLERK';

-- 시카고에서 근무하고 있는 관리자들의 사원정보를 구하시오.
-- 사원정보 : 사번, 이름, 업무, 급여 커미션, 부서명, 지역
-- 정렬 : 급여 내림차순
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, E.COMM, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D 
                   ON E.DEPTNO = D.DEPTNO 
                   AND D.LOC = 'CHICAGO'
WHERE E.JOB = 'MANAGER'
ORDER BY E.SAL DESC;
