
-- "�޿� ����� 2��޿��� 4��ޱ����� ������� ���
-- �� ������� �����"�� �� ������ ��ü ����� �޿���
-- 1.7�� �λ���� ����Ͻÿ�
-- ��� : �̸�, ����, �޿����, �޿�, �λ�޿�
-- ���� : �̸� ��������, ���� �������� 

-- Ǯ��1 
SELECT E.ENAME, E.JOB, SA.GRADE, E.SAL, E.SAL * 1.7 AS UPSAL
FROM EMP E INNER JOIN SALGRADE SA
                   ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
WHERE E.EMPNO NOT IN (SELECT E.MGR
                      FROM EMP E INNER JOIN SALGRADE SA
                                         ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL
                                        AND SA.GRADE IN (2, 3, 4))
ORDER BY E.ENAME ASC, E.JOB DESC;

-- Ǯ��2
SELECT E.ENAME, E.JOB, S.GRADE, E.SAL, E.SAL*1.7 AS SAL2
FROM EMP E INNER JOIN SALGRADE S
                   ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.EMPNO NOT IN (SELECT E.MGR
                      FROM EMP E INNER JOIN SALGRADE S
                                         ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                                        AND S.GRADE BETWEEN 2 AND 4);

-- Ǯ��3
SELECT E3.ENAME, E3.JOB, SA2.GRADE, E3.SAL, E3.SAL * 1.7 AS SAL2
FROM EMP E3 INNER JOIN (SELECT E4.ENAME
                        FROM EMP E4
                        WHERE E4.ENAME NOT IN (SELECT /*E1.ENAME,*/ E2.ENAME
                                               FROM EMP E1 INNER JOIN SALGRADE SA
                                                                   ON E1.SAL BETWEEN SA.LOSAL AND SA.HISAL
                                                                   AND SA.GRADE BETWEEN 2 AND 4
                                                           INNER JOIN EMP E2
                                                                   ON E1.MGR = E2.EMPNO) ) MGR
                    ON E3.ENAME = MGR.ENAME
            INNER JOIN SALGRADE SA2
                    ON E3.SAL BETWEEN SA2.LOSAL AND SA2.HISAL
ORDER BY E3.ENAME, E3.JOB DESC;