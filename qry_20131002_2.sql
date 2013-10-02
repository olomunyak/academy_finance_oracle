
--�޿���޺� ������� ���� ���� ����� ������ ������� ����� ���ϰ�
--��ü ��� �� ���� ��� �̻��� ������� �޿��� 50% �����Ͽ�
--�޿��������� ���

-- 1. ������ ���ϴ°�? --> ��� �̻��� ������� �޿��������� ��� ���
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� --> SALGRADE
-- 4. ����ã�� -->  �޿���޺� ������� ���� ���� ����� ������ ������� ���
--                 ��ü ��� �� ���� ��� �̻��� ������� �޿��� 50% ����
--                 �޿��������� ���
-- 5. �ʿ��� �����͸� ��������
-- 6. Ű���̺� ���� �����ۼ� 


--1. �޿���޺� �����
SELECT S.GRADE, COUNT(*) AS CNT, RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
FROM EMP E INNER JOIN SALGRADE S
                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY S.GRADE;                   

--2. ���� ���� ����� ������ ������� ���
SELECT AVG(E.SAL)
FROM EMP E INNER JOIN SALGRADE S
                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE S.GRADE NOT IN (SELECT G.GRADE
                      FROM (SELECT S.GRADE, COUNT(*) AS CNT, RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
                            FROM EMP E INNER JOIN SALGRADE S
                                               ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                            GROUP BY S.GRADE) G
                      WHERE RNK = 1);


--3. ��ü ��� �� ���� ��� �̻��� ������� �޿��� 50% �����ؼ� �޿��������� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.SAL * 0.5 AS SALDOWN, E.COMM, E.DEPTNO
FROM EMP E INNER JOIN ( SELECT AVG(E.SAL) AS RESAL
                        FROM EMP E INNER JOIN SALGRADE S
                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                        WHERE S.GRADE NOT IN (SELECT G.GRADE
                                              FROM (SELECT S.GRADE, COUNT(*) AS CNT, RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
                                                    FROM EMP E INNER JOIN SALGRADE S
                                                                       ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                                    GROUP BY S.GRADE) G
                                              WHERE RNK = 1)) A
                   ON 1 = 1
WHERE E.SAL > A.RESAL
ORDER BY E.SAL DESC;

-->���
--�޿���޺� ������� ���� ���� ����� ������ ������� ����� ���ϰ�
--��ü ��� �� ���� ��� �̻��� ������� �޿��� 50% �����Ͽ�
--�޿��������� ���
SELECT E.EMPNO, 
       E.ENAME, 
       E.JOB, 
       E.MGR, 
       E.HIREDATE, 
       E.SAL, 
       E.SAL * 0.5 AS SALDOWN, 
       E.COMM, 
       E.DEPTNO
FROM EMP E INNER JOIN ( 
                        -- �޿���޺� ������� ���� ���� ����� ������ ������� ���
                        SELECT AVG(E.SAL) AS RESAL
                        FROM EMP E INNER JOIN SALGRADE S
                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                        WHERE S.GRADE NOT IN (
                                                -- �޿���޺� ������� ���� ���� �޿���� 
                                                SELECT G.GRADE 
                                                FROM (
                                                        -- �޿���޺� ����� �� ����
                                                        SELECT S.GRADE, 
                                                               COUNT(*) AS CNT, 
                                                               RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
                                                        FROM EMP E INNER JOIN SALGRADE S
                                                                           ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                                        GROUP BY S.GRADE
                                                     ) G
                                                WHERE RNK = 1
                                              )
                      ) SA
                   ON 1 = 1
WHERE E.SAL >= SA.RESAL
ORDER BY E.SAL DESC;