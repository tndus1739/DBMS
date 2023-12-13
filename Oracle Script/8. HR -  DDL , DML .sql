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
