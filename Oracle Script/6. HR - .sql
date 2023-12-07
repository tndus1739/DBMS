/*
        Oracle�� �پ��� �Լ� ����ϱ�       ; ��ǲ ---> ��� ---> ���
        1. ���ڸ� ó���ϴ� �Լ�
        2. ���ڸ� ó���ϴ� �Լ�
        3. ��¥�� ó���ϴ� �Լ�
        4. ��ȯ �Լ�
        5. �Ϲ� �Լ�

  ��  ���ڸ� ó���ϴ� �Լ� 
  
   - UPPER : �ҹ��ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
   - LOWER : �ҹ��ڷ� ó�����ִ� �Լ�
   - INITCAP : ù �ڸ� �빮�ڷ� ó�����ִ� �Լ�
   - LENGTH : ���ڼ��� ��ȯ ( �ѱ��� �� ->  ���� : 1byte , �ѱ� : 1 byte )
   - LENGTHB : ���ڼ��� ��ȯ ( ���� :  ���� : 1byte , �ѱ� : 3 byte )
   - CONCAT : ���ڿ��� �������ִ� �Լ�
   - SUBSTR : ���ڸ� �߶���� �Լ�
   - INSTR : Ư�� ������ ��ġ���� ���
   - LPAD : ���� �ڸ����� �Է� �޾Ƽ� �������� Ư�� ��ȣ�� ä�� (����)
   - RPAD : ���� �ڸ����� �Է� �޾Ƽ� �������� Ư�� ��ȣ�� ä�� (������)
   - RTRIM : �������� ���� ����
   - LTRIM : ������ ���� ����
   
   - dual : ������ ���̺�

*/

SELECT UPPER ('Oracle') from dual ;

select * from employee ;

select ename as �����̸� , UPPER (ename)  �빮���̸� , LOWER (ename)  �ҹ����̸� , INITCAP(ename) "ù �ڸ� �빮��" from employee;

-- �˻��� �ȵ� : �÷��� ���� ��ҹ��ڸ� ����
select *
from employee
where ename = 'smith';

select *
from employee
where ename = UPPER('smith');

select LENGTH ( 'Oracle mania' ) from dual ;         -- 12�ڸ� (������� ����)
select LENGTH ( '����Ŭ �ŴϾ�') from dual ;            -- 7�ڸ� ( ������� ����)
select length ( 'Oracle mania' ) from dual ; 


select LENGTHB ( 'Oracle mania' ) from dual ;         -- 12�ڸ� (������� ����)
select LENGTHB ( '����Ŭ �ŴϾ�') from dual ;            -- 19�ڸ� ( ������� ����)   -> �ѱ� 1�� : 3byte ( UTF - 8 )

select ename ���� , LENGTH ( ename) ���ڼ� from employee ;       --  �� �÷��� ���ڼ��� �������
select ename ���� , LENGTHB ( ename) ���ڼ� from employee ;

-- CONCAT : ���ڿ��� ���ڿ��� �������ִ� �Լ�
-- ||  : �÷��� �������ִ� ������

select 'Oracle' ,  'Mania' from dual;

select concat ('Oracle' ,  'Mania')  as �����  from dual;

select concat ( ename , job ) from employee;

select ename || job  from employee;

select   ename || '         '  ||    job  as "�̸��� ��å" from employee;       -- as �� �־ �Ǳ�� �ϴµ� �� ������ �ĺ� �����

-- SUBSTR : ���ڸ� �߶���� �Լ� , substsr ( �÷� , 4 , 3 ) ---> �÷��� �ִ� ���ڿ� �� 4��° �ڸ����� 3���ڸ� �߶�ͼ� ���

select substr ( 'Oracle Mania' , 4, 3)  from  dual;            --> index : 1�� ���� ����

select ename �����̸� , substr ( ename , 2, 3 )  as �߶���̸� from employee;

select * from employee;

-- employee ���̺��� �̸�, �Ի���� ��� (SUBSTR �Լ� ���)

select ename ����̸� , substr ( hiredate , 4 , 2) as  �Ի�� from employee; 

-- employee ���̺��� �̸�, �Ի���� ��� (SUBSTR �Լ� ��� , 2���޿� �Ի��� ����� ���)

select ename ����̸� , substr ( hiredate , 4 , 2) as  �Ի�� from employee
where substr ( hiredate , 4 , 2) = '02' ; 

-- select ename ����̸� , substr ( hiredate , 4 , 2) as  �Ի�� from employee        ---- �������� ������� �̸��� ����ϸ� �����߻�
-- where �Ի�� = '02' ; 

-- 81�⵵�� �Ի��� ����� �̸� , �Ի��, �Ի��, �Ի����� ��� ( substr, where ���)

select ename ����̸� , substr (hiredate , 1, 2 ) as �Ի�� , substr (hiredate , 4, 2 ) as �Ի�� , substr (hiredate , 7, 2 )  as �Ի���
from employee
where  substr (hiredate , 1, 2) = 81;

 /* 
��  INSTR : Ư�� ������ index ��ȣ�� ���  , index ��ȣ�� 1���� ����
  - instr ( �÷��� , 'A' ) : �÷����� ���ڿ� �߿��� 'A' r�� �ִ� index ��ȣ�� ���
  - instr ( �÷��� , 'A' , 4 ) : index 4�� ���� �������� A�� ����ִ� index ��ȣ�� ���
  - �˻� ���� ������ 0 ���� ���
*/

select ( instr ( 'Oracle Mania' , 'a' )) from dual ;    -- 3  : a�� ��ġ�� index ��ȣ

select ( instr ( 'Oracle Mania' , 'a' , 4 )) from dual ;  -- 9 : index 4�� ���ĺ��� 'a' �� ��ġ�� index �˻� ( ���� ����)

select ename �̸� , instr ( ename , 'M')  as  M����ġ
from employee;

/*
-- �߿��� �����ʹ� �Ϻθ� ���߰� ���
��  LPAD : LPAD ( �÷���, �ø��ڸ��� , '*')  : ���� �ڸ��� * �� ä�� ( ����) 
��  RPAD : RPAD ( �÷���, �ø��ڸ��� , '*')  : ���� �ڸ��� * �� ä�� ( ������) 

*/
select '770824-123456' �ֹι�ȣ , lpad ( '770824-1' , 20 , '*')  as "LPAD" from dual;         -- �Լ� �ڿ� �÷��̸� ������ ���� " " �� ���������

select '770824-123456' �ֹι�ȣ , rpad ( '770824-1' , 20 , '*')  as "RPAD" from dual; 

select * from employee;

-- hiredate �÷��� �⵵�� ����ϰ� �������� *�� ��� ( substr, rpad �� ����ؼ� ó��)

select ename �̸� ,  rpad (substr ( hiredate , 1, 2), 8 , '*' )  as �Ի����� 
from employee;

/*
�� ���� ó��
- RTRIM : �������� ������ ����
- LTRIM : ������ ������ ����
- TRIM : ����, ������ ������ ��� ����
*/

select '            Oracle Mania                '   as ����  ,
        ltrim ('            Oracle Mania                ') �����ǰ�������,
        rtrim('            Oracle Mania                ') �������ǰ�������,
        trim('            Oracle Mania                ') ����������
from dual;

select * from employee
where ename = LTRIM( '    SMITH');

-- �� �� ���� ���� �� ���� �빮�ڷ� ��ȯ
select * 
from employee
where ename = upper ( trim ('    smith'));

/*
�� ���ڸ� ó���ϴ� �Լ� 
- ROUND : �ݿø��ϴ� �Լ�
- TRUNC : Ư���ڸ������� �߶󳻾����
- MOD : ������ ���� ���
*/

-- ROUND : Ư���ڸ������� �ݿø� ( 5�̻��� �ݿø�, 5�̸��� �߶󳻼� ����)
/*
    ROUND (�Ǽ�) : �Ҽ��� ���ڸ����� �ݿø�
    ROUND (�Ǽ�, �Ҽ����ڸ���) :
                - �Ҽ��� �ڸ� (���) : �Ҽ��� �������� ���������� �̵��ؼ� , �� "���ڸ�"���� �ݿø���   ----> ������
                - ������ �ڸ� (����) : �Ҽ��� �������� �������� �̵��ؼ� , �� "�ڸ�"���� �ݿø���
*/

select 98.7654 as ����,
          round (98.7654)  as R1,                 -- �Ҽ��� �ڿ��� �ݿø� (round �Լ��� ���� ������ ���� ���)
          round (98.7654, 2 )  as R2 ,           -- �Ҽ��� ���������� 2�ڸ� �̵� �� �� �ڿ��� �ݿø�
          round (98.7654, -1 )  as  R3,         -- �Ҽ��� �������� 1�ڸ� �̵� �� �� �ڸ����� �ݿø�
          round (98.7654, -2 )  as  R4,         -- �Ҽ��� �������� 2�ڸ� �̵� �� �� �ڸ����� �ݿø�
          round (98.7654, -3 )  as  R5          -- �Ҽ��� �������� 3�ڸ� �̵� �� �� �ڸ����� �ݿø�
from dual;

-- �ٷ� �ҵ漼 : ������ 3.3  ( salary * 0.033 = �ҵ漼 )
select salary ���� , salary * 0.033 �ҵ漼  , round ( salary * 0.033) R1 , round ( (salary * 0.033) ,  2 )  R2,
           round (salary - ( salary * 0.033) , 2 ) �Ǽ��ɾ�
from employee;

-- TRUNC : Ư�� �ڸ����� �߶� ����
select trunc ( 98.7654 ) T1,
           trunc ( 98.7654 , 2  ) T2,
           trunc ( 98.7654 , -1 ) T3,
           trunc ( 98.7654 , -2 ) T4
from dual ;        





