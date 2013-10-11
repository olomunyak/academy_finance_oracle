--COMM�� Null�� ������� �޿������ ���ϰ� �� ��պ��� �޿��� ���� �������
--������ ����� ���ϰ� ��ü ������� �� ��պ��� ���� ����� 40%�����Ͽ�
--�޿������� ��Ÿ���ÿ�.
--��, �ٹ����� DALLAS�� ����� ������ 5% CHICAGO�� ����� 7%��Ÿ����
--�������� 3%�� �ΰ��Ѵ� �׸��� �̸��� S�ڰ� ���� ����� ���ܽ�Ų��.
--��� : �����ȣ ����̸� ������� ����޿� ����޿����� ����
--���� : ����޿������� �������� �����Ѵ�.

SELECT E.EMPNO, 
       E.ENAME, 
       E.JOB, 
       E.RESAL, 
       RANK() OVER(ORDER BY RESAL DESC) AS RNK,
       CASE WHEN E.ENAME LIKE '%S%'
            THEN E.RESAL * 0
            ELSE
                 CASE WHEN E.LOC = 'DALLAS'
                      THEN E.RESAL * 0.05
                      WHEN E.LOC = 'CHICAGO'
                      THEN E.RESAL * 0.07
                      ELSE E.RESAL * 0.03
                 END
       END TAX
--       E.LOC
FROM (
      SELECT E.*, ESAL.SAVG,
             CASE WHEN E.SAL > ESAL.SAVG
                  THEN E.SAL * 0.6
                  ELSE E.SAL
             END AS RESAL,
             D.LOC             
      FROM EMP E INNER JOIN (
                              SELECT AVG(SAL) AS SAVG
                              FROM EMP
                              WHERE EMPNO NOT IN (
                                                  SELECT E.EMPNO
                                                  FROM EMP E INNER JOIN (SELECT AVG(SAL) SAVG
                                                                         FROM EMP
                                                                         WHERE COMM IS NULL) SA
                                                                     ON 1 = 1
                                                  WHERE E.SAL < SA.SAVG
                                                 )
                            ) ESAL
                         ON 1 = 1 
                 INNER JOIN DEPT D
                         ON E.DEPTNO = D.DEPTNO                         
     ) E