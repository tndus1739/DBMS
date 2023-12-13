/* 
    �� SQL : ��� ���� ���� , select , create , alter , drop , insert , update , delete , grant , revoke , rollback , commit
            �� ����ȭ�� ���� ���

    �� SQL ����
    - DQL (Date Query Language) : ��� , �˻� , select (���)
    - DDL (Date Definition Language) : ���� ���� Ʋ�� ����� ��  , ��ü�� ���� ���� , ����
                                                           ��  ��Ű�� (Ʋ, ����) , ��ü (���̺�, ��, �Լ� , ������ , Ʈ���� , �������ν��� , �ε���) ���� , ����, ����
                                                                 create (����) , alter (����) drop (����)
    - DML ( Date Manupulation Language) : ���̺��� �����(��)�� �����ϴ� ��� �ڡڡ�
                                                                        insesrt (�Է�) , update (����) , delete (����) , rollback (�޸𸮿� ����� ������ �ٽ� ������ ���·� �ǵ���) 
                                                              ��   - transaction�� �߻� (RAM) , commit : RAM�� ����� ������ DataBase�� ������ �����ϵ��� �� 
                                                                     - transaction�� insert , update, delete �� ���۵Ǹ� �ڵ����� transaction  �� ���۵�
                                                                     - transaction�� �����ϴ� �� : rollback , commit
                                                                     - transaction�� ������� ������ Lock�� �ɷ������� transaction�� ����� ������ LOCK�� �ɷ� �ִ�.
                                                                     - ����Ŭ : DML���� �����ϸ� �ڵ����� transaction�� ���۵� , ����� ���� ����ؾ��Ѵ�. (rollback , commit)
                                                                     - MYSQL , MSSQL , : DML ���� �����ϸ� �ڵ����� transaction�� ���۵ǰ� commit�� �ڵ����� ó���� 
                                                                     - ��������� transaction�� ������ �� �ְ� ��������� ���� �� �ִ�.    
     - DCL ( Data Control Language ) : ���� (Account)���� ��ü (Resource)��  ������ �ο��� 
                                                               grant ( �ο� ) , revoke (����)
    
     - TCL ( Transaction Control Language) : transaction�� �����ϴ� ��� ��  DML������ ����
                                                                          commit : DB�� ������ ����
                                                                          rollback : ������� �ǵ���
                                                                          savepoint : transaction ������ �ӽ� ������� ����
                                                                          begin transaction : ��������� transaction ����
 
 
    �� Transaction : �۾� (��)�� ó���ϴ� �ּ� ���� : ALL or NOTHING  �� �Ǹ� ���� �ǰ� �ϰų� �ȵǸ� ���� �ȵǰ� ��
                                transaction log�� ��ϵǾ� �ִ�. �� ��������� �ƴ϶� ������ �������� ��������
 
    �� Transaction�� 4���� Ư¡
    
    - ���ڼ� ( Atomicity ) : ���� ó���ϴ� �ּ� ����
    - �ϰ��� ( Consistency ) ;transaction���� ó���� ����� �ϰ����� ������.  ( ALL or NOTHING )
    - ������ ( Isolation ) : �ϳ��� transaction�� �ٸ� transaction�� �ݸ��Ǿ� �ִ�. (���� transaction�� �����ϱ� �������� LOCK�� �ɷ��־ �ٸ� ����ڵ��� ���� �Ұ�)
    - ���Ӽ� ( Durability ) : commit , DB�� ���������� ����� 
                                                
*/

-- ���̺� ����

create table account10                 -- ��ũ���۾��� �ý����� ������ ��� X ( ����ϰ� �ʹٸ� " " �� ������� ��)
as
select eno as no , ename as name  , salary as account
from employee ;

-- ������ ���� ���̺� ( no : ���¹�ȣ , name : ������ , account : �Աݾ� ) , �����

select * from account10 ;

-- SMITH ���� MILLER���� 10���� �Ա� ( 2���� update ������ �ϳ��� transaction���� ó�� : ALL OR NOTHING   )
    -- SMITH   Account  -10��  :  update account10 set account = accoint  - 10 where no = 7369
    -- MILLAR Account  +10��  :  update account10 set account = accoint  + 10 where no = 7934

-- begin transaction ;        -- ��������� transaction�� ���� ( �������� )

update account10
set account = account - 10 
where no = 7369 ;

update account10 
set account = account  + 10 
where no = 7934 ;

--  transaction ����
rollback ;
commit ; 


--  �� DML : insert ( ���� �Է�) , update ( ����) , delete (����)                 -------> �� 3���� ���������� commit ����ϰ� ������ �ٸ� ������ ��� X
        --> ���� ������ �Է��ϸ�  transaction�� �ڵ����� ���۵����� 
--           ����� rollback �̳� commit �� �Է��ؼ� ���� ����ؾ� �Ѵ�.  (����Ŭ�� ���� ���) 
        
--  ���̺� ����
create table dept03
as
select * from department ;

select * from dept03 ;

-- dept03 : primary key �������� �߰�
alter table dept03 
add constraint PK_DEPT03_DNO primary key (dno) ;

-- INSERT ���ǻ���
    -- �� �÷��� �ڷ��� ( number , ���� , ��¥ , �÷��� ����� ���� ������ Ȯ��)
    
desc dept03 ;                                               -- �������� Ȯ�� ( number , ���� , ��¥ .. )
select * from user_constraints  where table_name in ('DEPT03') ;              --���̺��� �������� Ȯ��

-- insert into ���̺�� ( �÷��� , �÷��� , �÷��� ) values ( �� , �� , �� ) ;

insert into dept03 ( dno , dname , loc)
values (50 , 'HR' , 'SEOUL') ;

commit; 

select * from dept03 ;          -- select �� RAM (�޸�)�� �ִ� ���븸 ���� ��

-- insert �� �÷��̸��� ������� �ʴ� ��� ��� �÷��� ���� �־�� �� (values �ȿ� ������� ���� �־�� ��)
insert into dept03 
values (60 , '�λ��' , '�λ�');
commit; 

-- �÷� ���� �� ����  ��� �÷��� ���� ������ �°� �Է��ؾ���
insert into dept03         -- ����
values ( 70 , '�λ��') ;

-- �÷��� ����� �� ������ �ٲ� �� �ְ� , Ư���÷��� ���� ���� �ʾƵ� ��)
insert into dept03 (dname , dno )
values ( '������' , 80 ) ;

commit; 

-- update �� : ������ �Էµ� ���� ������ ���, �ݵ�� where ������ ��� , where ���ǿ� ���Ǵ� �÷�dms Primary Key �÷��̾�� ��
/*
        update ���̺��
        set �÷��� = �ٲܰ� , �÷��� = �ٲܰ�
        where ����

*/
-- -------------------------------
update dept03
set loc = '�뱸'
where dno = 80 ;

rollback ;
-- --------------------------------
update dept03
set  dname = '������' ,  loc = '����'
where dno =40;
-- --------------------------------
commit ;

select * from dept03 ;
-- --------------------------------
insert into dept03 
values (90 , '������' , '�뱸') ;

--  update ���� �ݵ�� where ���� ��� , ������ ó���ϴ� �÷��� Primary Key , Unique Key �÷��� ����
insert into dept03 
values (91 , '������' , '����') ;

update dept03
set dname = '�μ��'
where loc = '����' ;           -- �ߺ��� �� (�� ���� ���� ������Ʈ �Ǵ��� Ȯ��)

select * from dept03 ;

-- update  �� primary key �÷��� �������� ó���ؼ� ���ϴ� ���� ����

update dept03
set dname = '�μ��'
where dno in ( 91 , 80 );
commit ;
 
-- Delete : ���ڵ带 ������ �� ��� ( where [����] , [���� : �ߺ����� �ʴ� ����] )
/*
        delete ���̺��
        where ����
        
*/

select * from dept03 ;

-- delete ������ ������ ������� �ʴ� ��� : ��� ���ڵ尡 ������

delete dept03 ;
rollback ;
commit ;

-- delete , where ���� ���

delete dept03
where dno =91 ;

-- ��� ���ڵ带 ���� 
    -- delete                               : ���ڵ� �ϳ��ϳ��� ���� , �ð��� ���� �ɸ� [�ο췹�� ����]
    -- truncate table ���̺��     : ��� ���ڵ带 �� ���� ���� ( ���̺� Ʋ (��Ű��) �� �״�� �ΰ� �ȿ� ���ڵ常 ���� )[���� ����]  --> DDL�� �̱� ������ rollback �� �ȵ�
    -- drop table ���̺��         : ���̺� ��ü�� ����

select * from dept03 ;
rollback ;
commit ;

-- ���� ���� ��� ���ڵ� ���� : ���� ����  --> rollback ����
delete dept03 ;

-- ��� ���ڵ� ���� : ���� ���� --> DDL�� �̱� ������ rollback �� �ȵ� (���� �� �ٷ� Ŀ�� ��)
    -- ������ ó����
    
truncate table dept03 ;

-- -------------------------
create table emp04
as
select * from employee ;

select * from emp04;

/*
    emp04
    ������ ���� �߰� : insert
    ������ ���� ���� : update
    ������ ���� ���� : delete
*/

insert into emp04 ( eno , ename , job , hiredate , dno )
values (8000 , 'SOOYEON' , 'PRESIDENT' , '93/01/08' , 30 );
insert into emp04 ( eno , ename , job , hiredate ,salary ,  dno )
values (8111 , 'MMMM' , 'PRESIDENT' , '20/09/11' ,5000 , 20 );

select * from emp04;

update emp04
set job ='MANAGER' , manager = '1111'
where eno in (7369 , 7499) ;

update emp04
set salary  =5000 , manager = '2222'
where eno in (7521 ,7566) ;

delete emp04
where eno = 7934 ;

commit ;

-- -----------------------------------------------------
/*
        �� DDL : create (����) , alter (����) , drop ( ���� ) --> �����̺�� , �� , �Լ� , ������ , Ʈ���� , �������ν���,  ��Ű�� (���� �ֱ� ���� Ʋ ) �� ���� , ���� , ����
        
        �ڷ��� : �����͸� �����ϴ� Ÿ��
            - ���� : number (3)  : ���� 3�ڸ�
                         number ( 7, 2 ) : �Ҽ�  , ��ü 7�ڸ� , �Ҽ������� 2�ڸ����� 
        
            - ���� : char (n)  :  ���� 1�� (1byte) , �ѱ� 1�� 3 (3byte) 
                                     ->  ������ �������� �ϵ� ���� ���� �߻��� �� �ִ�. (����� ���ÿ� �ϵ忡 �Ҵ��� �޾Ƽ� ���� �Ϻθ� ���͵� �ϵ忡 ������ �״�� ����) 
                                            �ֹι�ȣ (13) , �ڸ����� ������ ���� ����    
                                            (ex)  char (10)  : ����� 10�ڱ��� , �ѱ��� 3�ڱ��� ����
                                            
                         varchar2 (n) : ���� 1�� (1 byte) , �ѱ� 1�� ( 3byte)            
                                            -> �ϵ���� ���� ���� ���� ( ������ ���������� ���� , ������ ������ ���� ���� ������ ���� ������ �����)        
                                                ������������ ����� , ������ char���� ���� �� ������ �ϵ������ �������� �ʴ´�.
                                                �ڸ����� �� �� ���� ���ڿ��� ����
                                                nchar (n)            --> ncahr(10)         :  �ѱ� 10�ڱ��� ����   ( n�� ������ �����ڵ� 10�ڱ��� ����)
                                                nvarchar2(n)     --> nvarchar(10)   :  �ѱ� 10�ڱ��� ����
            - ��¥ : date  : BC 4712�� 1�� 1��  ~  9999�� 12�� 31�� ���� ����  --> �� , �� , �� , �� , ��, �� ������ ���� ����
                         timestamp : insert ( ���� ������ �ý����� �ð�)  --> �� , �� , �� , �� , ��, �� , �и������� ���� ����
            - LOB ������ Ÿ�� : �뷮�� ���� ���� , ���̳ʸ� ����
                    - CLOB : ���ڸ� �뷮���� ���� �� �ִ�. --> �۳���
                    - BLOB : mp3 , jepg , hwp ���� ������ ����
                    - BFile : ��뷮 ���� ����
*/

-- ----------------------------------------------------------------------

create table test10 (
            id number (4) not null primary key,        -- �ߺ��� ���� ���� �� ����. ���� 4�ڸ�� ����
            n1 char (10) ,                                -- ���� 10 �� , �ѱ� 3�� ���� ����
            n2 nchar (10) ,                              -- ���� 10�� , �ѱ� 10�� ���� ����
            n3 varchar2(10)  ,                         -- ���� 10 �� , �ѱ� 3�� ���� ����
            n4 nvarchar2 (10)                         -- ���� 10�� , �ѱ� 10�� ���� ����
 );
 drop table test10 ;
 
select * from test10 ;

insert into test10 ( id , n1 , n2 , n3 , n4)
values ( 1111 , 'ababababab' , '��������������������' , 'opopopopop' , '��������������������' );

insert into test10 (id , n2)
values ( 1010, 'aaaaaaaaa');

insert into test10 (id , n1)
values ( 2222, '������');


-- --------------------------------------------------------------------------------------------------
/*

�� �������� : ���̺��� �÷��� ���� Ű , �������� ���Ἲ ( ���Ծ��� ������ -> ���� ���ϴ� ���� �ֵ��� �ϴ� �� )
       
           �� Primary Key  �������� 
           
             ��  ���̺��� �÷��� 1���� ���� �� �ִ�. 
                  2���� �÷��� ��� PK�� ���� �� �ִ�. -> 2���� �÷��� ���ؼ� �ߺ��� ���� ������ �ȵ� (������ �ϳ��� �ϳ��� PK)
                  ���̺��� ������ �� �ݵ�� PK (Primary Key)�� �����ؾ� �Ѵ�.  
                  Update , Delete �������� PK �÷��� where �������� �����
                  Ư�� �÷��� �ߺ��� ���� ���� ���ϵ��� ��
                  �ݵ�� not null �÷��̾�� �� ( null ��� �Ұ�)                            
                  index�� �ڵ����� �����ȴ�. ( index : �÷��� �˻��� ������ ��)
                  join�� ON���� ���� ����ϴ� Ű �÷�
                                              
           �� Unique Key �������� :
             
             ��  �÷��� �ߺ��� ���� ���� ���ϵ��� ��
                  null�� ���� �� �ִ�. ��, 1���� ���� ( not null , null )
                  �ϳ��� ���̺� ������ Unique Key �� ���� �� �ִ�.
                  index �� �ڵ����� ������ . JOIN�� ON�� ����
                  
           �� Foreign Key  �������� : 
      
            ��  �ٸ� ���̺� (�θ����̺�)�� Ư�� �÷��� �����ؼ� ���� �ֵ��� ��
                 �θ����̺��� �����ؼ� �ֱ� ������ �θ����̺� ���� ���� �����ؼ� ���� ���� �� ����.
                 Foreign Key �� �����ϴ� �÷��� �θ����̺��� "Primary Key" , "Unique Key" �� ������
            
           �� NOT NULL 
           
           �� �÷��� NULL�� ���� �� ������ �ϴ� ��������
           
           �� CHECK
           
            �� �÷��� ������ �־ ���� ���ϴ� ���� ���� �� �ֵ��� ��
                ex) �� (month) �÷��� 1 ~ 12 ���� ���� �� �ֵ��� check �������� ���
           
           �� DEFAULT
           
           �� ���������� �ƴ����� ��������ó�� ����
               �÷��� ���� ���� ������ default�� ������ ���� ��ϵ�
               
         - ���� ������ ����ϴ� ������ ���� : user_constraints
            select * from user_constraints where table_name in ('���̺��') ;
                 
*/

-- �������� �̸��� ���� �ʰ� ���̺��� ������ ��� : Oracle���� �������� �̸��� �������� �����Ѵ�.  
-- insert �� ������ �߻��� ��� �������� �̸����� ������ �÷��� ã�� ����
create table member1 (
    id varchar2 (50) not null primary key ,      -- primary key ���� null�� �־ not null�� ����ȴ�. 
    pass varchar2 (50) not null ,
    addr varchar2 (100)  null ,
    jumin char (13) null ,             -- �ڸ����� ������ �÷�
    phone varchar2 (50) ,
    age number (3) ,                    -- ���� 3�ڸ�
    weight number (5,2)              -- �Ǽ� ��ü 5�ڸ� , �Ҽ������� 2�ڸ�
    );

desc member1 ;

insert into member1 ( id ,  pass, addr, jumin , phone , age , weight )
values ('abc' , '000000' , '���� ' , '90108-1111111' , '010-111-1111' , 20 , 47.13 );
commit ;

select * from user_constraints where table_name in ('MEMBER1');

-- �������� �̸��� �־ ���̺��� ������ ���
create table member2 (
    id varchar2 (50) not null constraint PK_MEMBER2_ID  primary key ,      -- primary key ���� null�� �־ not null�� ����ȴ�.  ( �������� �̸����� : constraint + PK_���̺��_�÷���)
    pass varchar2 (50) constraint NN_MEMBER2_PASS not null ,                  -- not null �� ���������̶� ���������̸��� �������ش�. (�������������� �����ϸ� �̸��� �������� ����)
    addr varchar2 (100)  null ,
    jumin char (13) null ,             -- �ڸ����� ������ �÷�
    phone varchar2 (50) ,
    age number (3) ,                    -- ���� 3�ڸ�
    weight number (5,2)              -- �Ǽ� ��ü 5�ڸ� , �Ҽ������� 2�ڸ�
    );

select * from user_constraints where table_name in ('MEMBER2');

insert into member2 ( id ,  pass, addr, jumin , phone , age , weight )
values ('ddd' , 'null' , '���� ' , '90108-1111111' , '010-111-1111' , 20 , 47.13 );

select * from member2 ;
commit ;

update  member2
set pass = '1010111'
where id = 'abc';



--  �� UNIQUE  : �ߺ��� ���� ���� ��  ����. null�� ���� �� �ִ�. ���Ϻ� ������ ���� �� �ִ�. 

create table member3 (
    id varchar2 (50) not null constraint PK_MEMBER3_ID  primary key ,      -- primary key ���� null�� �־ not null�� ����ȴ�.  ( �������� �̸����� : constraint + PK_���̺��_�÷���)
    pass varchar2 (50) constraint NN_MEMBER3_PASS not null ,                  -- not null �� ���������̶� ���������̸��� �������ش�. (�������������� �����ϸ� �̸��� �������� ����)
    addr varchar2 (100)  null ,
    jumin char (13) null constraint U_MEMBER_3_JUMIN unique,                               --�ߺ��Ǹ� �ȵ�                  -- �ڸ����� ������ �÷�
    phone varchar2 (50) not null constraint U_MEMBER_3_PHONE unique ,              --�ߺ��Ǹ� �ȵ� 
    age number (3) ,                                                                                               -- ���� 3�ڸ�
    weight number (5,2)                                                                                         -- �Ǽ� ��ü 5�ڸ� , �Ҽ������� 2�ڸ�
    );
    
 insert into member3 ( id ,  pass, addr, jumin , phone , age , weight )
values ('�ФФ�' , '��' , '���� ' , '90328-1111111' , '011-1534-1221' , 20 , 47.13 );

select * from member3;

-- CHECK �������� : �÷��� ���ǿ� �´� ���� ���� �� �ֵ��� �� 
    
   create table member4 (
    id varchar2 (50) not null constraint PK_MEMBER4_ID  primary key ,      -- primary key ���� null�� �־ not null�� ����ȴ�.  ( �������� �̸����� : constraint + PK_���̺��_�÷���)
    pass varchar2 (50) constraint NN_MEMBER4_PASS not null ,                  -- not null �� ���������̶� ���������̸��� �������ش�. (�������������� �����ϸ� �̸��� �������� ����)
    addr varchar2 (100)  null constraint CK_MEMBER4_ADDR check ( addr  in ( '����' , '�λ�', '�뱸')) ,
    jumin char (13) null constraint U_MEMBER_4_JUMIN unique,                               --�ߺ��Ǹ� �ȵ�                  -- �ڸ����� ������ �÷�
    phone varchar2 (50) not null constraint U_MEMBER_4_PHONE unique ,              --�ߺ��Ǹ� �ȵ� 
    age number (3) constraint CK_MEMBER4_AGE check (age > 0 and age < 200)  ,                                                                                               -- ���� 3�ڸ�
    gender char(1) constraint CK_MEMBER4_GENDER check (gender in ('w' , 'm')),
    weight number (5,2)                                                                                       -- �Ǽ� ��ü 5�ڸ� , �Ҽ������� 2�ڸ�
    );
    
 insert into member4 ( id ,  pass, addr, jumin , phone , age , gender , weight  )
values ('222' , '��' , '�뱸' , '90832-111551' , '019-1534-5571'  ,99 , 'w', 47.1253 ); 
    
select * from member4; 
drop table  member4 ;   
commit ;    

-- �� default : default �� ���������� �ƴ� (�������� �̸��� �ο��� �� ����. )
    -- ���� ���� �� ���� ���� ���� ���� ���� �� default �� ������ ���� ����. 
    
  create table member5 (
    id varchar2 (50) not null constraint PK_MEMBER5_ID  primary key ,      -- primary key ���� null�� �־ not null�� ����ȴ�.  ( �������� �̸����� : constraint + PK_���̺��_�÷���)
    pass varchar2 (50) constraint NN_MEMBER5_PASS not null ,                  -- not null �� ���������̶� ���������̸��� �������ش�. (�������������� �����ϸ� �̸��� �������� ����)
    addr varchar2 (100)  null constraint CK_MEMBER5_ADDR check ( addr  in ( '����' , '�λ�', '�뱸')) ,
    jumin char (13) null constraint U_MEMBER_5_JUMIN unique,                               --�ߺ��Ǹ� �ȵ�                  -- �ڸ����� ������ �÷�
    phone varchar2 (50) not null constraint U_MEMBER_5_PHONE unique ,              --�ߺ��Ǹ� �ȵ� 
    age number (3) constraint CK_MEMBER5_AGE check (age > 0 and age < 200)  ,                                                                                               -- ���� 3�ڸ�
    gender char(1) constraint CK_MEMBER5_GENDER check (gender in ('w' , 'm')),
    weight number (5,2) ,                                                                                         -- �Ǽ� ��ü 5�ڸ� , �Ҽ������� 2�ڸ�
    hiredate date default sysdate  ,
    addr2 char(10) default '����' ,
    age2 number default 0
    );
    
insert into member5 ( id ,  pass, addr, jumin , phone , age , gender , weight , hiredate , addr2 , age2 )
values ('333' , '��' , '�뱸' , '80832-111551' , '018-1534-5571' , 100 , 'w', 47.1253 , '23/12/14' , '���' , 88 ); 
 
select * from member5;    

