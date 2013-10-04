-- 상급자가 아닌 사원의 이름, 근무지역, 연봉, 커미션, 연봉+커미션, 연봉등급, 세금 출력
-- 연봉등급과 세금은 연봉+커미션으로 계산
-- 세금 : 커미션 있는사람 7%,
--       커미션이 0이거나 NULL이면 5%

-- 1. 무엇을 구하는가? --> 상급자가 아닌 사원의 이름, 근무지역, 연봉, 커미션, 연봉+커미션, 연봉등급, 세금 출력
-- 2. 주테이블 찾기 --> EMP
-- 3. 보조테이블 찾기 --> DEPT, SALGRADE
-- 4. 조건찾기 -->  상급자가 아닌 사원의 이름
--                 연봉등급과 세금은 연봉+커미션으로 계산
--                 커미션이 있는사람 7%, 커미션이 0이거나 NULL이면 5%
-- 5. 필요한 데이터만 가져오기 --> 상급자가 아닌 사원의 이름, 근무지역, 연봉, 커미션, 연봉+커미션, 연봉등급, 세금 출력
--                              연봉등급과 세금 계산
-- 6. 키테이블 기준 쿼리작성 
            
SELECT E.ENAME, 
       D.LOC, 
       E.SAL, 
       E.COMM, 
       E.SAL + NVL(E.COMM, 0) AS TOTAL, 
       S.GRADE,
       CASE WHEN COMM = 0 
            THEN (E.SAL + NVL(E.COMM, 0)) * 0.05
            WHEN COMM IS NULL
            THEN (E.SAL + NVL(E.COMM, 0)) * 0.05
            ELSE (E.SAL + NVL(E.COMM, 0)) * 0.07
       END AS TAX
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
           INNER JOIN SALGRADE S
                   ON (E.SAL + NVL(E.COMM, 0)) BETWEEN S.LOSAL AND S.HISAL
WHERE E.EMPNO NOT IN (SELECT MGR
                      FROM EMP 
                      WHERE MGR IS NOT NULL);
                     
                     