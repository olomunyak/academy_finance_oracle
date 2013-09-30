
-- RRRR/MM/DD HH24:MI:SS
-- 도구 > 환경설정 > 데이터베이스 > NLS --> 날짜형식

-- 현재날짜 출력
SELECT SYSDATE
FROM DUAL;

-- 날짜형태로 출력
-- TO_CHAR('값', '포맷(형태)')
SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD HH:MI:SS')
FROM DUAL;

-- 오전오후표시
SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;

-- 내일날짜
SELECT TO_CHAR(SYSDATE + 1, 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;

-- 통화형태의 숫자포멧팅
-- 금액 형태로 출력 (숫자포멧은 9만 사용한다.)
SELECT TO_CHAR(900000, '999,999')
FROM DUAL;

SELECT TO_CHAR(90000.01, '999,999.99')
FROM DUAL;

-- 그 지역에 맞춰서 단위 표시
SELECT TO_CHAR(90000.01, 'L999,999.99')
FROM DUAL;

SELECT TO_CHAR(90000.01, '$999,999.99')
FROM DUAL;

-- 연도만 가져오기
SELECT TO_CHAR(SYSDATE, 'YYYY')
FROM DUAL;

-- 사원정보에서 입사일에서 연도만 뽑아오기
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY'), SAL
FROM EMP;

-- 81년도에 입사한 사원들의 사원정보 가져오기
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981';

-- 8월에서 12월 사이에 입사한 사원들의 정보 
--(문자열을 숫자처럼 비교한다. 오라클은 관대하다. 무식하게 8을 08로 쓸 필요는 없다.)
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') >= 8 AND TO_CHAR(HIREDATE, 'MM') <= 12;

-- 8월에서 12월 사이에 입사한 사원들의 정보 
-- BETWEEN을 사용
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') BETWEEN 8 AND 12;

-- 1월, 2월, 7월에 입사한 사원들의 정보
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = 1 OR TO_CHAR(HIREDATE, 'MM') = 2 OR TO_CHAR(HIREDATE, 'MM') = 7;

-- 1월, 2월, 7월에 입사한 사원들의 정보
-- IN을 사용해서 출력
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') IN (1, 2, 7);

-- 1월, 2월, 7월에 입사하지 않은 사원들의 정보
-- NOT IN을 사용해서 출력
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') NOT IN (1, 2, 7);

-- SCOTT과 ADAMS를 제외한 사원들의 정보를 출력
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME NOT IN ('SCOTT', 'ADAMS');

-- 문자를 날짜로 변환
-- 글자 사이에 다른 문자(-, ., /, SPACE)를 넣어도 되고 개수만 맞춰주면 알아서 바꿔준다.
SELECT TO_DATE('1999-08-01')
FROM DUAL;

SELECT TO_DATE('1999.08.01')
FROM DUAL;

SELECT TO_DATE('1999 08 01')
FROM DUAL;

SELECT TO_DATE('19990801')
FROM DUAL;

-- 문자를 날짜로 변환할때 시분초도 추가할수 있다.
SELECT TO_DATE('19990801130102')
FROM DUAL;

-- 문자를 날짜로 변환하고 다시 문자로 변환할수도 있다.
SELECT TO_CHAR(TO_DATE('19990801130102'), 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;

-- 반올림
-- 소수점 둘째자리까지 출력한다.
SELECT ROUND(11.1191, 2)
FROM DUAL;

-- 올림
-- 무조건 올려버린다. 소수점을 없에버린다.
SELECT CEIL(11.11)
FROM DUAL;

-- 버림
-- 소수점 둘째자리까지 출력한다.
SELECT TRUNC(11.1191, 2)
FROM DUAL;

-- 연간일자
-- 365일 중에 몇번째 날인지 알려준다.
SELECT TO_CHAR(SYSDATE, 'DDD')
FROM DUAL;

-- 요일을 숫자로 보여준다.
SELECT TO_CHAR(SYSDATE, 'D')
FROM DUAL;

-- 요일을 문자로 보여준다.
SELECT TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- 현재월에서 몇주차인지 보여준다.
-- 예) 9월의 몇번째 주인지 나타낼때
SELECT TO_CHAR(SYSDATE, 'W')
FROM DUAL;

-- 전체(전체년도)에서 몇주차인지 보여준다.
SELECT TO_CHAR(SYSDATE, 'IW')
FROM DUAL;

-- 분기
SELECT TO_CHAR(SYSDATE, 'Q')
FROM DUAL;

-- 반기
-- 전체분기에서 올림해준다
SELECT CEIL(TO_CHAR(SYSDATE, 'Q')/2)
FROM DUAL;

-- 제곱승 EX : 2^10
SELECT POWER(2,10)
FROM DUAL;

-- 문자열 붙이기 
-- UNIX LINUX 에서 ||(파이프라인) 명령어는 계속 연결시켜 준다는 의미다. 
-- 오라클에서도 마찬가지다
SELECT 'A' || 'B' || 'C'
FROM DUAL;

-- ||(파이프라인) 과 같다. 하지만 2개 이상 되면 안 붙는다.
-- MySQL의 경우 제한없이 붙는데, 오라클의 경우 2개 밖에 안 된다.
-- 문자열을 이을때는 파이프라인을 이용해서 쓴다.
SELECT CONCAT('A', 'B')
FROM DUAL;

-- 날짜표시할때 고정값을 쓰고 싶을때 앞의 공간이 비어 있을 경우
-- 나머지 앞의 공간을 채우기 위해서 쓴다.
SELECT LPAD('A', 6, 'B')
FROM DUAL;

SELECT RPAD('A', 6, 'B')
FROM DUAL;

SELECT RPAD('A', 6, ' ')
FROM DUAL;

-- 자바에서의 SUBSTRING과 틀리다
-- 인덱스가 1 부터 시작되고 앞의 숫자 인덱스 부터 뒤의 숫자만큼 찍겠다는 뜻이다.
-- 이거부터 몇 개
SELECT SUBSTR('ABCDEFG', 3, 4)
FROM DUAL;

-- 문자열을 바꿀때 사용한다.
SELECT REPLACE('ABCDEF', 'A', 'X')
FROM DUAL;

-- 공백을 제거한다.
-- 앞의 공백만 제거한다.
SELECT TRIM('      AB C')
FROM DUAL;

-- 공백뿐만 아니라 특정 문자열을 앞뒤로 지운다.
SELECT LTRIM(' A B C ', ' A')
FROM DUAL;

-- 공백을 제거하기 위해서 REPLACE를 쓸수도 있다.
SELECT REPLACE(' A B C ', ' ', '')
FROM DUAL;

SELECT RTRIM(' A B C ', 'C ')
FROM DUAL;

-- 내가 찾으려고 하는 문자가 몇번째에 시작하는지 나타낸다.
-- 앞에서부터 찾는다.
SELECT INSTR('ABCDEFG', 'A')
FROM DUAL;

-- 전체문자열의 길이를 나타낸다
SELECT LENGTH('ABCDEFG')
FROM DUAL;