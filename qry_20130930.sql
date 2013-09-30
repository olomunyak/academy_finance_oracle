
-- 문제1)
-- 점원들의 급여등급을 가져오시오. 단, 이름에 S가 들어가고
-- 사번이 7500 이상이고 근무지가 뉴욕이 아닌 사원을 가져오시오
-- 출력 : 사번, 이름, 부서, 등급, 급여, 등급최소값, 등급최대값
-- 정렬 : 등급 정순, 급여 역순, 부서번호 정순

-- 1. 무엇을 구하는가? --> 점원들의 급여등급(사번, 이름, 부서, 등급, 급여, 등급최소값, 등급최대값) 
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 --> SALGRADE, DEPT
-- 4. 조건찾기 --> 점원, 사번7500이상, 이름에 S가 들어간다, 근무지가 뉴욕이 아닌 사원
-- 5. 필요한 데이터만 가져오기 
-- 6. 키테이블 기준 쿼리작성 

--1.전체사원의 급여등급
SELECT E.EMPNO, E.ENAME, D.DNAME, SA.GRADE, E.SAL, SA.LOSAL, SA.HISAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
           INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC NOT IN ('NEW YORK');

--2.점원들의 급여등급을 가져오시오.
--이름에 S가 들어가고
--사번이 7500 이상이고 
--근무지가 뉴욕이 아닌 사원을 가져오시오
SELECT E.EMPNO, E.ENAME, D.DNAME, SA.GRADE, E.SAL, SA.LOSAL, SA.HISAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
           INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC NOT IN ('NEW YORK')
WHERE E.JOB = 'CLERK' 
AND E.ENAME LIKE '%S%'
AND E.EMPNO >= 7500;

--3.점원들의 급여등급을 가져오시오.
--이름에 S가 들어가고
--사번이 7500 이상이고 
--근무지가 뉴욕이 아닌 사원을 가져오시오
--등급 정순, 급여 역순, 부서번호 정순
SELECT E.EMPNO, E.ENAME, D.DNAME, SA.GRADE, E.SAL, SA.LOSAL, SA.HISAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
           INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC NOT IN ('NEW YORK')
WHERE E.JOB = 'CLERK' 
AND E.ENAME LIKE '%S%'
AND E.EMPNO >= 7500 
ORDER BY SA.GRADE ASC, E.SAL DESC, E.DEPTNO ASC;


-- 문제2)
-- KING을 제외한 사원들의 급여 최대치와 최소치를 구하고 그 차이를 
-- 구하여 전체 급여 평균과의 차이를 구하시오

-- 1. 무엇을 구하는가? --> 급여차이
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 --> 
-- 4. 조건찾기 --> KING을 제외한 사원
-- 5. 필요한 데이터만 가져오기 
-- 6. 키테이블 기준 쿼리작성 

--1.KING을 제외한 사원들의 급여 최대치와 최소치, 차이
SELECT MAX(SAL), MIN(SAL), MAX(SAL) - MIN(SAL)
FROM EMP
WHERE ENAME NOT IN ('KING');

--2.전체 급여평균
SELECT AVG(SAL)
FROM EMP;

--3.KING을 제외한 사원들의 급여 최대치와 최소치의 차이,
--전체 급여평균
SELECT SU.SUB, AV.SAVG
FROM (SELECT MAX(SAL) - MIN(SAL) AS SUB
      FROM EMP
      WHERE ENAME NOT IN ('KING')) SU LEFT OUTER JOIN (SELECT AVG(SAL) AS SAVG
                                                      FROM EMP) AV
                                                  ON 1 = 1;

--4.KING을 제외한 사원들의 급여 최대치와 최소치의 차이 와
--전체 급여평균과의 차이                                                   
SELECT CASE WHEN SU.SUB > AV.SAVG
            THEN SU.SUB - AV.SAVG
            ELSE AV.SAVG - SU.SUB
       END AS SUB
FROM (SELECT MAX(SAL) - MIN(SAL) AS SUB
      FROM EMP
      WHERE ENAME NOT IN ('KING')) SU LEFT OUTER JOIN (SELECT AVG(SAL) AS SAVG
                                                       FROM EMP) AV
                                                   ON 1 = 1;
