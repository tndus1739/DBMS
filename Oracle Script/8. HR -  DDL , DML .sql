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

delete emp04
where eno = 7934 ;

commit ;

-- -----------------------------------------------------
/*
        ★ DDL : create (생성) , alter (수정) , drop ( 삭제 ) --> ★테이블★ , 뷰 , 함수 , 시퀀스 , 트리거 , 저장프로시져,  스키마 (값을 넣기 위한 틀 ) 를 생성 , 수정 , 삭제
        
        자료형 : 데이터를 저장하는 타입
            - 숫자 : number (3)  : 정수 3자리
                         number ( 7, 2 ) : 소수  , 전체 7자리 , 소수점이하 2자리까지 
        
            - 문자 : char (n)  :  영문 1자 (1byte) , 한글 1자 3 (3byte) 
                                     ->  성능은 빠르지만 하드 공간 낭비가 발생할 수 있다. (선언과 동시에 하드에 할당을 받아서 값이 일부만 들어와도 하드에 공간을 그대로 차지) 
                                            주민번호 (13) , 자릿수가 지정된 곳에 사용됨    
                                            (ex)  char (10)  : 영어는 10자까지 , 한글은 3자까지 가능
                                            
                         varchar2 (n) : 영문 1자 (1 byte) , 한글 1자 ( 3byte)            
                                            -> 하드공간 낭비 방지 가능 ( 공간이 가변적으로 사용됨 , 설정한 값보다 적은 값이 들어오면 적은 값으로 적용됨)        
                                                가변공간으로 적용됨 , 성능은 char보다 느릴 수 있지만 하드공간을 낭비하지 않는다.
                                                자리수를 알 수 없는 문자열에 사용됨
                                                nchar (n)            --> ncahr(10)         :  한글 10자까지 가능   ( n이 붙으면 유니코드 10자까지 가능)
                                                nvarchar2(n)     --> nvarchar(10)   :  한글 10자까지 가능
            - 날짜 : date  : BC 4712년 1월 1일  ~  9999년 12월 31일 까지 저장  --> 년 , 월 , 일 , 시 , 분, 초 까지만 저장 가능
                         timestamp : insert ( 값이 들어오는 시스템의 시간)  --> 년 , 월 , 일 , 시 , 분, 초 , 밀리세컨드 까지 저장
            - LOB 데이터 타입 : 대량의 값을 저장 , 바이너리 파일
                    - CLOB : 문자를 대량으로 넣을 수 있다. --> 글내용
                    - BLOB : mp3 , jepg , hwp 이진 데이터 파일
                    - BFile : 대용량 파일 저장
*/

-- ----------------------------------------------------------------------

create table test10 (
            id number (4) not null primary key,        -- 중복된 값은 넣을 수 없다. 정수 4자리까리 가능
            n1 char (10) ,                                -- 영문 10 자 , 한글 3자 까지 가능
            n2 nchar (10) ,                              -- 영문 10자 , 한글 10자 까지 가능
            n3 varchar2(10)  ,                         -- 영문 10 자 , 한글 3자 까지 가능
            n4 nvarchar2 (10)                         -- 영문 10자 , 한글 10자 까지 가능
 );
 drop table test10 ;
 
select * from test10 ;

insert into test10 ( id , n1 , n2 , n3 , n4)
values ( 1111 , 'ababababab' , '이이이이이이이이이이' , 'opopopopop' , '오오오오오오오오오오' );

insert into test10 (id , n2)
values ( 1010, 'aaaaaaaaa');

insert into test10 (id , n1)
values ( 2222, '가나다');


-- --------------------------------------------------------------------------------------------------
/*

★ 제약조건 : 테이블의 컬럼에 들어가는 키 , 데이터의 무결성 ( 결함없는 데이터 -> 내가 원하는 값만 넣도록 하는 것 )
       
           ▶ Primary Key  제약조건 
           
             →  테이블의 컬럼에 1번만 넣을 수 있다. 
                  2개의 컬럼을 묶어서 PK를 넣을 수 있다. -> 2개의 컬럼에 대해서 중복된 값이 있으면 안됨 (원래는 하나당 하나의 PK)
                  테이블을 생성할 때 반드시 PK (Primary Key)이 존재해야 한다.  
                  Update , Delete 구문에서 PK 컬럼을 where 조건으로 사용함
                  특정 컬럼에 중복된 값을 넣지 못하도록 함
                  반드시 not null 컬럼이어야 함 ( null 사용 불가)                            
                  index가 자동으로 생성된다. ( index : 컬럼의 검색을 빠르게 함)
                  join시 ON에서 많이 사용하는 키 컬럼
                                              
           ▶ Unique Key 제약조건 :
             
             →  컬럼에 중복된 값을 넣지 못하도록 함
                  null을 넣을 수 있다. 단, 1번만 가능 ( not null , null )
                  하나의 테이블에 여러번 Unique Key 를 넣을 수 있다.
                  index 가 자동으로 생성된 . JOIN시 ON에 사용됨
                  
           ▶ Foreign Key  제약조건 : 
      
            →  다른 테이블 (부모테이블)의 특정 컬럼을 참조해서 값을 넣도록 함
                 부모테이블을 참조해서 넣기 때문에 부모테이블에 없는 값은 참조해서 값을 넣을 수 없다.
                 Foreign Key 가 참조하는 컬럼은 부모테이블의 "Primary Key" , "Unique Key" 를 참조함
            
           ▶ NOT NULL 
           
           → 컬럼에 NULL을 넣을 수 없도록 하는 제약조건
           
           ▶ CHECK
           
            → 컬럼에 조건을 넣어서 내가 원하는 값만 넣을 수 있도록 함
                ex) 월 (month) 컬럼에 1 ~ 12 가지 넣을 수 있도록 check 제약조건 사용
           
           ▶ DEFAULT
           
           → 제약조건은 아니지만 제약조건처럼 사용됨
               컬럼에 값을 넣지 않으면 default로 설정된 값이 등록됨
               
         - 제약 조건을 출력하는 데이터 사전 : user_constraints
            select * from user_constraints where table_name in ('테이블명') ;
                 
*/

-- 제약조건 이름을 넣지 않고 테이블을 생성한 경우 : Oracle에서 제약조건 이름을 랜덤으로 생성한다.  
-- insert 시 오류가 발생할 경우 제약조건 이름으로 오류난 컬럼을 찾기 힘듦
create table member1 (
    id varchar2 (50) not null primary key ,      -- primary key 에는 null을 넣어도 not null로 변경된다. 
    pass varchar2 (50) not null ,
    addr varchar2 (100)  null ,
    jumin char (13) null ,             -- 자릿수가 지정된 컬럼
    phone varchar2 (50) ,
    age number (3) ,                    -- 정수 3자리
    weight number (5,2)              -- 실수 전체 5자리 , 소숫점이하 2자리
    );

desc member1 ;

insert into member1 ( id ,  pass, addr, jumin , phone , age , weight )
values ('abc' , '000000' , '서울 ' , '90108-1111111' , '010-111-1111' , 20 , 47.13 );
commit ;

select * from user_constraints where table_name in ('MEMBER1');

-- 제약조건 이름을 넣어서 테이블을 생성한 경우
create table member2 (
    id varchar2 (50) not null constraint PK_MEMBER2_ID  primary key ,      -- primary key 에는 null을 넣어도 not null로 변경된다.  ( 제약조건 이름설정 : constraint + PK_테이블명_컬럼명)
    pass varchar2 (50) constraint NN_MEMBER2_PASS not null ,                  -- not null 도 제약조건이라서 제약조건이름을 설정해준다. (생략가능하지만 생략하면 이름이 랜덤으로 생성)
    addr varchar2 (100)  null ,
    jumin char (13) null ,             -- 자릿수가 지정된 컬럼
    phone varchar2 (50) ,
    age number (3) ,                    -- 정수 3자리
    weight number (5,2)              -- 실수 전체 5자리 , 소숫점이하 2자리
    );

select * from user_constraints where table_name in ('MEMBER2');

insert into member2 ( id ,  pass, addr, jumin , phone , age , weight )
values ('ddd' , 'null' , '서울 ' , '90108-1111111' , '010-111-1111' , 20 , 47.13 );

select * from member2 ;
commit ;

update  member2
set pass = '1010111'
where id = 'abc';



--  ★ UNIQUE  : 중복된 값을 넣을 수  없다. null을 넣을 수 있다. 테일블에 여러번 넣을 수 있다. 

create table member3 (
    id varchar2 (50) not null constraint PK_MEMBER3_ID  primary key ,      -- primary key 에는 null을 넣어도 not null로 변경된다.  ( 제약조건 이름설정 : constraint + PK_테이블명_컬럼명)
    pass varchar2 (50) constraint NN_MEMBER3_PASS not null ,                  -- not null 도 제약조건이라서 제약조건이름을 설정해준다. (생략가능하지만 생략하면 이름이 랜덤으로 생성)
    addr varchar2 (100)  null ,
    jumin char (13) null constraint U_MEMBER_3_JUMIN unique,                               --중복되면 안됨                  -- 자릿수가 지정된 컬럼
    phone varchar2 (50) not null constraint U_MEMBER_3_PHONE unique ,              --중복되면 안됨 
    age number (3) ,                                                                                               -- 정수 3자리
    weight number (5,2)                                                                                         -- 실수 전체 5자리 , 소숫점이하 2자리
    );
    
 insert into member3 ( id ,  pass, addr, jumin , phone , age , weight )
values ('ㅠㅠㅠ' , '얌' , '서울 ' , '90328-1111111' , '011-1534-1221' , 20 , 47.13 );

select * from member3;

-- CHECK 제약조건 : 컬럼의 조건에 맞는 값만 넣을 수 있도록 함 
    
   create table member4 (
    id varchar2 (50) not null constraint PK_MEMBER4_ID  primary key ,      -- primary key 에는 null을 넣어도 not null로 변경된다.  ( 제약조건 이름설정 : constraint + PK_테이블명_컬럼명)
    pass varchar2 (50) constraint NN_MEMBER4_PASS not null ,                  -- not null 도 제약조건이라서 제약조건이름을 설정해준다. (생략가능하지만 생략하면 이름이 랜덤으로 생성)
    addr varchar2 (100)  null constraint CK_MEMBER4_ADDR check ( addr  in ( '서울' , '부산', '대구')) ,
    jumin char (13) null constraint U_MEMBER_4_JUMIN unique,                               --중복되면 안됨                  -- 자릿수가 지정된 컬럼
    phone varchar2 (50) not null constraint U_MEMBER_4_PHONE unique ,              --중복되면 안됨 
    age number (3) constraint CK_MEMBER4_AGE check (age > 0 and age < 200)  ,                                                                                               -- 정수 3자리
    gender char(1) constraint CK_MEMBER4_GENDER check (gender in ('w' , 'm')),
    weight number (5,2)                                                                                       -- 실수 전체 5자리 , 소숫점이하 2자리
    );
    
 insert into member4 ( id ,  pass, addr, jumin , phone , age , gender , weight  )
values ('222' , '뭐' , '대구' , '90832-111551' , '019-1534-5571'  ,99 , 'w', 47.1253 ); 
    
select * from member4; 
drop table  member4 ;   
commit ;    

-- ★ default : default 는 제약조건이 아님 (제약조건 이름을 부여할 수 없다. )
    -- 값을 넣을 때 값이 들어가고 값을 넣지 않을 때 default 로 설정된 값이 들어간다. 
    
  create table member5 (
    id varchar2 (50) not null constraint PK_MEMBER5_ID  primary key ,      -- primary key 에는 null을 넣어도 not null로 변경된다.  ( 제약조건 이름설정 : constraint + PK_테이블명_컬럼명)
    pass varchar2 (50) constraint NN_MEMBER5_PASS not null ,                  -- not null 도 제약조건이라서 제약조건이름을 설정해준다. (생략가능하지만 생략하면 이름이 랜덤으로 생성)
    addr varchar2 (100)  null constraint CK_MEMBER5_ADDR check ( addr  in ( '서울' , '부산', '대구')) ,
    jumin char (13) null constraint U_MEMBER_5_JUMIN unique,                               --중복되면 안됨                  -- 자릿수가 지정된 컬럼
    phone varchar2 (50) not null constraint U_MEMBER_5_PHONE unique ,              --중복되면 안됨 
    age number (3) constraint CK_MEMBER5_AGE check (age > 0 and age < 200)  ,                                                                                               -- 정수 3자리
    gender char(1) constraint CK_MEMBER5_GENDER check (gender in ('w' , 'm')),
    weight number (5,2) ,                                                                                         -- 실수 전체 5자리 , 소숫점이하 2자리
    hiredate date default sysdate  ,
    addr2 char(10) default '서울' ,
    age2 number default 0
    );
    
insert into member5 ( id ,  pass, addr, jumin , phone , age , gender , weight , hiredate , addr2 , age2 )
values ('333' , '뭐' , '대구' , '80832-111551' , '018-1534-5571' , 100 , 'w', 47.1253 , '23/12/14' , '울산' , 88 ); 
 
select * from member5;    

