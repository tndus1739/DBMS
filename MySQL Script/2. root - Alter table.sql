
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

-- MTSQL은 자동 커밋 transantion
create table account10 (
	no int not null primary key,
	name varchar(50) not null,
	money double not null default 0 
	);

select * from account10 ;

insert into account10
values ( 1, '홍길동' , 100);

insert into account10
values ( 2, '이순신' , 200);

-- 홍길동 계좌에서 10억을 이순신 계좌로 입급 : transaction이 2번 발생됨 (잘못된 경우)
-- transaction이 2번 발생되면 문제 발생시 출금은 됐는데 입금은 안되어있는 불상사가 발생

-- 1번째 transaction
update account10
set money = money - 10
where no  = 1 ; 

-- 2번째 transaction
update account10
set money = money + 10
where no  = 2 ; 

-- 홍길동 계좌에서 10억을 이순신 계좌로 입급 : transaction이 1번 발생됨  
-- ( 이렇게 하나의 transaction으로 묶어줬을 때 문제 발생시 한 번에 rollback 이나 commit을 해줄 수 있음)

start transaction ;   --  transaction을 명시

update account10
set money = money - 10
where no  = 1 ; 

update account10
set money = money + 10
where no  = 2 ; 

commit ; 












