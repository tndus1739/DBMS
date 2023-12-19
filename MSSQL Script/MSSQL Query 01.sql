-- �� �� �ּ�

/* 
		���� �� �ּ�
*/

-- 1. ����� DB ����

create database myDB ;

--2. ����� DB�� ����
use myDB;                     -- �׻� ������ ����� �Ѵ�.

-- 3. myDB���� ���̺� ����
/*
		- Oracle                : ���� number(4) , �Ǽ� number (7,2)      ,  ���ڿ� varchar2(50)
		- MSSQL , MySQL  : ���� ( int ) ,        �Ǽ� ( float )  , ���ڿ� varchar(50) 
			- MySQL : double
			- MSSQL : real
*/



create table emp01 (
	eno int not null constraint PK_EMP01_ENO primary key ,
	ename varchar(50) not null,
	salary float not null,
	hiredatae date,
	dno int
);


/*

	��ü�� ��ü �̸� : DB , ���̺�� , ��� , �������ν����� , �Լ��� �� �� �ִ�
	dbo : ��������

	DB�� . ��Ű���� . ��ü�̸�

*/

select * from myDb.dbo.emp01 ;     --  emp01 ���̺��� ��ü �̸� ( mtDB �������� , dbo ��������)

select * from emp01 ; 


/*
		- Oracle  : ������ ���� ( user_*) �� ���� �ý����� ������ ��� , sp_*
		- MSSQL : sp_helpdb ;    �ý����� ��� DB ������ ��� -->  MSSQL���� ����
						 sp_help '��Ű���� , ���̺�� ' :  --> ���̺��� ������ ��� ( ��Ű���̸��� ���� �Է��ؾ� �Ѵ�)

*/

sp_helpdb ;

sp_help 'dbo.emp01' ;   --> desc emp01 , select * from user_constraints where table_name in ( 'EMP01') ; �� 2���� ��ɾ ������

-- 4. ���ֱ� : MSSQL�� �ڵ����� Ŀ�� Ʈ����� ( insert , update , delete )

insert into  emp01 ( eno , ename , salary , hiredatae , dno )     -- �ڵ����� Ŀ��
values ( 1, 'ȫ�浿' , 500 , '81-01-01' , 10);


insert into  emp01 ( eno , ename , salary , hiredatae , dno )
values ( 2, '�̱浿' , 1000 , '91-01-01' , 20);

insert into  emp01 ( eno , ename , salary , hiredatae , dno )
values ( 3, '��浿' , 2000 , '22-03-10' , 30);


-- 5. �� ���� �� ��������� Ʈ������� ���������� rollback �̳� commit�� ����� ��   -- ALL or Nothing

-- ȫ�浿 ���޿��� 30�� ����ؼ� ��浿 �������� �Ա�

begin transaction ;    -- Ʈ����� ����

-- ȫ�浿 ���¿��� 30�� ���
update emp01
set salary = salary - 30 
where eno = 1 ; 

-- �̱浿 ���¿��� 30�� �Ա�
update emp01
set salary = salary + 30 
where eno = 2 ; 


rollback ;     -- ��������� Ʈ������� �����ؾ�  rollback �̳� commit�� �� �� �ִ�. 
commit ;

select * from emp01 ;

-- delete
delete emp01
where eno =1 ;


-- �μ� ���̺� : dept01
create table dept01 (
	dno int not null constraint PK_DEPT01_DNO primary key,
	dname varchar(50) not null , 
	loc varchar(50) null
	);

select * from dept01 ;
sp_help 'dbo.dept01' ;

insert into dept01 
values ( 10 , '�λ��' , '����');

insert into dept01 
values ( 20 , '������' , '�λ�');

insert into dept01 
values ( 30 , '������' , '����');

select * from emp01 ;      -- �� ���̺��� �� ���� �巡���ؼ� ����ϸ� �� ���� �ΰ��� ���̺� ��� ����
select * from dept01 ;

-- alter table �� ����ؼ�  emp01(dno) : FK   --> dept01 (dno)

alter table emp01
add constraint FK_EMP01_DNO foreign key (dno) references dept01 (dno);

sp_help 'dbo.emp01' ;        -- ���̺� ���� ����

-- JOIN : ANSI JOIN  - INNER JOIN   --> ERD ( DB ���� ���̺�� ���̺��� ����)

select * 
	from emp01 e
		join dept01 d
		  on e.dno = d.dno ;

-- �μ��� ����Ǿ� ���� ���� �μ��� ��� : Right Outer Joim 

select *
from emp01 e
		right outer join dept01 d
			on e.dno = d.dno ;
