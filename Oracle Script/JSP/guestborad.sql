create table guestboard (
	name varchar2(200),
	email varchar2(200),
	subject varchar2(200),
	content varchar2(200)
	);
    
    select * from guestboard ;
    insert into guestboard (name , email , subject , content ) 
    values ('��','aaa','sks','ssss ');
    
    delete  guestboard
    where name in ( '��' , '��' , '��' , '88888888' , '18');
    
    
    commit;
    
    --  developer������ �ݵ�� commit �ʿ�
    -- commit�� ���ϸ� commit �ϱ� �������� Lock �� �ɷ��־ �ٸ� ����ڰ� ������ �� �� ����
    insert into guestboard (name , email , subject , content ) 
    values ('88888888','o','s','ssss6');
    
    
        create table mem (
     name varchar2(200),
     age  varchar2(200),
     weight varchar2(200),
     addr varchar2(200),
     phone  varchar2(200)
     );

select * from mem;
select * from tab;

     create table soso (
     name varchar2(200),
     age  varchar2(200),
     weight varchar2(200),
     addr varchar2(200),
     phone  varchar2(200)
     );

select * from soso;
commit;
    drop table soso;