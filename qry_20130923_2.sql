
-- 간접매핑
SELECT *
FROM EMP E INNER JOIN SALGRADE SG
                   ON E.SAL >= SG.LOSAL
                   AND E.SAL <= SG.HISAL;

-- 간접매핑
-- SALGRADE에서 조건을 걸면 1등급부터 걸리게 되어 있다.
-- 그래서 정렬을 하지 않아도 정렬이 되어있다.
SELECT E.ENAME, E.SAL, SG.GRADE, SG.LOSAL, SG.HISAL
FROM EMP E INNER JOIN SALGRADE SG
                   ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- 자가참조(자가매핑)                   
-- SELECT는 데이터끼리의 비교지 테이블간의 비교는 아니다.
-- 그래서 동일 테이블 간에도 조인이 가능하다.
-- 그런 경우 자가참조 라고 한다.(내 안에서 나를 참조한다.)
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MNO, E2.ENAME AS MNAME
FROM EMP E1 LEFT OUTER JOIN EMP E2
                         ON E1.MGR = E2.EMPNO;
-- EMP에서 가져온 데이터와 EMP에서 가져온 데이터를 쓰기 때문에
-- 매핑을 걸지 않으면 14 * 14 가 나오게 된다.
-- 근데 왜 LEFT OUTER JOIN 을 걸었나?
-- 왜냐하면 INNER JOIN을 걸어 버리면 KING은 상급자가 없기 때문에
-- 나오지 않게 된다.

-- 매핑방법은 직접매핑, 간접매핑, 자가매핑이 있다.
-- 세가지만 알면 어떻게 해서든지 데이터를 다 가져올수 있다.