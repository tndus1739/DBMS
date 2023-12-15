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

-- default ���������� not null �տ� ��ġ�ؾ� �Ѵ�. 
create table account11 (
no number not null primary key,
name varchar(50) not null,
money number  (7,2) default 0  not null 
);

-- 2. �÷��� �ο��� �ڷ��� ���� : char(10) --> char(50) , varchar2(100) --> varchar2(200) 
desc dept;

alter table dept60
modify email varchar(200) ;

-- 3. Ư�� �÷��� ���� 
alter table dept60 
drop column  jumin ;

-- 4. �÷��� �̸� ���� : addr --> address1
alter table dept60
rename column addr to address1 ;

-- 5. ���̺� �̸� ���� : dept60 --> dept70
rename dept70 to dept60;

select * from dept60;

-- 6. ���� ���̺��� �������� �߰� , ���� ( Primary key , Unique key , Foreign key , check , default )

select * from user_constraints where table_name in ('DEPT60' , 'EMP60');
select * from user_constraints where table_name in ('DEPARTMENT' , 'EMPLOYEE');

-- 6-1. Primary key �������� �߰� : dept60 (dno) , emp60 (ename)
    -- ���̺��� 1���� ���� �� �ִ�.
    -- not null �÷��� primary key �� ���� �� �ִ�.
    -- �÷��� null ���� ����� ��
    
-- dept60 (dno)�� Primary key  �������� �߰�  : �������� �̸��� ����ؼ� �ο���
alter table dept60
add constraint PK_DEPT60_DNO primary key (dno);

-- �������� �̸��� ������ ��� : Oracle���� sys_* �� ���۵Ǵ� ������ �̸��� ����
alter table dept60
add  primary key (dno);          --  "constraint PK_DEPT60_DNO"  ��������

alter table emp60
add constraint PK_EMP60_ENO primary key (eno);

-- �������� ����
alter table dept60
drop constraint PK_DEPT60_DNO ;

-- 6-2 . Foreign Key : �ٸ� ���̺��� �÷��� ���� �����ؼ� ���� ���� �� �ִ�.
    -- ���̺� ( �θ� 1��)  --> FK ���̺� (�ڽ� : �ټ�)
    -- JOIN �� on������ ���Ǵ� Ű �÷�
    -- �θ� ���̺��� ���� �÷��� Primary key , Unique�� ������ �� �ִ�. (�θ����̺� Primary key �� Unique�� ������ ������ ���Ѵ�)
    -- ������ �÷��� ������ Ÿ���� �����ϰų� ����ؾ� �Ѵ�.
    
select * from user_constraints where table_name in ('DEPT60' , 'EMP60');

-- �ִ� ���� : Primary Key (1����)  , Foreign Key (2����)    
-- EMP60 (dno) ---> DEPT60(dno)
desc dept60;
desc emp60;

alter table dept60
drop constraint PK_DEPT60_DNO ;

-- Foreign Key ���� ������ �ֱ� ���ؼ���
    -- 1. �θ����̺��� �÷��� Primary Key , Unique �� �־�� �Ѵ�.
    -- 2. ���� �÷��� �ڷ����� ����ϰų� ���ƾ� ��

-- 1) �θ� ���̺��� Primary key �Ҵ�
alter table dept60
add constraint PK_DEPT60_DNO primary key (dno);

-- 2) �ڽ� ���̺��� Foreign Key �Ҵ� : �θ� ���̺��� Primary Key �� ����
alter table emp60
add constraint FK_EMT60_DNO foreign key (dno) references DEPT60 (dno) ;

-- Foreign Key �� JOIN ��  ON ������ ���� �ϴ� �÷�

select eno , ename , salary , e.dno , d.dno , dname , loc
from emp60 e
    join dept60 d
      on e.dno = d.dno ;

-- 6-3. Unique ���� ���� �߰� : �÷��� �ߺ��� ���� ���� ���ϵ��� ����
    -- �� ���̺� ���� �÷��� �ο��� �� �ִ�.
    -- not null , null ��� Unique ��� ����  --> �ֹι�ȣ , Email
    -- null�� ������ �ߺ��ؼ� ���� �� �ִ�. (����Ŭ)
    -- ������ ���� ���� �� ����.
    
desc dept60;
desc emp60;
    
select * from dept60;
    
alter table dept60
add constraint U_DEPT60_EMAIL unique (email) ;
    
insert into dept60
values ( 60 , '������' , '�λ�' , sysdate , '�ää�@aaa' , '�λ�' );
commit ;
    
update  dept60
 set address1 = '��⵵'
where dno = 60 ; 
    
 alter table dept60
add constraint U_DEPT60_ADDRESS1 unique (address1) ;
    
insert into dept60
 values ( 70 , '������' , '�λ�' , sysdate , '�ä�5@aaa' , '���' );
commit ;
    
update dept60   
set address1 = '����'
where dno = 60;
    
-- ���� ���� ����
alter table dept60
drop constraint U_DEPT60_ADDRESS1;
    
-- 6-4 . check �������� �߰� : �÷��� ������ �ο��ؼ� ���ǿ� �´� ���� �Է�
select * from dept60;
select * from emp60;
    
select * from user_constraints where table_name in ('DEPT60' , 'EMP60');
    
alter table emp60
add ( addr varchar2(50) , hdate date ) ;
    
alter table emp60
add age number(3) ;
    
select * from emp60;
    
-- addr �÷��� '����' , '�λ�' , '����'�� ���� �� �ֵ��� ����
-- hdate �÷��� 2023�� 01�� 01��  ~ 2023�� 12�� 31�ϱ����� �ֵ��� ����
-- age �÷��� 0�� ~300���� ������ ����
    
alter table emp60
add constraint CK_EMP60_ADDR1 check (addr in ('����' , '�λ�' , '����'));
    
 insert into emp60  (eno , dno , addr)
 values (8080, 20 , '����');
    
alter table emp60
add constraint CK_EMP60_HDATE 
check (hdate between to_date ('20230101' ,'YYYYMMDD') and to_date('20231231' , 'YYYYMMDD'));
    
insert into emp60 (eno , dno , addr , hdate )
values (2323, 20 , '����', '23/01/01');
 
alter table emp60 
add constraint CK_EMP60_AGE check (age >=0 and age <= 300 );
    
 insert into emp60 (eno , dno , addr , hdate , age )
values (9090, 20 , '����', '23/01/01' ,88);
commit ;
-- 6-5 . NOT NULL  ���� ���� : �÷��� NULL �� ������ ���� , �ݵ�� ���� �Է��� �Ǿ�� �Ѵ�.
    -- �÷��� ���� NULL�� ������ ���� �߻�
        
desc dept60;
select * from dept60;
    
alter table dept60
modify address1 constraint NN_DEPT60_ADDRESS1 not null;   -- null ���� �߰ߵǾ ���� �Ұ�
    
--  update�� null�� ����
update dept60
set address1 = '��⵵'
where address1 is null;
    
select * from user_constraints where table_name in ('DEPT60' , 'EMP60');    
    
insert into dept60
values ( 99, '������' , '�λ�' , sysdate , 'ccc' , '����');

-- 6-6. default : ���� ������ �ƴϴ�. ���������̸��� �ο��� ���� ����. 
    -- �÷��� ���� ���� ���� ��� default�� ������ ���� �ڵ����� ��
    -- default �� ������ �����ϱ� ���ؼ��� default null  --> ���� ���� ������ null�� ���� ( null�� �⺻��)
    
alter table dept60
add address2 varchar2(100) ;
    
alter table dept60
modify address2 default '����';     -- constraint�� ���� �ʴ´�. (�������� �̸��� ������ �� ���� ������)

insert into dept60
values ( 92, '������' , '�λ�' , sysdate , '��cc' , '����', default );             -- �⺻���� �ְ� ������ �������� ���� ���� 'default'�Է����ش�.  

commit;

select * from dept60;

insert into dept60 ( dno , address1)
values (25 , '����' );

-- deault ���� ���� : default null
alter table dept60
modify address2 default null ;

-- �������� ���� : PrimaryKry , Foreign Key , Unique , NOT NULL , Check
    -- alter tale ���̺�� drop ���������̸� ;

-- �������� ���� : default
    -- alter table ���̺�� modify �÷��� default null ;