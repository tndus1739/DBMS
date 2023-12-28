
-- MVC 로 개발될 테이블

create table board (
     seq number(5) not null primary key ,
     title varchar2(200) null,
     write varchar2(20) null ,
     content varchar2(2000) null,
     regdate date default sysdate null ,
     cnt number (5) default 0 null
 );
 
 select * from board ;
 
 update board 
 set title = '제목 수정됨' , write = '이순신' , content = '내용 수정됨' 
 where seq = 4;
 commit ;
 rollback;
 delete board where seq = 8;
 
 update board 
 set cnt = cnt + 1 
 where seq = 8 ;
 
 
 desc board ;
 select * from board;
 select * from board order by seq desc;
 
 create table users (
    id varchar2(8) not null primary key,
    password varchar2 (8) null,
    name varchar2(20) null ,
    role varchar2(5)
);
 desc users;
 select * from users 
 where id = 'user'  
 and password = '1234';
 
 
create table products (
    p_code number(5) not null primary key ,
    p_name varchar2(200) null ,
    p_kind char(1) null ,
    p_price varchar2(10) null ,
    p_contents varchar2(2000) null ,
    p_quantity varchar2(5),
    indate date default sysdate null
);

-- 더미 테이터 입력 :
insert into board 
values ( 1, 'MVC  M2 게시판  제목' , 'admin' , 'MVC M2 게시판 내용 ' , default  , 0 ) ;
insert into board 
values ( 2, 'MVC  M2 게시판  제목' , 'admin' , 'MVC M2 게시판 내용 ' , default  , 0 ) ;

select * from board ;
commit ;

insert into users
values ( 'admin' , '1234' , '관리자' , 'Admin') ;
insert into users
values ( 'user' , '1234' , '사용자' , 'Admin') ;

select * from users ;


