/*
       �� DDL : Create , Alter , Drop --> ��ü  (���̺� , �� , �Լ� , �������ν��� , Ʈ���� , ������ .. )
        
        - ���̺� ���� �� , ������ ������ ���̺� ���ؼ� ����ϰ� �������� : Alter table
        
        1. �÷��� �ڷ����� ���� : varchar(50) ---> varchar (100) 
        2. �÷��� �̸��� ���� , �÷��� ���� , �÷��� �߰�
        3. �÷��� ���������� �߰� (Primary key , Unique , NOT NULL , CHECK , Foreign Key , default ) 
       
*/

-- �ǽ��� ���� ���̺� ����  : �÷��� , ���� ����ǰ� �÷��� �ο��� ���������� ������� ����

create table emp60 
as
select * from employee ;

create table dept60 
as
select * from department ;

select * from emp60;
select * from dept60 ;

-- ������ ���� : user_ , user_constsraints : ������ ���̽��� �����ϴ� ��� ���̺� ���� ���������� ���
select * from user_constraints
where table_name in ( 'EMPLOYEE' , 'DEPARTMENT');

-- ������ ���̺��� ���������� ������� �ʴ´�.
select * from user_constraints
where table_name in ( 'EMP60' ,  ' DEPT60' );

-- 1. Alter Table �� ����ؼ� ���� ���̺� �÷��� �߰� : birth(date) , email(varchar2 (100))
    -- ���̺� �÷��� �߰��� null�� ó�� �� �÷��� �߰��ؾ���
    
desc dept60;

alter table dept60
add (birth date ) ;

-- ���� ���̺� �������� �÷��� �Ѳ����� �߰��ϱ�
alter table dept60
add ( email varchar2(100) , addr varchar2(200) , jumin char (14));

select * from  dept60;

-- ���� ������ �÷��� �� �ֱ� : update

update dept60
set birth = sysdate , email = 'aaa@aaa.com' , addr = '����' , jumin = '123456-1234567'
where dno =10;

rollback;

