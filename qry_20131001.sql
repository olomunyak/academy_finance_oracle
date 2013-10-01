-- ����1)
-- ���� �Ի��ڵ��� ���帹�� ���� ���� ���� �ο��� ���Ե�
-- �μ� ������� �޿� ����� ���Ͻÿ�

-- 1. ������ ���ϴ°�? --> ������� �޿����
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� --> DEPT
-- 4. ����ã�� -->  ���� �Ի��ڵ��� ���帹�� ���� ���� ���� �ο��� ���Ե� �μ�
-- 5. �ʿ��� �����͸� �������� --> 
-- 6. Ű���̺� ���� �����ۼ� 


--1.���� �Ի��ڵ��� ���� ���� ��
SELECT HMONTH
FROM (
      SELECT HMONTH, CNT, RANK() OVER(ORDER BY CNT DESC) AS RNK
      FROM (
            SELECT TO_CHAR(HIREDATE, 'MM') AS HMONTH, COUNT(*) AS CNT
            FROM EMP
            GROUP BY TO_CHAR(HIREDATE, 'MM')
           )
     )
WHERE RNK = 1;

--2.���� �Ի��ڵ��� ���� ���� ���� �Ի��� ������� �������
SELECT *  
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = (
                                  SELECT HMONTH
                                  FROM (
                                        SELECT HMONTH, CNT, RANK() OVER(ORDER BY CNT DESC) AS RNK
                                        FROM (
                                              SELECT TO_CHAR(HIREDATE, 'MM') AS HMONTH, COUNT(*) AS CNT
                                              FROM EMP
                                              GROUP BY TO_CHAR(HIREDATE, 'MM')
                                             )
                                  )
                                  WHERE RNK = 1
                                );

--3.���� �Ի��ڵ��� ���� ���� ���� ���� ���� �Ի��� �μ�
--������� �޿� ����� ���Ͻÿ�
SELECT AVG(SAL)
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = ( SELECT DNAME
                  FROM (SELECT DNAME, CNT, RANK() OVER(ORDER BY CNT DESC) RNK
                        FROM (SELECT D.DNAME, COUNT(*) AS CNT
                              FROM EMP E INNER JOIN DEPT D
                                                 ON E.DEPTNO = D.DEPTNO
                              WHERE TO_CHAR(HIREDATE, 'MM') = ( SELECT HMONTH
                                                                FROM (SELECT HMONTH, CNT, RANK() OVER(ORDER BY CNT DESC) AS RNK
                                                                      FROM (SELECT TO_CHAR(HIREDATE, 'MM') AS HMONTH, COUNT(*) AS CNT
                                                                            FROM EMP
                                                                            GROUP BY TO_CHAR(HIREDATE, 'MM')))
                                                                WHERE RNK = 1)
                              GROUP BY D.DNAME))
                  WHERE RNK = 1 );
                               
--����2)
--KING�� ����ڷ� �� ������� �޿� ����� ���ϰ�
--�� ��� �̻��� ������� �޿��� 30% �����ϰ� KING�� KING��
--����ڷ� �� ������� �����ϰ� ����Ͻÿ�

-- 1. ������ ���ϴ°�? --> ������� �޿����
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� --> 
-- 4. ����ã�� -->  KING�� ����ڷ� �� �����, KING�� KING�� ����ڷ� �� ������� �����ϰ� ���
-- 5. �ʿ��� �����͸� �������� --> 
-- 6. Ű���̺� ���� �����ۼ� 

--1.KING�� ����ڷ� �� ������� �޿� ���
SELECT AVG(E1.SAL)
FROM EMP E1 INNER JOIN EMP E2
                    ON E1.MGR = E2.EMPNO
WHERE E2.ENAME IN ('KING');

--2.KING�� ����ڷ� �� ������� �޿� ����� ���ϰ�
--�� ��� �̻��� ������� �޿��� 30% ����
SELECT E.*, KEMP.*,
       CASE WHEN E.SAL > KEMP.SAL
            THEN E.SAL * 0.7
            ELSE E.SAL
       END SAL
FROM EMP E INNER JOIN (
                        SELECT AVG(E1.SAL) AS SAL
                        FROM EMP E1 INNER JOIN EMP E2
                                           ON E1.MGR = E2.EMPNO
                        WHERE E2.ENAME IN ('KING')
                      ) KEMP
                   ON 1 = 1;

--3.KING�� ����ڷ� �� ������� �޿� ����� ���ϰ�
--�� ��� �̻��� ������� �޿��� 30% ����                   
-- KING�� KING�� ����ڷ� �� ������� �����ϰ� ����Ͻÿ�                   
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, /* KEMP.SAL, */
       CASE WHEN E.SAL >= KEMP.SAL
            THEN E.SAL * 0.7
            ELSE E.SAL
       END RESAL
FROM EMP E LEFT OUTER JOIN (SELECT AVG(E1.SAL) AS SAL
                            FROM EMP E1 INNER JOIN EMP E2
                                                ON E1.MGR = E2.EMPNO
                                                AND E2.ENAME IN ('KING')) KEMP
                        ON 1 = 1
           INNER JOIN EMP E3
                   ON E.MGR = E3.EMPNO
                   AND E3.ENAME NOT IN ('KING')
WHERE E.ENAME NOT IN ('KING');

--����2) (���� �����ؼ� �� Ǯ�̰� Ʋ���� �ٽ� �ۼ�)
--KING�� ����ڷ� �� ������� �޿� ����� ���ϰ�
--�� ��� �̻��� ������� �޿��� 30% �����ϰ� KING�� KING��
--����ڷ� �� ������� �����ϰ� ����Ͻÿ�
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, E.SAL * 0.7 AS RESAL
FROM EMP E INNER JOIN (
                        SELECT AVG(E1.SAL) AS SAL
                        FROM EMP E1 INNER JOIN EMP E2
                                           ON E1.MGR = E2.EMPNO
                        WHERE E2.ENAME IN ('KING')
                      ) KEMP
                   ON 1 = 1
           INNER JOIN EMP E3
                   ON E.MGR = E3.EMPNO
                   AND E3.ENAME NOT IN ('KING')
WHERE E.SAL > KEMP.SAL
AND E.ENAME NOT IN ('KING');