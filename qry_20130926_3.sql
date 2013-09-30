
-- 진지한 문제.
-- 급여 순위 중 홀수번째에 해당하는 사원들의 급여를 10%감봉하여 전체 사원의 평균을 구하고 
-- 구한 평균 이상인 사람들의 급여를 20%감봉하여 전체 급여순위와 사원정보를 출력하시오.

-- 1. 급여순위 출력
SELECT E.*, ROW_NUMBER() OVER(ORDER BY SAL) RNK
FROM EMP E;

-- 2. 급여 순위 중 홀수번째에 해당하는 사원들의 급여를 10%감봉한다.
SELECT ERNK.SAL, ERNK.SAL * 0.9, ERNK.RNK
FROM (
      SELECT E.*, RANK() OVER(ORDER BY SAL DESC) RNK
      FROM EMP E
     ) ERNK
WHERE (ERNK.RNK - TRUNC(ERNK.RNK / 2) * 2) = 1;

-- 3. 급여 순위 중 홀수번째 해당하는 사원들의 급여를 10%감봉하여 전체 사원의 평균을 구한다.
SELECT AVG(RESAL) AS SAAVG
FROM (
        SELECT 
               CASE WHEN (ERNK.RNK - TRUNC(ERNK.RNK / 2) * 2) = 1
                    THEN ERNK.SAL * 0.9
                    ELSE ERNK.SAL
               END AS RESAL
        FROM (
              SELECT E.*, RANK() OVER(ORDER BY SAL DESC) AS RNK
              FROM EMP E
             ) ERNK
     );

-- 4. 급여 순위 중 홀수번째 해당하는 사원들의 급여를 10%감봉하여 전체 사원의 평균을 구한다.
--    구한 평균 이상인 사람들의 급여를 20%감봉한다
SELECT E.*, SL10.SAAVG,
       CASE WHEN E.SAL >= SL10.SAAVG
            THEN E.SAL * 0.8
            ELSE E.SAL
       END AS RESAL
FROM EMP E LEFT OUTER JOIN (
                            SELECT AVG(RESAL) AS SAAVG
                            FROM (
                                    SELECT 
                                           CASE WHEN (ERNK.RNK - TRUNC(ERNK.RNK / 2) * 2) = 1
                                                THEN ERNK.SAL * 0.9
                                                ELSE ERNK.SAL
                                           END AS RESAL
                                    FROM (
                                          SELECT E.*, RANK() OVER(ORDER BY SAL DESC) AS RNK
                                          FROM EMP E
                                         ) ERNK
                                 )
                           ) SL10
                        ON 1 = 1;

-- 5. 급여 순위 중 홀수번째에 해당하는 사원들의 급여를 10%감봉하여 전체 사원의 평균을 구하고 
--    구한 평균 이상인 사람들의 급여를 20%감봉하여 전체 급여순위와 사원정보를 출력하시오.
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.RESAL, E.COMM, E.DEPTNO,
       RANK() OVER(ORDER BY E.RESAL DESC) AS RNK
FROM (
      SELECT E.*, SL10.SAAVG,
             CASE WHEN E.SAL >= SL10.SAAVG
                  THEN E.SAL * 0.8
                  ELSE E.SAL
             END AS RESAL
      FROM EMP E LEFT OUTER JOIN (
                                  SELECT AVG(RESAL) AS SAAVG
                                  FROM (
                                          SELECT 
                                                 CASE WHEN (ERNK.RNK - TRUNC(ERNK.RNK / 2) * 2) = 1
                                                      THEN ERNK.SAL * 0.9
                                                      ELSE ERNK.SAL
                                                 END AS RESAL
                                          FROM (
                                                SELECT E.*, RANK() OVER(ORDER BY SAL DESC) AS RNK
                                                FROM EMP E
                                               ) ERNK
                                       )
                                 ) SL10
                              ON 1 = 1
     ) E;