
-- 1. 각 사원의 사번, 이름, 업무, 연봉, MGR, MGR의 이름을 출력하시오
-- 단, MGR이 NULL이 아닌 사람만 출력
SELECT E1.EMPNO, E1.ENAME, E1.JOB, E1.SAL, E1.MGR, E2.ENAME AS MNAME
FROM EMP E1 LEFT OUTER JOIN EMP E2
                         ON E1.MGR = E2.EMPNO
WHERE E1.MGR IS NOT NULL;                         

-- 2. MGR이 NULL이 아닌 사원의 이름, 근무지, 연봉, 커미션, 연봉+커미션, 연봉등급, 세금 출력
-- 연봉등급과 세금은 연봉+커미션으로 계산
-- 세금은 7% 단 커미션이 NULL인 사람은 커미션으로 120 지급
SELECT E.ENAME, 
       D.LOC, 
       E.SAL, 
       NVL(E.COMM, 120) AS COMM, 
       E.SAL+NVL(E.COMM, 120) AS TOTAL, 
       SA.GRADE, 
       (E.SAL+NVL(E.COMM, 120)) * 0.07 AS TAX 
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
           INNER JOIN SALGRADE SA
                   ON E.SAL+NVL(E.COMM, 120) BETWEEN SA.LOSAL AND SA.HISAL
WHERE E.MGR IS NOT NULL;

-- 3. 매월 16일 이전에 입사한 사원의 이름과 입사날짜 표시
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE, 'DD') <= 16;
