
/*
    select : ���̺��� ���� �˻��� ��
    select �÷��� from ���̺��[���]
    select * from employee;
*/
-- employee ���̺��� ��� �÷��� ����ϱ�
-- * : ��� �÷��� �� ����ض�
select * from employee;  -- �߰��� �����־ ������� / ( ; ���� �� �ܶ�)

-- Ư�� �÷��� ����ϱ�
select eno,ename, job                  -- �� �÷��� ������ , �־��ֱ�  (eno : �����ȣ)
from employee;

-- Ư�� �÷��� ������ ����ϱ� , �÷��� ���� ���� (�÷��̸��� ����� �� �ִ�.)     -- ������ �÷��� ������ ����� �� �ִ�.
select eno, ename, salary, ename, ename, salary , salary * 12            -- salary * 12 : ����
from employee;

-- �÷� �̸��� ��Ī���� �ٱ��� ����ϱ�       -- ����, Ư������ ������ ""�� ������
select eno as �����ȣ,ename �����, salary as ���� , salary*12 as ����   
from employee;

-- as �־ �ǰ� �ȳ־ �� (�÷��̸� ������ ��  as  ���)
-- ������ �÷��� , ������ �ȵ�


-- employee ���̺��� �� �÷��� �ǹ�
select *
from employee;

select eno �����ȣ , ename ����� , job ��å , manager ���ӻ��,           --as �������� , �÷��̸��� ����, Ư������ ���� "" �� ������� ��
       hiredate �Ի糯¥ , salary ���� , commission ���ʽ� , dno �μ���ȣ   --  �������� , ������
from employee;