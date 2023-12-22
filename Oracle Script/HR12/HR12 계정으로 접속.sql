
-- MVC �� ���ߵ� ���̺�

create table board (
     seq number(5) not null primary key ,
     title varchar2(200) null,
     write varchar2(20) null ,
     content varchar2(2000) null,
     regdate date default sysdate null ,
     cnt number (5) default 0 null
 );
 
 create table users (
    id varchar2(8) not null primary key,
    password varchar2 (8) null,
    name varchar2(20) null ,
    role varchar2(5)
);

create table products (
    p_code number(5) not null primary key ,
    p_name varchar2(200) null ,
    p_kind char(1) null ,
    p_price varchar2(10) null ,
    p_contents varchar2(2000) null ,
    p_quantity varchar2(5),
    indate date default sysdate null
);

-- ���� ������ �Է� :
insert into board 
values ( 1, 'MVC  M2 �Խ���  ����' , 'admin' , 'MVC M2 �Խ��� ���� ' , default  , 0 ) ;
insert into board 
values ( 2, 'MVC  M2 �Խ���  ����' , 'admin' , 'MVC M2 �Խ��� ���� ' , default  , 0 ) ;

select * from board ;
commit ;

insert into users
values ( 'admin' , '1234' , '������' , 'Admin') ;
insert into users
values ( 'user' , '1234' , '�����' , 'Admin') ;

select * from users ;


