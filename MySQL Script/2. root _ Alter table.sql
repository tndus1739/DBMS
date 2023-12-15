
-- 데이터 베이스 생성 : root 접속
create database shop ;

-- 데이터 베이스에 접속(사용)하기  : use 사용
use shop ;

-- 테이블 생성 : Oracle -> number  / MYSQL -> 정수 : int , 실수 : double (8byte) , float (4byte)
--            Oracle -> Varchar2(50)  / MYSQL -> varchar (50)
create table dept60 (
	dno int not null primary key,
    dname varchar(50) not null,
    loc varchar(50) not null
    ) ;
    
-- 테이블구조 확인하기
desc dept60;

-- 테이블의 값 확인하기
select * from dept60;

-- 테이블에 값 넣기  --> MYSQL , MSSQL : 자동 커밋 transaction
insert into dept60
values ( 20 , '인사부' , '서울');

-- insert , update , delete 를 할 때 명시적으로 transaction 을 시작하고 , 명시적으로 transantion 중  rollback , commit 을 해야함
-- 명시적으로 transantion을 시작하면 명시적으로 transantion을 해줘야 함

start transaction ;    --  MYSQL : 명시적으로 transction 시작 

insert into dept60
values ( 40 , '관리부' , '부산') ;

rollback ;
commit ;

-- 실제 DB에서 값을 insert , update , delete --> transantion을 명시적으로 시작하고 값을 확인 후 commit ;

select * from dept60;

-- MYSQL은 update , delete 할 때 보호설정이 되어있음  ( edit - preference - SQL Editor - safe update ~ 체크해제 )
update dept60
set loc = '광주'
where dno = 10 ; 

-- delete    :    delete from 테이블명
delete from dept60
where dno = 20 ;




