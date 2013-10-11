--COMM이 Null인 사람들의 급여평균을 구하고 그 평균보다 급여가 낮은 사람들을
--제외한 평균을 구하고 전체 사원에서 그 평균보다 높은 사람을 40%감봉하여
--급여순위를 나타내시오.
--단, 근무지가 DALLAS인 사람은 세금을 5% CHICAGO인 사람을 7%나타내고
--나머지는 3%를 부과한다 그리고 이름이 S자가 들어가는 사람은 제외시킨다.
--출력 : 사원번호 사원이름 사원업무 사원급여 사원급여순위 세금
--정렬 : 사원급여순위를 정순으로 정렬한다.

SELECT E.EMPNO, 
       E.ENAME, 
       E.JOB, 
       E.RESAL, 
       RANK() OVER(ORDER BY RESAL DESC) AS RNK,
       CASE WHEN E.ENAME LIKE '%S%'
            THEN E.RESAL * 0
            ELSE
                 CASE WHEN E.LOC = 'DALLAS'
                      THEN E.RESAL * 0.05
                      WHEN E.LOC = 'CHICAGO'
                      THEN E.RESAL * 0.07
                      ELSE E.RESAL * 0.03
                 END
       END TAX
--       E.LOC
FROM (
      SELECT E.*, ESAL.SAVG,
             CASE WHEN E.SAL > ESAL.SAVG
                  THEN E.SAL * 0.6
                  ELSE E.SAL
             END AS RESAL,
             D.LOC             
      FROM EMP E INNER JOIN (
                              SELECT AVG(SAL) AS SAVG
                              FROM EMP
                              WHERE EMPNO NOT IN (
                                                  SELECT E.EMPNO
                                                  FROM EMP E INNER JOIN (SELECT AVG(SAL) SAVG
                                                                         FROM EMP
                                                                         WHERE COMM IS NULL) SA
                                                                     ON 1 = 1
                                                  WHERE E.SAL < SA.SAVG
                                                 )
                            ) ESAL
                         ON 1 = 1 
                 INNER JOIN DEPT D
                         ON E.DEPTNO = D.DEPTNO                         
     ) E