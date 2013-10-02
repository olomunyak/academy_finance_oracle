
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = 'CLERK';

-- UNION�� ����� ����� �����ش�.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = 'CLERK'
UNION
SELECT EMPNO, ENAME, 'STUDENT', SAL * 0.1
FROM EMP
WHERE JOB <> 'CLERK';

-- UNION�� ���� ����� �Ʒ��� ����� �� �����ش�.
-- ��Ǹ� ������ �� �����ش�.
SELECT 0 AS FLAG, EMPNO, ENAME, JOB, SAL
FROM EMP
UNION
SELECT 1 AS FLAG, EMPNO, ENAME, 'STUDENT', SAL * 0.1
FROM EMP;

-- UNION�� �ߺ��Ǵ� �����͸� �������ش�.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
UNION
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SCOTT';

-- UNION ALL �� �ߺ����Ÿ� ���� �ʴ´�.
-- ** UNION�� ���� �Ͱ� �Ʒ��� ���� �����ִµ� ALL�� ������ �ߺ��� �������� �ʰ� ������ �ߺ��� �����Ѵ�.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
UNION ALL
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SCOTT';

-- �����Ϳ� �����͸� ���ļ� �ϳ��� �����ͷ� ����� ������ UNION�� ����.
-- ���� �Ǹŷ��� ����� ���ε��� �������� ������


-- �ߺ�����
SELECT E2.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;
                    
SELECT DISTINCT E2.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;                    
                    
SELECT DISTINCT E2.ENAME, E2.JOB
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;                                        
                    
SELECT DISTINCT E2.ENAME, E2.JOB, E1.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO;  

-- <> NOT �̶�� ���̴�. (!=, NOT IN �� ����)                    
SELECT DISTINCT E2.ENAME, E2.JOB, E1.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO
WHERE E1.JOB <> 'CLEARK';                    

SELECT DISTINCT E2.ENAME, E2.JOB, E1.ENAME
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO
WHERE E1.JOB NOT IN ('CLEARK');                    
                    

-- MINUS
-- ���� ������� �Ʒ��� ����� ��ġ�Ǵ� ���� �ִٸ� ���ش�.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
MINUS
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SCOTT';                    