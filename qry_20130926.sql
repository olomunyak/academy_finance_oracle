
-- RANK, OVER
-- EMP���̺��� �޿�����
SELECT ENAME, SAL, 
       RANK() OVER(ORDER BY SAL DESC) AS RNK
FROM EMP;

-- PARTITION BY
-- EMP���̺��� ������ �޿�����
SELECT ENAME, JOB, SAL,
       RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS RNK
FROM EMP;       

-- PARTATION BY
-- EMP���̺��� ������, �μ��� �޿�����
SELECT E.ENAME, E.JOB, D.DNAME, E.SAL,
       RANK() OVER(PARTITION BY JOB, E.DEPTNO ORDER BY SAL DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
ORDER BY E.JOB, D.DNAME;             

-- ** ������ �ű涧 �߿��� ���� � �������� ������ �ű�� �̴�.
                
                   
-- �ΰ��� ������ �����ϴ� ���� �� ���� �ۿ� ����. 
-- �ٿ� ���� ������ ���̴� ���� �ִ�.
-- ������ ������ ����.
SELECT E.ENAME, E.JOB, D.DNAME, E.SAL,
       ROW_NUMBER() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
-- �޿������� ���͸� �ɶ� ���� ������ �ְ� ���� ������
-- ������ �� �� �ʿ��ѵ� ���� �޿��� ��� �Ի����� ���� ����� ���� ������ �ϰ� ���� ���
-- ������ ����ȭ �ϸ� ����ȭ �Ҽ��� ����(����)�� ��Ȯ�ϰ� ���´�.
-- ��ȣ�� �ű�� ������ ��Ȯ�� ����� ���� ���ϴ� ������ �޾ƿü� �ִ�.
SELECT E.ENAME, E.JOB, E.HIREDATE, E.SAL,
       ROW_NUMBER() OVER(PARTITION BY E.JOB 
                         ORDER BY E.SAL DESC, E.HIREDATE DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO;
                   
                   
-- ROW_NUMBER�� RANK�� ���̴�
-- RANK�� ROW_NUMBER�� ���̴� RANK�� ���� �������� ������ �����ϰ�
-- ROWNUMBER�� ���� ������ �����ͺ� �ٹ�ȣ�� �ٿ��ش�.
-- ������ ǥ���Ҷ��� RANK�� �ϴµ� �ߺ��� ���� ROW_NUMBER�� ����.

-- ROWNUM�� �ٹ�ȣ�� �ٿ��ش�. ORDER BY�� ������ SELECT������ �ٿ��ֱ� ������ ~~
-- �����ڴ� ROWNUM�� ���� ����. ������ ROW_NUMBER��
-- �ױ��� �����͸� �ű�� �ִ�. �׷��� ROW_NUMBER �� ROWNUM���� �� ����.
-- ROW_NUMBER�� RANK�� �Բ� ANSI-DB�� ����.(MySQL, MSSQL���� ����� �����ϴ�.) ������ ROWNUM�� ����Ŭ���� 
-- �ۿ� �� �� ����.
SELECT ROWNUM AS RNUM, ENAME, JOB
FROM EMP
ORDER BY SAL DESC;
--ROWNUM�� �� ��ȣ�� �ٿ��ִµ� ���� ���� ���� ������ �����Ϳ� �ٹ�ȣ�� �ٿ� �ش�.
--ORDER BY�� ���� ���� �Ĵ�
SELECT ROWNUM AS RNUM, ENAME, JOB
FROM EMP
ORDER BY ROWNUM DESC;
-- WHERE�� ������ ORDER BY �� ���۵Ǳ� ���� �ٹ�ȣ�� �ٿ��ְ� �ȴ�.
-- �׷��� ROWNUM���� ������ �Ű��ְ� �Ǹ� �߰� �۾��� �� �ʿ��ϴ�.
SELECT ROWNUM AS RNUM, ENAME, E.JOB, E.SAL
FROM (
      SELECT ENAME, JOB, SAL
      FROM EMP
      ORDER BY SAL DESC
      ) E
ORDER BY ROWNUM ASC;
-- �ַ� ROW_NUMBER�� ����.
-- �����ڵ��� ���� ���� ������ ���Խ����� ����¡ ������ ���� ���� �ȴ�.
-- ������ ��踦 �ؾ� �ϰ� �������� ������ �ϴ� ���������� ROWNUM�� ���� ����.




