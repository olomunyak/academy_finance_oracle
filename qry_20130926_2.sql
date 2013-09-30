-- 1. 무엇을 구하는가?
-- 2. 주테이블 찾기
-- 3. 보조테이블 찾기
-- 4. 조건찾기 
-- 5. 필요한 데이터만 가져오기 
-- 6. 키테이블 기준 쿼리작성
-- 7. 실행 및 검증

-- 문제1) DALLAS에 근무하는 사원들 중 급여순위 3위인 사람의 사원정보를 출력하시오
-- 단, 급여순위 3위가 2명 이상일 경우 사번이 빠른 사람에게 우선순위를 부여하시오.

-- 1. 사원정보 출력
-- 2. 주테이블 --> EMP
-- 3. 보조테이블 --> DEPT
-- 4. 조건 --> DALLAS에 근무하는 사원들 중 급여순위 3위인 사람,
--           급여순위 3위가 2명 이상일 경우 사번이 빠른 사람에게 우선순위 부여
-- 5. 필요한 데이터 가져오기 --> 사원정보..
-- 6. 키테이블 기준 쿼리작성

-- 풀이1
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.DEPTNO
FROM EMP E INNER JOIN (
                        SELECT E.EMPNO, E.ENAME,
                               ROW_NUMBER() OVER(PARTITION BY D.LOC 
                                                 ORDER BY E.SAL DESC, EMPNO ASC) AS RNK
                        FROM EMP E INNER JOIN DEPT D
                                           ON E.DEPTNO = D.DEPTNO
                                           AND D.LOC = 'DALLAS'
                      ) DRANK
                   ON E.EMPNO = DRANK.EMPNO  
WHERE DRANK.RNK = 3;

-- 풀이2
SELECT SALRNK.EMPNO, SALRNK.ENAME, SALRNK.JOB, SALRNK.MGR, SALRNK.HIREDATE, SALRNK.SAL, SALRNK.DEPTNO
FROM  (
          SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC,
                 ROW_NUMBER() OVER(PARTITION BY D.LOC 
                                   ORDER BY E.SAL DESC, EMPNO ASC) AS RNK
          FROM EMP E INNER JOIN DEPT D
                             ON E.DEPTNO = D.DEPTNO
                             AND D.LOC = 'DALLAS'
      ) SALRNK
WHERE SALRNK.RNK = 3;

-- 풀이3
---- 1. 달라스에 근무하는 사원
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC = 'DALLAS';

---- 2. 달라스에 근무하는 사원들의 급여순위                   
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO,
       ROW_NUMBER() OVER(ORDER BY E.SAL DESC, E.EMPNO ASC) RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC = 'DALLAS';
                   
---- 3. 달라스에 근무하는 사원들 중 급여순위 3위인 사원의 정보                   
SELECT DE.EMPNO, DE.ENAME, DE.JOB, 
       DE.MGR, DE.HIREDATE, DE.SAL, 
       DE.COMM, DE.DEPTNO
FROM (  SELECT E.EMPNO, E.ENAME, E.JOB, 
               E.MGR, E.HIREDATE, E.SAL, 
               E.COMM, E.DEPTNO,
               ROW_NUMBER() OVER(ORDER BY E.SAL DESC, E.EMPNO ASC) RNK
        FROM EMP E INNER JOIN DEPT D
                           ON E.DEPTNO = D.DEPTNO
                           AND D.LOC = 'DALLAS' ) DE
WHERE DE.RNK = 3;            


-- 문제2) 12월에 입사한 사원 중 급여 순위 2등의 급여보다 큰 사원들 중 가장 많은 사원이 있는
-- 업무를 구하시오 급여순위가 겹칠시 이름정순으로 추가 정렬하시오

---- 1. 12월에 입사한 사원 중 급여순위 2등의 급여
SELECT SAL
FROM (SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO,
             ROW_NUMBER() OVER(ORDER BY SAL DESC, ENAME) RNK
      FROM EMP
      WHERE TO_CHAR(HIREDATE, 'MM') = 12
     ) RN
WHERE RNK = 2;     

---- 2. 급여보다 많은 사원들을 출력
SELECT * 
FROM EMP
WHERE SAL > (
              SELECT SAL
              FROM (SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO,
                           ROW_NUMBER() OVER(ORDER BY SAL DESC, ENAME) RNK
                    FROM EMP
                    WHERE TO_CHAR(HIREDATE, 'MM') = 12
                   ) RN
              WHERE RNK = 2);

---- 3. 급여보다 많은 사원들을 업무별로 출력
SELECT EMPNO, ENAME, JOB, SAL,
       ROW_NUMBER() OVER(PARTITION BY JOB ORDER BY SAL DESC)
FROM EMP
WHERE SAL > (
              SELECT SAL
              FROM (SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO,
                           ROW_NUMBER() OVER(ORDER BY SAL DESC, ENAME) RNK
                    FROM EMP
                    WHERE TO_CHAR(HIREDATE, 'MM') = 12
                   ) RN
              WHERE RNK = 2);

---- 4. 가장 많은 사원이 있는 업무를 출력
SELECT JOB
FROM (
      SELECT JOB, CNT, RANK() OVER(ORDER BY CNT DESC) AS RNK
      FROM (
            SELECT JOB, COUNT(*) AS CNT
            FROM (
                  SELECT EMPNO, ENAME, JOB, SAL
                  FROM EMP
                  WHERE SAL > (
                                SELECT SAL
                                FROM (SELECT SAL,
                                             ROW_NUMBER() OVER(ORDER BY SAL DESC, ENAME) RNK
                                      FROM EMP
                                      WHERE TO_CHAR(HIREDATE, 'MM') = 12
                                     ) RN
                                WHERE RNK = 2
                              )
                 )
            GROUP BY JOB
           )
     )
WHERE RNK = 1;
