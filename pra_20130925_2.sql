
-- DALLAS에 업무하는 사원들의 전체 급여 합과 그 사원들을
-- 제외한 사원들의 급여 합을 구하여 두 차이를 구하고 구한
-- 차이 이상의 급여를 받는 사원들의 급여를 구한차이만큼
-- 감봉하여 전체 사원의 정보를 출력하시오.
-- 출력 : 사번, 이름, 업무, 급여
-- 정렬 : 사번 역순

-- 풀이1 
SELECT E.EMPNO, 
       E.ENAME, 
       E.JOB, 
       CASE WHEN E.SAL >= (

                            SELECT 
                                 (SELECT SUM(E.SAL) AS SAL1
                                  FROM EMP E INNER JOIN DEPT D
                                                     ON E.DEPTNO = D.DEPTNO
                                  WHERE D.LOC NOT IN ('DALLAS'))
                                  -
                                 (SELECT SUM(E.SAL)
                                  FROM EMP E INNER JOIN DEPT D
                                                     ON E.DEPTNO = D.DEPTNO
                                  WHERE D.LOC = 'DALLAS') AS RESAL
                            FROM DUAL
       
                          )
            THEN E.SAL - (E.SAL - (
            
                                    SELECT 
                                         (SELECT SUM(E.SAL) AS SAL1
                                          FROM EMP E INNER JOIN DEPT D
                                                             ON E.DEPTNO = D.DEPTNO
                                          WHERE D.LOC NOT IN ('DALLAS'))
                                          -
                                         (SELECT SUM(E.SAL)
                                          FROM EMP E INNER JOIN DEPT D
                                                             ON E.DEPTNO = D.DEPTNO
                                          WHERE D.LOC = 'DALLAS') AS RESAL
                                    FROM DUAL            
            
                                  ))
            ELSE E.SAL
       END AS RESAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
                   
--                   

SELECT SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.LOC IN ('DALLAS');               

SELECT SUM(E.SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.LOC NOT IN ('DALLAS');

SELECT E.*, DAL.SAL, NONDAL.SAL
FROM EMP E LEFT OUTER JOIN (SELECT SUM(E.SAL) AS SAL
                            FROM EMP E INNER JOIN DEPT D
                                                ON E.DEPTNO = D.DEPTNO
                            WHERE D.LOC IN ('DALLAS') ) DAL
                        ON 1 = 1
           LEFT OUTER JOIN (SELECT SUM(E.SAL) AS SAL
                            FROM EMP E INNER JOIN DEPT D
                                                ON E.DEPTNO = D.DEPTNO
                            WHERE D.LOC NOT IN ('DALLAS') ) NONDAL
                        ON 1 = 1
                            
