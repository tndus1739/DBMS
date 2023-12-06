-- 한라인 주석 ( 주석 하려면 -- 입력 후 공백 넣어줘야 함)
/*
	여러라인 주석
*/

-- 1. 사용자 DataBase 생성
create database myDB;  -- 블럭잡고 실행

-- 2. 해당 사용자 DataBase에 접속
 use myDB;  -- DB에 접속하고 난뒤에 테이블 만들 수  있음
 
 -- 3. 접속한 DB에서 테이블 생성
create table member (
	idx int not null,
    name varchar(50) not null,   -- 50자 까지 지정
    addr varchar(50) not null
	) ;
    
-- 4.  테이블의 내용을 출력 : select
select * from member;    

-- 5. 생성된 테이블에 값넣기 ( 레코드 : 한 라인의 값) : 자동 커밋이 됨 (명시하지 않아도 됨)
insert into member ( idx, name , addr)
values ( 1, '홍길동', '서울');

insert into member ( idx, name , addr)
values ( 2, '이길동', '부산');



