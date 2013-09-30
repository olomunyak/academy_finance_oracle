
-- RRRR/MM/DD HH24:MI:SS
-- ���� > ȯ�漳�� > �����ͺ��̽� > NLS --> ��¥����

-- ���糯¥ ���
SELECT SYSDATE
FROM DUAL;

-- ��¥���·� ���
-- TO_CHAR('��', '����(����)')
SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD HH:MI:SS')
FROM DUAL;

-- ��������ǥ��
SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;

-- ���ϳ�¥
SELECT TO_CHAR(SYSDATE + 1, 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;

-- ��ȭ������ ����������
-- �ݾ� ���·� ��� (���������� 9�� ����Ѵ�.)
SELECT TO_CHAR(900000, '999,999')
FROM DUAL;

SELECT TO_CHAR(90000.01, '999,999.99')
FROM DUAL;

-- �� ������ ���缭 ���� ǥ��
SELECT TO_CHAR(90000.01, 'L999,999.99')
FROM DUAL;

SELECT TO_CHAR(90000.01, '$999,999.99')
FROM DUAL;

-- ������ ��������
SELECT TO_CHAR(SYSDATE, 'YYYY')
FROM DUAL;

-- ����������� �Ի��Ͽ��� ������ �̾ƿ���
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY'), SAL
FROM EMP;

-- 81�⵵�� �Ի��� ������� ������� ��������
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981';

-- 8������ 12�� ���̿� �Ի��� ������� ���� 
--(���ڿ��� ����ó�� ���Ѵ�. ����Ŭ�� �����ϴ�. �����ϰ� 8�� 08�� �� �ʿ�� ����.)
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') >= 8 AND TO_CHAR(HIREDATE, 'MM') <= 12;

-- 8������ 12�� ���̿� �Ի��� ������� ���� 
-- BETWEEN�� ���
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') BETWEEN 8 AND 12;

-- 1��, 2��, 7���� �Ի��� ������� ����
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = 1 OR TO_CHAR(HIREDATE, 'MM') = 2 OR TO_CHAR(HIREDATE, 'MM') = 7;

-- 1��, 2��, 7���� �Ի��� ������� ����
-- IN�� ����ؼ� ���
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') IN (1, 2, 7);

-- 1��, 2��, 7���� �Ի����� ���� ������� ����
-- NOT IN�� ����ؼ� ���
SELECT EMPNO, ENAME, JOB, TO_CHAR(HIREDATE, 'YYYY/MM/DD'), SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') NOT IN (1, 2, 7);

-- SCOTT�� ADAMS�� ������ ������� ������ ���
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME NOT IN ('SCOTT', 'ADAMS');

-- ���ڸ� ��¥�� ��ȯ
-- ���� ���̿� �ٸ� ����(-, ., /, SPACE)�� �־ �ǰ� ������ �����ָ� �˾Ƽ� �ٲ��ش�.
SELECT TO_DATE('1999-08-01')
FROM DUAL;

SELECT TO_DATE('1999.08.01')
FROM DUAL;

SELECT TO_DATE('1999 08 01')
FROM DUAL;

SELECT TO_DATE('19990801')
FROM DUAL;

-- ���ڸ� ��¥�� ��ȯ�Ҷ� �ú��ʵ� �߰��Ҽ� �ִ�.
SELECT TO_DATE('19990801130102')
FROM DUAL;

-- ���ڸ� ��¥�� ��ȯ�ϰ� �ٽ� ���ڷ� ��ȯ�Ҽ��� �ִ�.
SELECT TO_CHAR(TO_DATE('19990801130102'), 'YYYY.MM.DD AM HH:MI:SS')
FROM DUAL;

-- �ݿø�
-- �Ҽ��� ��°�ڸ����� ����Ѵ�.
SELECT ROUND(11.1191, 2)
FROM DUAL;

-- �ø�
-- ������ �÷�������. �Ҽ����� ����������.
SELECT CEIL(11.11)
FROM DUAL;

-- ����
-- �Ҽ��� ��°�ڸ����� ����Ѵ�.
SELECT TRUNC(11.1191, 2)
FROM DUAL;

-- ��������
-- 365�� �߿� ���° ������ �˷��ش�.
SELECT TO_CHAR(SYSDATE, 'DDD')
FROM DUAL;

-- ������ ���ڷ� �����ش�.
SELECT TO_CHAR(SYSDATE, 'D')
FROM DUAL;

-- ������ ���ڷ� �����ش�.
SELECT TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- ��������� ���������� �����ش�.
-- ��) 9���� ���° ������ ��Ÿ����
SELECT TO_CHAR(SYSDATE, 'W')
FROM DUAL;

-- ��ü(��ü�⵵)���� ���������� �����ش�.
SELECT TO_CHAR(SYSDATE, 'IW')
FROM DUAL;

-- �б�
SELECT TO_CHAR(SYSDATE, 'Q')
FROM DUAL;

-- �ݱ�
-- ��ü�б⿡�� �ø����ش�
SELECT CEIL(TO_CHAR(SYSDATE, 'Q')/2)
FROM DUAL;

-- ������ EX : 2^10
SELECT POWER(2,10)
FROM DUAL;

-- ���ڿ� ���̱� 
-- UNIX LINUX ���� ||(����������) ��ɾ�� ��� ������� �شٴ� �ǹ̴�. 
-- ����Ŭ������ ����������
SELECT 'A' || 'B' || 'C'
FROM DUAL;

-- ||(����������) �� ����. ������ 2�� �̻� �Ǹ� �� �ٴ´�.
-- MySQL�� ��� ���Ѿ��� �ٴµ�, ����Ŭ�� ��� 2�� �ۿ� �� �ȴ�.
-- ���ڿ��� �������� ������������ �̿��ؼ� ����.
SELECT CONCAT('A', 'B')
FROM DUAL;

-- ��¥ǥ���Ҷ� �������� ���� ������ ���� ������ ��� ���� ���
-- ������ ���� ������ ä��� ���ؼ� ����.
SELECT LPAD('A', 6, 'B')
FROM DUAL;

SELECT RPAD('A', 6, 'B')
FROM DUAL;

SELECT RPAD('A', 6, ' ')
FROM DUAL;

-- �ڹٿ����� SUBSTRING�� Ʋ����
-- �ε����� 1 ���� ���۵ǰ� ���� ���� �ε��� ���� ���� ���ڸ�ŭ ��ڴٴ� ���̴�.
-- �̰ź��� �� ��
SELECT SUBSTR('ABCDEFG', 3, 4)
FROM DUAL;

-- ���ڿ��� �ٲܶ� ����Ѵ�.
SELECT REPLACE('ABCDEF', 'A', 'X')
FROM DUAL;

-- ������ �����Ѵ�.
-- ���� ���鸸 �����Ѵ�.
SELECT TRIM('      AB C')
FROM DUAL;

-- ����Ӹ� �ƴ϶� Ư�� ���ڿ��� �յڷ� �����.
SELECT LTRIM(' A B C ', ' A')
FROM DUAL;

-- ������ �����ϱ� ���ؼ� REPLACE�� ������ �ִ�.
SELECT REPLACE(' A B C ', ' ', '')
FROM DUAL;

SELECT RTRIM(' A B C ', 'C ')
FROM DUAL;

-- ���� ã������ �ϴ� ���ڰ� ���°�� �����ϴ��� ��Ÿ����.
-- �տ������� ã�´�.
SELECT INSTR('ABCDEFG', 'A')
FROM DUAL;

-- ��ü���ڿ��� ���̸� ��Ÿ����
SELECT LENGTH('ABCDEFG')
FROM DUAL;