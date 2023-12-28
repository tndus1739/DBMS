
create table Member(
    id varchar2(255) not null primary key,
    password varchar2(255) not null,
    phone varchar2 (255) not null,
    email varchar2(255) null,
    regdate date default sysdate,
    addr varchar2(255),
    role varchar2(255) default 'user'
);

create table product (
    id number(5)  not null primary key,  
    name varchar2(255) not null,              
    price number(8,2) not null,                    
    content varchar2(2000),                        
    regdate date default sysdate              
    );

create table m_board (
    id number(5) not null primary key,
    m_title varchar2 (255) not null ,
    m_write varchar2(255) not null,
    m_cont varchar2 (255) not null,
    regdate date default sysdate    ,
    cnt number(5) default 0
    );

select * from member;
select * from product;
select * from m_board;

INSERT INTO m_board (id,


drop table member;
commit;