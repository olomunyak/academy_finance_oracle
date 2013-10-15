-----------------------------------------------------------------
--0910

SELECT *
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 30;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE ENAME = 'SMITH';

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE ENAME LIKE '%A%';

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE ENAME LIKE 'A%A%';

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 30
AND JOB = 'CLERK';

SELECT EMPNO, ENAME ,JOB, SAL, COMM, SAL + COMM, DEPTNO
FROM EMP
WHERE COMM IS NOT NULL;

SELECT EMPNO, ENAME, JOB, SAL, COMM, SAL + NVL(COMM, 0) AS RESAL, DEPTNO
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL, COMM, SAL + NVL(COMM, 0) AS RESAL, DEPTNO
FROM EMP
ORDER BY EMPNO DESC;

-----------------------------------------------------------------
--0912

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC = 'DALLAS';
                   
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC = 'DALLAS'
WHERE E.JOB = 'CLERK';

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, E.COMM, D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC = 'CHICAGO'
WHERE E.JOB = 'MANAGER'
ORDER BY E.SAL DESC;

-----------------------------------------------------------------
SELECT SYSDATE
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE + 1, 'YYYY.MM.DD HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(900000, '999,999')
FROM DUAL;

SELECT TO_CHAR(900000.01, '999,999.99')
FROM DUAL;

SELECT TO_CHAR(90000.01, 'L999,999.99')
FROM DUAL;

SELECT TO_CHAR(900000.01, '$999,999.99')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY')
FROM DUAL;

SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY') AS HIREDATE, SAL
FROM EMP;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = 1981;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') BETWEEN 8 AND 12;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') >= 12
OR TO_CHAR(HIREDATE, 'MM') <= 8;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') IN (1, 2, 7);

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') NOT IN (1, 2, 7);

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
WHERE ENAME NOT IN ('SCOTT', 'ADAMS');

SELECT TO_DATE('1999-08-01')
FROM DUAL;

SELECT TO_DATE('19990801')
FROM DUAL;

SELECT TO_DATE('1999.08.01')
FROM DUAL;

SELECT TO_DATE('1999 08 01')
FROM DUAL;

SELECT TO_DATE('19990801130102')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('19990801130102'), 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;