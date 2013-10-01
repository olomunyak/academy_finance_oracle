
-- 문제3)
-- 전반기 입사자와 후반기 입사자들의 급여평균을 구하고
-- 그 평균간의 차이를 구하여 전반기와 후반기 중 평균이 더
-- 높은 쪽의 사원들의 급여를 차이만큼 증가시켜준 쥐 급여등급과
-- 급여 순위(역순)를 포함하여 출력하시오
-- 출력 : 사원명, 입사일, 급여등급, 급여순위
-- 정렬 : 급여순위 역순

-- 1. 무엇을 구하는가? --> 급여등급과, 급여순위 출력                   
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 -->
-- 4. 조건찾기 --> 
-- 5. 필요한 데이터만 가져오기 --> 전반기 입사자와 후반기 입사자들의 급여평균간의 차이
--                              평균이 더 높은 쪽의(전반기 입사자와 후반기 입사자중) 사원들의 급여를 차이만큼 증가
--                              급여등급과 급여순위(역순)을 포함하여 출력
-- 6. 키테이블 기준 쿼리작성 

--1.전반기 입사자와 후반기 입사자들의 급여평균간의 차이
SELECT H1.H1AVG, H2.H2AVG,
       CASE WHEN H1.H1AVG > H2.H2AVG
            THEN H1.H1AVG - H2.H2AVG
            ELSE H2.H2AVG - H1.H1AVG
       END SUB
FROM (SELECT AVG(SAL) AS H1AVG
      FROM EMP
      WHERE CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 1) H1 LEFT OUTER JOIN (SELECT AVG(SAL) AS H2AVG
                                                                    FROM EMP
                                                                    WHERE CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 2) H2
                                                   ON 1 = 1;
                                                   
--2.평균이 더 높은 쪽의(전반기 입사자와 후반기 입사자중) 사원들의 급여를 차이만큼 증가
SELECT E.ENAME, E.HIREDATE, SAL, CEIL(TO_CHAR(HIREDATE, 'Q')/2), SUB, H1AVG, H2AVG,
       CASE WHEN H1AVG > H2AVG 
            THEN 
                CASE WHEN CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 1
                     THEN SAL + SUB
                     ELSE SAL
                END
            ELSE
                CASE WHEN CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 2
                     THEN SAL + SUB
                     ELSE SAL
                END
            END ADDSUB
FROM EMP E INNER JOIN ( SELECT H1.H1AVG, H2.H2AVG,
                               CASE WHEN H1.H1AVG > H2.H2AVG
                                    THEN H1.H1AVG - H2.H2AVG
                                    ELSE H2.H2AVG - H1.H1AVG
                               END SUB
                        FROM (SELECT AVG(SAL) AS H1AVG
                              FROM EMP
                              WHERE CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 1) H1 LEFT OUTER JOIN (SELECT AVG(SAL) AS H2AVG
                                                                                            FROM EMP
                                                                                            WHERE CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 2) H2
                                                                           ON 1 = 1) HSUB
                   ON 1 = 1;
                   
--3.급여순위 출력
SELECT E.ENAME, 
       E.HIREDATE, 
       SA.GRADE, 
       RANK() OVER(ORDER BY E.SAL2 DESC) AS RNK
FROM (SELECT E.ENAME, E.HIREDATE, SAL, CEIL(TO_CHAR(HIREDATE, 'Q')/2), SUB, H1AVG, H2AVG,
             CASE WHEN H1AVG > H2AVG 
                  THEN 
                      CASE WHEN CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 1
                           THEN SAL + SUB
                           ELSE SAL
                      END
                  ELSE
                      CASE WHEN CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 2
                           THEN SAL + SUB
                           ELSE SAL
                      END
                  END SAL2
      FROM EMP E INNER JOIN ( SELECT H1.H1AVG, H2.H2AVG,
                                     CASE WHEN H1.H1AVG > H2.H2AVG
                                          THEN H1.H1AVG - H2.H2AVG
                                          ELSE H2.H2AVG - H1.H1AVG
                                     END SUB
                              FROM (SELECT AVG(SAL) AS H1AVG
                                    FROM EMP
                                    WHERE CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 1) H1 LEFT OUTER JOIN (SELECT AVG(SAL) AS H2AVG
                                                                                                  FROM EMP
                                                                                                  WHERE CEIL(TO_CHAR(HIREDATE, 'Q')/2) = 2) H2
                                                                                 ON 1 = 1) HSUB
                         ON 1 = 1
     ) E INNER JOIN SALGRADE SA
                 ON E.SAL2 BETWEEN SA.LOSAL AND SA.HISAL
ORDER BY RNK DESC;   




-- 선생님이 풀어줌
SELECT E.ENAME, E.HIREDATE, SG.GRADE, 
             RANK() OVER(ORDER BY E.SAL DESC) AS RNK
FROM (SELECT E.ENAME, E.HIREDATE,
                         CASE WHEN E.HFLAG = ME.MFLAG
                                   THEN E.SAL + ME.MSAL
                                   ELSE E.SAL
                         END AS SAL
            FROM (SELECT ENAME,
                                      HIREDATE,
                                      SAL,
                                      CASE WHEN TO_CHAR(HIREDATE, 'MM') < 7
                                                THEN 0
                                                ELSE 1
                                      END AS HFLAG
                         FROM EMP) E
             INNER JOIN (SELECT CASE WHEN FE.HSAL - LE.HSAL > 0
                                                          THEN 0
                                                          ELSE 1
                                                END AS MFLAG,
                                                ABS(FE.HSAL - LE.HSAL) AS MSAL
                                  FROM (SELECT 0 AS HFLAG, AVG(SAL) AS HSAL
                                              FROM EMP
                                              WHERE TO_CHAR(HIREDATE, 'MM') < 7) FE
                                  INNER JOIN (SELECT 1 AS HFLAG, AVG(SAL) AS HSAL
                                                       FROM EMP
                                                       WHERE TO_CHAR(HIREDATE, 'MM') >= 7) LE
                                               ON 1 = 1) ME
                            ON 1 = 1) E
              INNER JOIN SALGRADE SG
                           ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
ORDER BY RNK DESC
;