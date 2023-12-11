/*
       ��  JOIN : DataBase ���� ���� ���̺��� ���� , �𵨸��� ���ؼ� ���̺��� �и��Ǿ� ���� ( ���̺�� ���̺��� Relatioinship ����   : R - DBMS )
            employee ���̺�� department ���̺��� �ϳ��� ���̺��ε� �𵨸� ( 1, 2, 3 ����ȭ) �� ���ؼ� �и��� ���� ��
       ��  �𵨸� : �ߺ����� , ������� , ���ʿ��� �ϵ�뷮 ���� ����
       
       �� �������� : ���̺��� �÷��� ���� Ű , �������� ���Ἲ ( ���Ծ��� ������ -> ���� ���ϴ� ���� �ֵ��� �ϴ� �� )
           - Primary Key  �������� 
           
             ��  ���̺��� �÷��� 1���� ���� �� �ִ�. 
                  2���� �÷��� ��� PK�� ���� �� �ִ�. (������ �ϳ��� �ϳ��� PK)
                  ���̺��� ������ �� �ݵ�� PK (Primary Key)�� �����ؾ� �Ѵ�.  
                  Update , Delete �������� PK �÷��� where �������� �����
                  Ư�� �÷��� �ߺ��� ���� ���� ���ϵ��� ��
                  �ݵ�� not null �÷��̾�� �� ( null ��� �Ұ�)                            
                  index�� �ڵ����� �����ȴ�. ( index : �÷��� �˻��� ������ ��)
                  join�� ON���� ���� ����ϴ� Ű �÷�
                                              
           - Unique Key �������� :
             
             ��  �÷��� �ߺ��� ���� ���� ���ϵ��� ��
                  null�� ���� �� �ִ�. ��, 1���� ���� ( not null , null )
                  �ϳ��� ���̺� ������ Unique Key �� ���� �� �ִ�.
                  index �� �ڵ����� ������ . JOIN�� ON�� ����
                  
           - Foreign Key  �������� : 
      
            ��  �ٸ� ���̺� (�θ����̺�)�� Ư�� �÷��� �����ؼ� ���� �ֵ��� ��
                 �θ����̺��� �����ؼ� �ֱ� ������ �θ����̺� ���� ���� �����ؼ� ���� ���� �� ����.
                 Foreign Key �� �����ϴ� �÷��� �θ����̺��� Primary Key , Unique Key �� ������
            
           - NOT NULL 
           
           �� �÷��� NULL�� ���� �� ������ �ϴ� ��������
           
           - CHECK
           
            �� �÷��� ������ �־ ���� ���ϴ� ���� ���� �� �ֵ��� ��
                ex) �� (month) �÷��� 1 ~ 12 ���� ���� �� �ֵ��� check �������� ���
           
           - DEFAULT
           
           �� ���������� �ƴ����� ��������ó�� ����
               �÷��� ���� ���� ������ default�� ������ ���� ��ϵ�
                 
                 
                 
*/

    select * from employee ;         -- employee ���̺��� dno �÷��� department���̺��� dno �÷��� �����Ѵ�.  ( ���� : Foreign Key)
                                                        
    select * from department ;      -- �θ����̺�
    
--  �� ���̺� ���� : ���� ���̺��� ���������� ����Ǿ� ���� �ʴ´�.
--                           Alter Table�� ����ؼ� ���������� �ο�
    
  create table emp01                                -- table�� ������ ( emp01 : employee���̺��� �������� ������ ��)
  as 
  select * from employee ;
  
  create table dept01
  as
  select * from department ;
  
  /*
         �� ���̺��� ���������� Ȯ���ϴ� ��ɾ�
         user_constraints : ������ ����  --> ���̺��� ���� ������ �˷��ִ�  ���̺�
  */
    
    select * from user_constraints ;           -- ��� �����ͺ��̽� ���̺��� �������� ����     -->   Constraints_type ���� R : Foreign Key  / P : Primary Key
    
    select * from user_constraints              
    where table_name in ('EMPLOYEE' , 'DEPARTMENT') ;        -- EMPLOYEE' , 'DEPARTMENT' ���̺��� �������� ����
    
  -- ���̺��� �����ϸ� ���̺��� �÷��� �ο��� ���������� ����Ǿ� ���� �ʴ´�. ( �÷��� ���� ����Ǿ�´�.)
  -- Alter Table �� ����ؼ� ���������� �ο��ؾ� ��
  -- Alter Table : ������ ���̺��� ����
   select * from user_constraints              
   where table_name in ('EMP01' , 'DEPT01') ;  
 
 --  dept01 ���̺� dno �÷���  Primary Key ���� ������ �߰�
  alter table dept01
  add constraint PK_DEPT01_DNO primary key (dno);      -- dno �÷��� primary key ���������� �ְڴ�.
 
  --  emp01 ���̺� eno �÷��� Primary Key ���� ������ �߰�
  alter table emp01
  add constraint PK_EMP01_ENO primary key (eno); 
  
  --  emp01 ���̺� dno �÷��� Foreign Key �ο� , ���� ( References) �� ���̺��� �÷��� Dept01 ���̺��� dno �÷��� ����
  
  alter table emp01
  add constraint FK_EMP01_DNO foreign key (dno) references dept01(dno);
  
  -- Primary Key �÷��� Ȯ��
  desc emp01 ;
  
  select * from emp01;       -- dno �÷��� depy01���̺��� dno�÷��� �ִ� ���� ������ �� �ִ�. (foreign key ���������� �ֱ� ������)
  
  -- ���� ���� �� �÷��� �ο��� ���������� �� Ȯ���ϰ� ���� insert
  -- eno : Preimary Key �� ���, �ߺ��� ���� ������ �ȵ�
  -- dno : Foreign Key �� ��� , Dept01 ���̺��� dno�÷��� �����ϴ� ���� �־�� �Ѵ�.
  
--  insert into emp01 ( eno, ename , job , manager , hiredate , salary , commission , dno)            -- �����߻� ( eno�÷��� ������ �� ������ �ȵ� , dno �÷����� �θ����̺� �ִ� ���� �־�� ��)
--  values ( 7934 , 'SOOYEON' , 'PRESIDENT' , 7782 , '23/12/11' , 1500 , null , 50 ) ;                       -- ���� ���� -  ORA-00001: ���Ἲ ���� ����(C##HR.PK_EMP01_ENO)�� ����˴ϴ�

insert into emp01 ( eno, ename , job , manager , hiredate , salary , commission , dno)
values ( 7901 , 'SOOYEON' , 'PRESIDENT' , 7782 , '23/12/11' , 1500 , null , 10 ) ;

commit ;     -- DML ( insert, update , delete )���� DB�� ������ ����ǵ��� ��
                    -- Ŀ���� �ؾ� DB�� ���������� ������ �ǰ� ���ϸ� �޸𸮿� ������ �ȴ�. (����Ŭ���� ����)
                    
select * from emp01;  

select * from dept01 ;

-- dept���̺� �� �ֱ� : dno �÷� -> Primary Key �� ���� ( �ߺ��� ���� ���� �� ����.)

desc dept01 ;

insert into dept01  ( dno , dname , loc)
values ( 50, 'HR' , 'SEOUL' ) ;

commit ;    --  DML ( insert, update , delete )���� �ݵ�� commit �ݵ�� ���� �ڡڡڡڡ�

select * from dept01 ;

select * from emp01 ;      -- > emp01 ���̺��� primary key�� foreign key ���������� ����ִ�. 

/*
  �ڡ�  JOIN  : ���� ���̺��� �÷��� ����� �� JOIN�� ���ؼ� �ϳ��� ���̺� ó�� ���
   - join �� �Ҷ��� �� ���̺��� ���� Ű �÷��� Ȯ��
   - emp01 , dept01 ���̺��� ���� Ű �÷��� dno
   - EQUI JOIN : ����Ŭ������ �۵��ϴ� JOIN ����
   - ANSI JOIN : ��� DBMS ���� �������� ���Ǵ� JOIN ����
*/

/*
  �ڡ�  EQUI JOIN �������� �� ���̺� ����
   - from ������ JOIN�� ���̺��� ��� ( , (�޸�)�� ����)
   - ���̺��̸��� ��Ī�̸����� ��
   - where ������ �ݵ�� �� ���̺��� ����Ű �÷��� ����ؾ� ��
   - and ������ ������ ó��
   - ����Ű �÷��� ��½� �ݵ�� ���̺�� ,  �÷����� ��� 
*/
select e.eno , e.ename , e.job , d.dno, d.dname , d.loc                -- �÷� �տ� ���̺��̸� ( e , d)  �������������� dno �÷��� ���� �Ұ�
from emp01 e , dept01 d                                                                   -- from + ������ ���̺�  (emp01�� e��� alias ��Ŵ)
where e.dno = d.dno ;                                                                       -- where ������ �ݵ�� �� ���̺��� ����Ű �÷��� ����ؾ� ��

select e.eno , e.ename , e.job , d.dno, d.dname , d.loc                
from emp01 e , dept01 d                                                                   
where e.dno = d.dno         
and d.dno = 10 ;

/*
   �ڡڡ�  ANSI JOIN : ��� DBMS ���� �������� ���Ǵ� JOIN ����
    
    - INNER JOIN : �� ���̺��� Ű�÷��� ����Ǵ� �κи� ���  (80% �̻��� INNER JOIN )
    - OUTER JOIN :
             �� LEFT OUTER JOIN
             �� RIGHT OUTER JOIN
             �� FULL OUTER JOIN
    - SELF JOIN
    - CLOSS JOIN
*/

-- INNER JOIN : ANSI JOIN
    -- from  ���� JOIN���̺� �̸��� ���
    -- ���� ���� ���Ǳ� ������ INNER KEY�� ��������
    -- on ���� �� ���̺��� ���� Ű �÷��� ��� , �� ���̺��� ������ �͸� ���
    
-- ���̺� �̸��� alias (��Ī) ������� ���� ���
select eno , ename , salary , dept01.dno , dname , loc    -- �ٸ� �÷��� ���̺��̸��� �� ���������ص� dno �÷��� �����Ұ� ( ����Ű �÷��� ������ �ֱ� ������)
from emp01 INNER JOIN dept01               -- INNER ��������  ( �׳� JOIN ��  INNER JOIN �� ����) 
on emp01.dno = dept01.dno ;                  -- ���̺��̸��� �˸��ƽ� ���ѳ����� ���̺� ��Ī�� ����ص� �Ǵµ� �˸��ƽ� ��Ű�� ������ ���̺��̸��� �� �Է��ؾ� ��

-- ���̺� �̸��� alias (��Ī) ����� ���
select eno , ename , salary , d.dno , dname , loc
from emp01 e  JOIN dept01 d 
on e.dno = d.dno                                        -- on ���� �����̺� ���� Ű�÷��� ���
where e.dno = 20                                        
order by ename desc;

-- INNER JOIN : ANSI SQL : ��� DBMS���� �������� ���Ǵ� SQL ���� ( Oracle, MYSQL , MSSQL , DB2 , ... )
    -- ON���� �� ���̺��� ����и� ���

select *                                                                -- ������ �ϳ��� ���̺��̳� �ߺ��� ���� ���Ƽ� �𵨸��� ���ؼ� �и��Ǿ��µ� �ٽ� �ϳ��� ���̺�ó�� �������°� JOIN
from emp01 e join dept01 d
on e.dno = d.dno;

-- OUTER JOIN (���� �����)
    -- LEFT OUTER JOIN : �� ���̺��� ���� �κа�  ���� (emp01) ���̺��� ��� ������ ���
    -- RIGHT OUTER JOIN :�� ���̺��� ���� �κа�  ������  (dept01) ���̺��� ��� ������ ���
    -- FULL OUTER JOIN : ���� , ������ ���̺��� ��� ������ ���
 
 select * from dept01;
 
 insert into dept01 (dno , dname , loc )
 values ( 60 , 'MANAGE' , 'BUSAN' );
 commit ;
 
    
select *                                                              -- INNER JOIN ( INNER ��������)
from emp01 e join dept01 d                            -- e.dno ��  d.dno ����  ��Ī�Ǵ�  ���� ���
on e.dno = d.dno ;

select *                                                              -- LEFT OUTER JOIN ( ���� ���̺��� ������ ��� ���)
from emp01 e LEFT OUTER JOIN dept01 d
on e.dno = d.dno;

select *                                                              -- RIGHT OUTER JOIN  ( ������ ���̺��� ������ ��� ���)
from emp01 e  RIGHT OUTER JOIN dept01 d
on e.dno = d.dno;

select *                                                              -- FULL OUTER JOIN  ( �����̺� (���� ,������ ���̺�)�� ��� ������ ��� ���)
from emp01 e  FULL OUTER JOIN dept01 d
on e.dno = d.dno;

-- SELF JOIN : �ڽ��� ���̺���  JOIN , �ڽ��� ���̺���  �ݵ�� ��Ī�̸����� �������� �����ؼ� JOIN
    -- ������ ��� , ���� ��縦 �ٷ� ����� �� ���
    
select e.eno �����ȣ , e.ename ����̸� , e.manager "���� �����ȣ" , m.eno ���ӻ����� , m.ename ���ӻ����
from  emp01 e JOIN emp01 m                                          -- �� ���̺��� ������ ���̺��̶� �ݵ�� ��Ī�̸� ���
on e.manager = m.eno ;                                                     -- ���ӻ�� �̸��� �� ���ӻ���� �̸��� ����

select eno , ename , manager , eno , ename
from employee ;






