
-- RANK, OVER
-- EMP테이블의 급여순위
SELECT ENAME, SAL, 
       RANK() OVER(ORDER BY SAL DESC) AS RNK
FROM EMP;

-- PARTITION BY
-- EMP테이블에서 업무별 급여순위
SELECT ENAME, JOB, SAL,
       RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS RNK
FROM EMP;       

-- PARTATION BY
-- EMP테이블에서 업무별, 부서별 급여순위
SELECT E.ENAME, E.JOB, D.DNAME, E.SAL,
       RANK() OVER(PARTITION BY JOB, E.DEPTNO ORDER BY SAL DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
ORDER BY E.JOB, D.DNAME;             

-- ** 순위를 매길때 중요한 것은 어떤 기준으로 순위를 매길까 이다.
                
                   
-- 두가지 조건을 만족하는 것은 두 가지 밖에 없다. 
-- 줄에 대한 순서를 붙이는 것이 있다.
-- 동일한 순서가 없다.
SELECT E.ENAME, E.JOB, D.DNAME, E.SAL,
       ROW_NUMBER() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
-- 급여만으로 필터를 걸때 같은 순위를 주고 싶지 않을때
-- 조건이 좀 더 필요한데 동일 급여일 경우 입사일이 늦은 사람이 위에 오도록 하고 싶은 경우
-- 조건은 세분화 하면 세분화 할수록 숫자(순위)는 정확하게 나온다.
-- 번호를 매기는 조건을 정확히 줘야지 내가 원하는 순서를 받아올수 있다.
SELECT E.ENAME, E.JOB, E.HIREDATE, E.SAL,
       ROW_NUMBER() OVER(PARTITION BY E.JOB 
                         ORDER BY E.SAL DESC, E.HIREDATE DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
                   
-- ROW_NUMBER과 RANK의 차이는
-- RANK와 ROW_NUMBER의 차이는 RANK는 값을 기준으로 순위를 생성하고
-- ROWNUMBER는 값을 정렬한 데이터별 줄번호를 붙여준다.
-- 순위를 표시할때는 RANK로 하는데 중복된 경우는 ROW_NUMBER를 쓴다.

-- ROWNUM은 줄번호를 붙여준다. ORDER BY가 끝나고 SELECT절에서 붙여주기 때문에 ~~
-- 개발자는 ROWNUM을 많이 쓴다. 하지만 ROW_NUMBER는
-- 그굽별 데이터를 매길수 있다. 그래서 ROW_NUMBER 가 ROWNUM보다 더 좋다.
-- ROW_NUMBER는 RANK와 함께 ANSI-DB에 들어간다.(MySQL, MSSQL에서 사용이 가능하다.) 하지만 ROWNUM은 오라클에서 
-- 밖에 쓸 수 없다.
SELECT ROWNUM AS RNUM, ENAME, JOB
FROM EMP
ORDER BY SAL DESC;
--ROWNUM은 줄 번호를 붙여주는데 필터 까지 끝난 상태의 데이터에 줄번호를 붙여 준다.
--ORDER BY는 필터 적용 후다
SELECT ROWNUM AS RNUM, ENAME, JOB
FROM EMP
ORDER BY ROWNUM DESC;
-- WHERE가 끝나고 ORDER BY 가 시작되기 전에 줄번호를 붙여주게 된다.
-- 그래서 ROWNUM으로 순위를 매겨주게 되면 추가 작업이 더 필요하다.
SELECT ROWNUM AS RNUM, ENAME, E.JOB, E.SAL
FROM (
      SELECT ENAME, JOB, SAL
      FROM EMP
      ORDER BY SAL DESC
      ) E
ORDER BY ROWNUM ASC;
-- 주로 ROW_NUMBER를 쓴다.
-- 개발자들이 많이 쓰는 이유는 웹게시판의 페이징 때문에 많이 쓰게 된다.
-- 하지만 통계를 해야 하고 유연성을 가져야 하는 쿼리에서는 ROWNUM은 쓸모가 없다.




