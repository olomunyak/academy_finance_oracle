
-- ����3)
-- ���ݱ� �Ի��ڿ� �Ĺݱ� �Ի��ڵ��� �޿������ ���ϰ�
-- �� ��հ��� ���̸� ���Ͽ� ���ݱ�� �Ĺݱ� �� ����� ��
-- ���� ���� ������� �޿��� ���̸�ŭ ���������� �� �޿���ް�
-- �޿� ����(����)�� �����Ͽ� ����Ͻÿ�
-- ��� : �����, �Ի���, �޿����, �޿�����
-- ���� : �޿����� ����

-- 1. ������ ���ϴ°�? --> �޿���ް�, �޿����� ���                   
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� -->
-- 4. ����ã�� --> 
-- 5. �ʿ��� �����͸� �������� --> ���ݱ� �Ի��ڿ� �Ĺݱ� �Ի��ڵ��� �޿���հ��� ����
--                              ����� �� ���� ����(���ݱ� �Ի��ڿ� �Ĺݱ� �Ի�����) ������� �޿��� ���̸�ŭ ����
--                              �޿���ް� �޿�����(����)�� �����Ͽ� ���
-- 6. Ű���̺� ���� �����ۼ� 

--1.���ݱ� �Ի��ڿ� �Ĺݱ� �Ի��ڵ��� �޿���հ��� ����
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
                                                   
--2.����� �� ���� ����(���ݱ� �Ի��ڿ� �Ĺݱ� �Ի�����) ������� �޿��� ���̸�ŭ ����
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
                   
--3.�޿����� ���
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




-- �������� Ǯ����
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