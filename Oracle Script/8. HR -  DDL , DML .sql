/* 
    ★ SQL : 모든 쿼리 구문 , select , create , alter , drop , insert , update , delete , grant , revoke , rollback , commit
            → 구조화된 질의 언어

    ★ SQL 종류
    - DQL (Date Query Language) : 출력 , 검색 , select (출력)
    - DDL (Date Definition Language) : 값을 넣을 틀을 만드는 것  , 객체를 생성 수정 , 삭제
                                                           →  스키마 (틀, 구조) , 객체 (테이블, 뷰, 함수 , 시퀀스 , 트리거 , 저장프로시져 , 인덱스) 생성 , 수정, 삭제
                                                                 create (생성) , alter (수정) drop (삭제)
    - DML ( Date Manupulation Language) : 테이블의 레쿄드(값)을 조작하는 언어 ★★★
                                                                        insesrt (입력) , update (수정) , delete (삭제) , rollback (메모리에 변경된 내용을 다시 원래의 상태로 되돌림) 
                                                              →   - transaction이 발생 (RAM) , commit : RAM의 변경된 내용을 DataBase에 영구히 저장하도록 함 
                                                                     - transaction은 insert , update, delete 가 시작되면 자동으로 transaction  이 시작됨
                                                                     - transaction을 종료하는 법 : rollback , commit
                                                                     - transaction이 종료되지 않으면 Lock이 걸려버려서 transaction이 종료될 때까지 LOCK이 걸려 있다.
                                                                     - 오라클 : DML문을 시작하면 자동으로 transaction이 시작됨 , 종료는 직접 명시해야한다. (rollback , commit)
                                                                     - MYSQL , MSSQL , : DML 문을 시작하면 자동으로 transaction이 시작되고 commit이 자동으로 처리됨 
                                                                     - 명시적으로 transaction을 시작할 수 있고 명시적으로 끝낼 수 있다.    
     - DCL ( Data Control Language ) : 계정 (Account)에게 객체 (Resource)에  권한을 부여함 
                                                               grant ( 부여 ) , revoke (제거)
    
     - TCL ( Transaction Control Language) : transaction을 관리하는 언어 →  DML문에서 사용됨
                                                                          commit : DB에 영구히 저장
                                                                          rollback : 원래대로 되돌림
                                                                          savepoint : transaction 내에서 임시 저장시점 생성
                                                                          begin transaction : 명시적으로 transaction 시작
 
 
    ★ Transaction : 작업 (일)을 처리하는 최소 단위 : ALL or NOTHING  → 되면 전부 되게 하거나 안되면 전부 안되게 함
                                transaction log에 기록되어 있다. → 백업시점이 아니라 오류난 시점까지 복원가능
 
    ★ Transaction의 4가지 특징
    
    - 원자성 ( Atomicity ) : 일을 처리하는 최소 단위
    - 일관성 ( Consistency ) ;transaction에서 처리된 결과는 일관성을 가진다.  ( ALL or NOTHING )
    - 독립성 ( Isolation ) : 하나의 transaction은 다른 transaction과 격리되어 있다. (내가 transaction을 종료하기 전까지는 LOCK이 걸려있어서 다른 사용자들이 접근 불가)
    - 직속성 ( Durability ) : commit , DB에 영구적으로 저장됨 
                                                
*/

-- 테이블 복사

create table account10                 -- 핑크색글씨는 시스템의 예약어라서 사용 X ( 사용하고 싶다면 " " 로 묶어줘야 함)
as
select eno as no , ename as name  , salary as account
from employee ;

-- 은행의 통장 테이블 ( no : 계좌번호 , name : 예금주 , account : 입금액 ) , 억단위

select * from account10 ;

-- SMITH 에서 MILLER에게 10억을 입금 ( 2개의 update 구문을 하나의 transaction으로 처리 : ALL OR NOTHING   )
    -- SMITH   Account  -10억  :  update account10 set account = accoint  - 10 where no = 7369
    -- MILLAR Account  +10억  :  update account10 set account = accoint  + 10 where no = 7934

-- begin transaction ;        -- 명시적으로 transaction을 시작 ( 생략가능 )

update account10
set account = account - 10 
where no = 7369 ;

update account10 
set account = account  + 10 
where no = 7934 ;

--  transaction 종료
rollback ;
commit ; 


--  ★ DML : insert ( 값을 입력) , update ( 수정) , delete (삭제)                 -------> 이 3가지 구문에서만 commit 사용하고 나머지 다른 구문은 사용 X
        --> 위의 구문을 입력하면  transaction이 자동으로 시작되지만 
--           종료는 rollback 이나 commit 을 입력해서 직접 명시해야 한다.  (오라클만 직접 명시) 
        
--  테이블 복사
create table dept03
as
select * from department ;

select * from dept03 ;

-- dept03 : primary key 제약조건 추가
alter table dept03 
add constraint PK_DEPT03_DNO primary key (dno) ;

-- INSERT 주의사항
    -- 각 컬럼에 자료형 ( number , 문자 , 날짜 , 컬럼에 적용된 제약 조건을 확인)
    
desc dept03 ;                                               -- 제약조건 확인 ( number , 문자 , 날짜 .. )
select * from user_constraints  where table_name in ('DEPT03') ;              --테이블의 제약조건 확인

-- insert into 테이블명 ( 컬럼명 , 컬럼명 , 컬럼명 ) values ( 값 , 값 , 값 ) ;

insert into dept03 ( dno , dname , loc)
values (50 , 'HR' , 'SEOUL') ;

commit; 

select * from dept03 ;          -- select 는 RAM (메모리)에 있는 내용만 보는 것

-- insert 시 컬럼이름을 명시하지 않는 경우 모든 컬럼에 값을 넣어야 함 (values 안에 순서대로 값을 넣어야 함)
insert into dept03 
values (60 , '인사부' , '부산');
commit; 

-- 컬럼 생략 할 때는  모든 컬럼에 값이 순서에 맞게 입력해야함
insert into dept03         -- 오류
values ( 70 , '인사부') ;

-- 컬럼을 명시할 때 순서를 바꿀 수 있고 , 특정컬럼은 값을 넣지 않아도 됨)
insert into dept03 (dname , dno )
values ( '영업부' , 80 ) ;

commit; 

-- update 문 : 기존에 입력된 값을 수정시 사용, 반드시 where 조건을 사용 , where 조건에 사용되는 컬럼dms Primary Key 컬럼이어야 함
/*
        update 테이블명
        set 컬럼명 = 바꿀값 , 컬럼명 = 바꿀값
        where 조건

*/
-- -------------------------------
update dept03
set loc = '대구'
where dno = 80 ;

rollback ;
-- --------------------------------
update dept03
set  dname = '관리부' ,  loc = '광주'
where dno =40;
-- --------------------------------
commit ;

select * from dept03 ;
-- --------------------------------
insert into dept03 
values (90 , '영업부' , '대구') ;

--  update 에서 반드시 where 조건 명시 , 조건을 처리하는 컬럼은 Primary Key , Unique Key 컬럼을 정의
insert into dept03 
values (91 , '영업부' , '광주') ;

update dept03
set dname = '인쇄부'
where loc = '광주' ;           -- 중복된 값 (몇 개의 행이 업데이트 되는지 확인)

select * from dept03 ;

-- update  시 primary key 컬럼을 조건으로 처리해서 원하는 값만 수정

update dept03
set dname = '인쇄부'
where dno in ( 91 , 80 );
commit ;
 
-- Delete : 레코드를 삭제할 때 사용 ( where [조건] , [조건 : 중복되지 않는 조건] )
/*
        delete 테이블명
        where 조건
        
*/

select * from dept03 ;

-- delete 문에서 조건을 사용하지 않는 경우 : 모든 레코드가 삭제됨

delete dept03 ;
rollback ;
commit ;

-- delete , where 조건 사용

delete dept03
where dno =91 ;

-- 모든 레코드를 삭제 
    -- delete                               : 레코드 하나하나를 삭제 , 시간이 오래 걸림 [로우레벨 포멧]
    -- truncate table 테이블명     : 모든 레코드를 한 번에 삭제 ( 테이블 틀 (스키마) 은 그대로 두고 안에 레코드만 삭제 )[빠른 포멧]  --> DDL문 이기 때문에 rollback 이 안됨
    -- drop table 테이블명         : 테이블 자체를 삭제

select * from dept03 ;
rollback ;
commit ;

-- 조건 없이 모든 레코드 삭제 : 값만 삭제  --> rollback 가능
delete dept03 ;

-- 모든 레코드 삭제 : 값만 삭제 --> DDL문 이기 때문에 rollback 이 안됨 (실행 후 바로 커밋 됨)
    -- 빠르게 처리됨
    
truncate table dept03 ;

-- -------------------------
create table emp04
as
select * from employee ;

select * from emp04;

/*
    emp04
    임의의 값을 추가 : insert
    임의의 값을 수정 : update
    임의의 값을 삭제 : delete
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
