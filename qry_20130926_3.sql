
-- ������ ����.
-- �޿� ���� �� Ȧ����°�� �ش��ϴ� ������� �޿��� 10%�����Ͽ� ��ü ����� ����� ���ϰ� 
-- ���� ��� �̻��� ������� �޿��� 20%�����Ͽ� ��ü �޿������� ��������� ����Ͻÿ�.

-- 1. �޿����� ���
SELECT E.*, ROW_NUMBER() OVER(ORDER BY SAL) RNK
FROM EMP E;

-- 2. �޿� ���� �� Ȧ����°�� �ش��ϴ� ������� �޿��� 10%�����Ѵ�.
SELECT ERNK.SAL, ERNK.SAL * 0.9, ERNK.RNK
FROM (
      SELECT E.*, RANK() OVER(ORDER BY SAL DESC) RNK
      FROM EMP E
     ) ERNK
WHERE (ERNK.RNK - TRUNC(ERNK.RNK / 2) * 2) = 1;

-- 3. �޿� ���� �� Ȧ����° �ش��ϴ� ������� �޿��� 10%�����Ͽ� ��ü ����� ����� ���Ѵ�.
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

-- 4. �޿� ���� �� Ȧ����° �ش��ϴ� ������� �޿��� 10%�����Ͽ� ��ü ����� ����� ���Ѵ�.
--    ���� ��� �̻��� ������� �޿��� 20%�����Ѵ�
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

-- 5. �޿� ���� �� Ȧ����°�� �ش��ϴ� ������� �޿��� 10%�����Ͽ� ��ü ����� ����� ���ϰ� 
--    ���� ��� �̻��� ������� �޿��� 20%�����Ͽ� ��ü �޿������� ��������� ����Ͻÿ�.
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