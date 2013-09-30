
-- 급여의 최대값
SELECT MAX(SAL)
FROM EMP;

-- 최대 급여를 받는 사람
-- 서브쿼리
-- 서브쿼리의 결과는 하나의 데이터처럼 취급한다.
SELECT E.*
FROM EMP E INNER JOIN ( SELECT MAX(SAL) AS MSAL 
                         FROM EMP ) ME
                    ON E.SAL = ME.MSAL;

-- SELECT에서 서브쿼리를 쓸경우
-- 바로 밖에 감싸고 있는 쿼리의 컬럼을 가져올수있다. 1단계만 가능하다.
-- SELECT절에서 SUBQUERY를 썼다.
SELECT E.ENAME,
       (SELECT D.DNAME 
        FROM DEPT D 
        WHERE D.DEPTNO = E.DEPTNO)
FROM EMP E;
-- 서브쿼리는 GROUP BY 와 ORDER BY 빼고 다 들어갈수 있다.
-- 위의 경우 14건을 가져 오는데 서브쿼리를 만났다. 4개씩 14번을 돈다.
-- 만약 사원정보(EMP)가 만건이고 부서정보가 250건일때는 250만번 돌게 된다.
-- 데이터가 커지면 커질수록 SELECT 안에 들어간 서브쿼리는 느려진다..
-- 되도록이면 SELECT안에 서브쿼리를 쓰면 안된다. WHERE도 마찬가지다. 
-- SELECT에 쓰는것과 마찬가지로 느려진다. 그래서 서브쿼리는 주로 FROM절에 쓴다.
-- 서브쿼리를 FROM에 쓰는 이유는 한번 만들어 놓고 맵핑시키는게 낳다.
-- WHERE나 SELECT에 쓰게 되면 그만큼 반복하게 된다.

-- 서브쿼리를 쓴다고 무조건 느려지는건 아니다.
-- 써줄때는 써줘야 한다. 가져오는 데이터를 축소시켜서 가져올수 있다면 쓰는 것이 좋다.
-- * 쿼리에서 중요한 것은 작은 데이터 끼리 관계를 가질수록 속도는 올라간다. !!!
-- 예) 주 테이블에 4000만건이 있다면 서브쿼리 없이 조인을 건다면 만건을 가지고 비교를 해야 하고
-- 서브쿼리를 쓰고 조인을 쓴다면 100건을 가지고 비교를 한다면 당연히 서브쿼리를 써야 한다.
-- 단 SELECT나 WHERE절에는 서브쿼리의 사용을 지양해야 한다.

-- WHERE절에 서브쿼리를 써야 할 때가 있다.
-- DALLAS에 있는 사원의 사원정보를 출력
-- 조건절(WHERE)의 서브쿼리는 컬럼이 하나여야 한다.
SELECT E.*
FROM EMP E
WHERE E.DEPTNO = (SELECT D.DEPTNO
                   FROM DEPT D
                   WHERE D.LOC IN ('DALLAS'));

-- 두개 이상이 호출되어서 단순비교를 할 수 없다.
-- 단순비교를 할때는 데이터도 무조건 한 건이 나와야 한다.
SELECT E.*
FROM EMP E
WHERE E.DEPTNO = (SELECT D.DEPTNO
                   FROM DEPT D);                   

SELECT E.*
FROM EMP E
WHERE E.DEPTNO IN (SELECT D.DEPTNO
                   FROM DEPT D);                                      