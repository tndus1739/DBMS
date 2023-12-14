/*
<����1>  commission(���ʽ�) �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�,�Ի糯¥�� ��� 
<����2> dno(�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���
<����3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���
<����4> commission�� null �� �ƴ� ������� �̸��� ��� 
<����5> manager (���޻��) 7698 �� ����̸��� ��å�� ���.
<����6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥, �μ���ȣ, ������ ���
<����7> �Ի糯¥�� 81�� 4�� 1�� �̻��̰� 81�� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���
<����8> ��å(job) salesman �̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���
<����9> ������ 1500 �����̸鼭 �μ���ȣ�� 20�� �� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���
<����10> �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ��� 
<����11> ������ [SALESMAN]�� �ƴ� ����� �����ȣ,����̸�,����,�޿� �˻�
<����12> �޿��� [2000]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�
<����13> ����̸��� [A],[B],[C]�� ���۵Ǵ� ����� �����ȣ,����̸�,����,�޿� �˻�
<����14> [1981�� 5�� 1��]������ �Ի��� ����� �����ȣ,����̸�,����,�޿�,�Ի��� �˻�
<����15> ������ [SALESMAN]�� ��� �� �޿��� [1500]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�
<����16> �μ���ȣ�� [10]�̰ų� ������ [MANAGER]�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ �˻�
<����17> �޿��� [1000~3000]�� ����� �����ȣ,����̸�,����,�޿� �˻�
*/

select * from employee ;

-- [���� 1]  commission(���ʽ�) �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�,�Ի糯¥�� ��� 

select eno �����ȣ  , ename    ����̸�  , hiredate �Ի糯¥ 
from employee
where commission is null ;

-- [���� 2]  dno(�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���

select ename ����̸�, job ��å , hiredate �Ի糯¥
from employee
where dno = 20  and hiredate >=  '81/04/01' ;

-- [���� 3] ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���   ( ��ü���� : ������ �÷� , ���� DB���� ������� ����)
-- ���� : ��ü������ 30000�̻�

-- ���� = ���� * 12 + ���ʽ�
-- commission�÷����� null���� �ֱ� ������ null��  ���� 0���� ó���� �� ����ؾ��Ѵ�. ( nvl �Լ� ���)
-- NVL ( commission , 0) : commission  �÷��� null�� 0���� ��ȯ��Ŵ

select  eno �����ȣ,  ename ����̸� , salary ���� , commission ���ʽ�, salary * 12  + nvl (commission, 0) ��ü����
from employee
where salary * 12  + nvl (commission, 0)  > 30000;

-- [����4] commission�� null �� �ƴ� ������� �̸��� ��� 

select ename "������� �̸�" , commission 
from employee
where commission is not null;

-- [����5] manager (���޻��) 7698 �� ����̸��� ��å�� ���.

select ename ����̸� , job ��å , manager  from employee 
where manager = 7698 ;

-- [����6] ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥, �μ���ȣ, ������ ���

select ename ����̸� , hiredate �Ի糯¥ , dno �μ���ȣ , salary ����
from employee
where salary >= 1500 and dno = 20 ;

-- [����7] �Ի糯¥�� 81�� 4�� 1�� �̻��̰� 81�� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���

-- and
select ename ����̸� ,  hiredate  �Ի糯¥
from employee
where hiredate >= '81/04/01' and  hiredate <= '81/12/31' ;

-- between A and B : A�� B ����
select ename ����̸� ,  hiredate  �Ի糯¥
from employee
where hiredate between '81/04/01' and  '81/12/31' ;

-- like
select ename ����̸� ,  hiredate  �Ի糯¥
from employee
where hiredate like '81%' ;       -- 81�� ���۵Ǹ鼭 �ڿ� � ���� �͵� �������.

-- [����8] ��å(job) salesman �̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���

select ename ����� from employee
where job = 'SALESMAN' and salary >= 1500 and dno =30 ;

-- [����9] ������ 1500 �����̸鼭 �μ���ȣ�� 20�� �� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���

select ename ����̸�, salary ���� ,  dno �μ���ȣ
from employee
where salary <= 1500 and dno <> 20 ; 

-- [����10] �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ��� 

select dno �μ���ȣ , ename �̸� , job ��å
from employee
where eno  in ( 7788 , 7782 ) ;

select dno �μ���ȣ , ename �̸� , job ��å
from employee
where eno  = 7788  or eno = 7782 ;

-- [����11] ������ [SALESMAN]�� �ƴ� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno �����ȣ ,  ename ����̸� , job  ���� , salary �޿�
from employee
where job ^= 'SALESMAN' ;          --  ���� �ʴ� :  <>   !=   ^=

-- [����12] �޿��� [2000]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno �����ȣ , ename ����̸� , job ���� , salary �޿�
from employee
where salary >= 2000 ;

-- [����13] ����̸��� [A],[B],[C]�� ���۵Ǵ� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno �����ȣ,  ename ����̸� , job ���� , salary �޿�
from employee
where ename like 'A%' or ename like 'B%'  or ename  like 'C%' ;

select eno �����ȣ,  ename ����̸� , job ���� , salary �޿�
from employee
where ename  < 'D' ;


-- [����14] [1981�� 5�� 1��]������ �Ի��� ����� �����ȣ,����̸�,����,�޿�,�Ի��� �˻�

select eno �����ȣ, ename ����̸� , job ���� , salary �޿� , hiredate �Ի���
from employee
where hiredate <= '81/05/01' ;

-- [����15] ������ [SALESMAN]�� ��� �� �޿��� [1500]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno �����ȣ, ename ����̸� , job ���� , salary �޿�
from employee
where job ='SALESMAN' and salary >= 1500 ;


-- [����16] �μ���ȣ�� [10]�̰ų� ������ [MANAGER]�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ �˻�

select eno �����ȣ, ename ����̸� , job ���� , salary �޿�, dno �μ���ȣ
from employee
where dno = 10  or  job = 'MANAGER' ;

--[����17] �޿��� [1000~3000]�� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno �����ȣ , ename ����̸� , job ����, salary �޿�
from employee
where salary >= 1000 and salary <= 3000 ;

select eno �����ȣ , ename ����̸� , job ����, salary �޿�
from employee
where salary between 1000 and 3000 ;




