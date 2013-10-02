
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = 'CLERK';

-- UNION은 결과와 결과를 합쳐준다.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = 'CLERK'
UNION
SELECT EMPNO, ENAME, 'STUDENT', SAL * 0.1
FROM EMP
WHERE JOB <> 'CLERK';

-- UNION은 위의 결과와 아래의 결과를 다 합쳐준다.
-- 요건만 맞으면 다 합쳐준다.
SELECT 0 AS FLAG, EMPNO, ENAME, JOB, SAL
FROM EMP
UNION
SELECT 1 AS FLAG, EMPNO, ENAME, 'STUDENT', SAL * 0.1
FROM EMP;

-- UNION은 중복되는 데이터를 제거해준다.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
UNION
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SCOTT';

-- UNION ALL 은 중복제거를 하지 않는다.
-- ** UNION은 위의 것과 아래의 것을 합쳐주는데 ALL이 붙으면 중복을 제거하지 않고 없으면 중복을 제거한다.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
UNION ALL
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SCOTT';

-- 데이터와 데이터를 합쳐서 하나의 데이터로 만들고 싶을때 UNION을 쓴다.
-- 각각 판매량의 등급을 따로따로 가져오고 싶을때


-- 중복제거
SELECT E2.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;
                    
SELECT DISTINCT E2.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;                    
                    
SELECT DISTINCT E2.ENAME, E2.JOB
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;                                        
                    
SELECT DISTINCT E2.ENAME, E2.JOB, E1.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;  

-- <> NOT 이라는 뜻이다. (!=, NOT IN 과 같다)                    
SELECT DISTINCT E2.ENAME, E2.JOB, E1.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO
WHERE E1.JOB <> 'CLEARK';                    

SELECT DISTINCT E2.ENAME, E2.JOB, E1.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO
WHERE E1.JOB NOT IN ('CLEARK');                    
                    

-- MINUS
-- 위의 결과에서 아래의 결과와 일치되는 것이 있다면 빼준다.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
MINUS
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SCOTT';                    