/*
	myDB2 데이타 베이스 생성
    member 테이블 생성
    레코드(값) 2개 넣기
*/
create database myDB2;

use myDB2;
create table member (
	idx int not null,
    name varchar (50) not null,
    addr varchar (50) not null
    ) ;
    
select * from member;

insert into member ( idx, name , addr)
values ( 1, '가가가' , '서울');

insert into member ( idx, name , addr)
values ( 1, '나나나' , '부산');
    
    
    
