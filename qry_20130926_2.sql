-- 1. ������ ���ϴ°�?
-- 2. �����̺� ã��
-- 3. �������̺� ã��
-- 4. ����ã�� 
-- 5. �ʿ��� �����͸� �������� 
-- 6. Ű���̺� ���� �����ۼ�
-- 7. ���� �� ����

-- ����1) DALLAS�� �ٹ��ϴ� ����� �� �޿����� 3���� ����� ��������� ����Ͻÿ�
-- ��, �޿����� 3���� 2�� �̻��� ��� ����� ���� ������� �켱������ �ο��Ͻÿ�.

-- 1. ������� ���
-- 2. �����̺� --> EMP
-- 3. �������̺� --> DEPT
-- 4. ���� --> DALLAS�� �ٹ��ϴ� ����� �� �޿����� 3���� ���,
--           �޿����� 3���� 2�� �̻��� ��� ����� ���� ������� �켱���� �ο�
-- 5. �ʿ��� ������ �������� --> �������..
-- 6. Ű���̺� ���� �����ۼ�

-- Ǯ��1
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

-- Ǯ��2
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

-- Ǯ��3
---- 1. �޶󽺿� �ٹ��ϴ� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC = 'DALLAS';

---- 2. �޶󽺿� �ٹ��ϴ� ������� �޿�����                   
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO,
       ROW_NUMBER() OVER(ORDER BY E.SAL DESC, E.EMPNO ASC) RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
                   AND D.LOC = 'DALLAS';
                   
---- 3. �޶󽺿� �ٹ��ϴ� ����� �� �޿����� 3���� ����� ����                   
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


-- ����2) 12���� �Ի��� ��� �� �޿� ���� 2���� �޿����� ū ����� �� ���� ���� ����� �ִ�
-- ������ ���Ͻÿ� �޿������� ��ĥ�� �̸��������� �߰� �����Ͻÿ�

---- 1. 12���� �Ի��� ��� �� �޿����� 2���� �޿�
SELECT SAL
FROM (SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO,
             ROW_NUMBER() OVER(ORDER BY SAL DESC, ENAME) RNK
      FROM EMP
      WHERE TO_CHAR(HIREDATE, 'MM') = 12
     ) RN
WHERE RNK = 2;     

---- 2. �޿����� ���� ������� ���
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

---- 3. �޿����� ���� ������� �������� ���
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

---- 4. ���� ���� ����� �ִ� ������ ���
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
