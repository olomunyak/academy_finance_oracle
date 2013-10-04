-- ����ڰ� �ƴ� ����� �̸�, �ٹ�����, ����, Ŀ�̼�, ����+Ŀ�̼�, �������, ���� ���
-- ������ް� ������ ����+Ŀ�̼����� ���
-- ���� : Ŀ�̼� �ִ»�� 7%,
--       Ŀ�̼��� 0�̰ų� NULL�̸� 5%

-- 1. ������ ���ϴ°�? --> ����ڰ� �ƴ� ����� �̸�, �ٹ�����, ����, Ŀ�̼�, ����+Ŀ�̼�, �������, ���� ���
-- 2. �����̺� ã�� --> EMP
-- 3. �������̺� ã�� --> DEPT, SALGRADE
-- 4. ����ã�� -->  ����ڰ� �ƴ� ����� �̸�
--                 ������ް� ������ ����+Ŀ�̼����� ���
--                 Ŀ�̼��� �ִ»�� 7%, Ŀ�̼��� 0�̰ų� NULL�̸� 5%
-- 5. �ʿ��� �����͸� �������� --> ����ڰ� �ƴ� ����� �̸�, �ٹ�����, ����, Ŀ�̼�, ����+Ŀ�̼�, �������, ���� ���
--                              ������ް� ���� ���
-- 6. Ű���̺� ���� �����ۼ� 
            
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
                     
                     