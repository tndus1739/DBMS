/*
       ★ DDL : Create , Alter , Drop --> 객체  (테이블 , 뷰 , 함수 , 저장프로시져 , 트리거 , 시퀀스 .. )
        
        - 테이블 생성 후 , 기존에 생성된 테이블에 대해서 빈번하게 유지보수 : Alter table
        
        1. 컬럼의 자료형을 변경 : varchar(50) ---> varchar (100) 
        2. 컬럼의 이름을 변경 , 컬럼을 삭제 , 컬럼을 추가
        3. 컬럼의 제약조건을 추가 (Primary key , Unique , NOT NULL , CHECK , Foreign Key , default ) 
       
*/

-- 실습을 위한 테이블 복사  : 컬럼명 , 값만 복사되고 컬럼에 부여된 제약조건은 복사되지 않음

create table emp60 
as
select * from employee ;

create table dept60 
as
select * from department ;

select * from emp60;
select * from dept60 ;

-- 데이터 사전 : user_ , user_constsraints : 데이터 베이스에 존재하는 모든 테이블에 대한 제약조건을 출력
select * from user_constraints
where table_name in ( 'EMPLOYEE' , 'DEPARTMENT');

-- 복사한 테이블은 제약조건은 복사되지 않는다.
select * from user_constraints
where table_name in ( 'EMP60' ,  ' DEPT60' );

-- 1. Alter Table 을 사용해서 기존 테이블에 컬럼을 추가 : birth(date) , email(varchar2 (100))
    -- 테이블에 컬럼을 추가시 null로 처리 후 컬럼을 추가해야함
    
desc dept60;

alter table dept60
add (birth date ) ;

-- 기존 테이블에 여러개의 컬럼을 한꺼번에 추가하기
alter table dept60
add ( email varchar2(100) , addr varchar2(200) , jumin char (14));

select * from  dept60;

-- 기존 생성된 컬럼에 값 넣기 : update

update dept60
set birth = sysdate , email = 'aaa@aaa.com' , addr = '서울' , jumin = '123456-1234567'
where dno =10;

rollback;

-- default 제약조건은 not null 앞에 위치해야 한다. 
create table account11 (
no number not null primary key,
name varchar(50) not null,
money number  (7,2) default 0  not null 
);

-- 2. 컬럼에 부여된 자료형 수정 : char(10) --> char(50) , varchar2(100) --> varchar2(200) 
desc dept;

alter table dept60
modify email varchar(200) ;

-- 3. 특정 컬럼을 제거 
alter table dept60 
drop column  jumin ;

-- 4. 컬럼의 이름 변경 : addr --> address1
alter table dept60
rename column addr to address1 ;

-- 5. 테이블 이름 변경 : dept60 --> dept70
rename dept70 to dept60;

select * from dept60;

-- 6. 기존 테이블의 제약조건 추가 , 제거 ( Primary key , Unique key , Foreign key , check , default )

select * from user_constraints where table_name in ('DEPT60' , 'EMP60');
select * from user_constraints where table_name in ('DEPARTMENT' , 'EMPLOYEE');

-- 6-1. Primary key 제약조건 추가 : dept60 (dno) , emp60 (ename)
    -- 테이블에서 1번만 넣을 수 있다.
    -- not null 컬럼에 primary key 를 넣을 수 있다.
    -- 컬럼에 null 값이 없어야 함
    
-- dept60 (dno)에 Primary key  제약조건 추가  : 제약조건 이름을 명시해서 부여함
alter table dept60
add constraint PK_DEPT60_DNO primary key (dno);

-- 제약조건 이름을 생략한 경우 : Oracle에서 sys_* 로 시작되는 임의의 이름을 넣음
alter table dept60
add  primary key (dno);          --  "constraint PK_DEPT60_DNO"  생략가능

alter table emp60
add constraint PK_EMP60_ENO primary key (eno);

-- 제약조건 제거
alter table dept60
drop constraint PK_DEPT60_DNO ;

-- 6-2 . Foreign Key : 다른 테이블의 컬럼의 값을 참조해서 값을 넣을 수 있다.
    -- 테이블 ( 부모 1개)  --> FK 테이블 (자식 : 다수)
    -- JOIN 시 on절에서 사용되는 키 컬럼
    -- 부모 테이블의 참조 컬럼은 Primary key , Unique를 참조할 수 있다. (부모테이블에 Primary key 나 Unique가 없으면 참조를 못한다)
    -- 참조할 컬럼의 데이터 타입이 동일하거나 비슷해야 한다.
    
select * from user_constraints where table_name in ('DEPT60' , 'EMP60');

-- 넣는 순서 : Primary Key (1순위)  , Foreign Key (2순위)    
-- EMP60 (dno) ---> DEPT60(dno)
desc dept60;
desc emp60;

alter table dept60
drop constraint PK_DEPT60_DNO ;

-- Foreign Key 제약 조건을 넣기 위해서는
    -- 1. 부모테이블의 컬럼의 Primary Key , Unique 가 있어야 한다.
    -- 2. 참조 컬럼의 자료형이 비슷하거나 같아야 함

-- 1) 부모 테이블의 Primary key 할당
alter table dept60
add constraint PK_DEPT60_DNO primary key (dno);

-- 2) 자식 테이블의 Foreign Key 할당 : 부모 테이블의 Primary Key 를 참조
alter table emp60
add constraint FK_EMT60_DNO foreign key (dno) references DEPT60 (dno) ;

-- Foreign Key 는 JOIN 시  ON 절에서 참조 하는 컬럼

select eno , ename , salary , e.dno , d.dno , dname , loc
from emp60 e
    join dept60 d
      on e.dno = d.dno ;

-- 6-3. Unique 제약 조건 추가 : 컬럼에 중복된 값을 넣지 못하도록 설정
    -- 한 테이블에 여러 컬럼에 부여할 수 있다.
    -- not null , null 모두 Unique 사용 가능  --> 주민번호 , Email
    -- null을 여러번 중복해서 넣을 수 있다. (오라클)
    -- 동일한 값을 넣을 수 없다.
    
desc dept60;
desc emp60;
    
select * from dept60;
    
alter table dept60
add constraint U_DEPT60_EMAIL unique (email) ;
    
insert into dept60
values ( 60 , '영업부' , '부산' , sysdate , 'ㅓㅓㅓ@aaa' , '부산' );
commit ;
    
update  dept60
 set address1 = '경기도'
where dno = 60 ; 
    
 alter table dept60
add constraint U_DEPT60_ADDRESS1 unique (address1) ;
    
insert into dept60
 values ( 70 , '영업부' , '부산' , sysdate , 'ㅓㅓ5@aaa' , '울산' );
commit ;
    
update dept60   
set address1 = '광주'
where dno = 60;
    
-- 제약 조건 제거
alter table dept60
drop constraint U_DEPT60_ADDRESS1;
    
-- 6-4 . check 제약조건 추가 : 컬럼에 조건을 부여해서 조건에 맞는 값만 입력
select * from dept60;
select * from emp60;
    
select * from user_constraints where table_name in ('DEPT60' , 'EMP60');
    
alter table emp60
add ( addr varchar2(50) , hdate date ) ;
    
alter table emp60
add age number(3) ;
    
select * from emp60;
    
-- addr 컬럼은 '서울' , '부산' , '광주'만 넣을 수 있도록 조건
-- hdate 컬럼은 2023년 01월 01일  ~ 2023년 12월 31일까지만 넣도록 조건
-- age 컬럼은 0살 ~300살의 정수만 가능
    
alter table emp60
add constraint CK_EMP60_ADDR1 check (addr in ('서울' , '부산' , '광주'));
    
 insert into emp60  (eno , dno , addr)
 values (8080, 20 , '광주');
    
alter table emp60
add constraint CK_EMP60_HDATE 
check (hdate between to_date ('20230101' ,'YYYYMMDD') and to_date('20231231' , 'YYYYMMDD'));
    
insert into emp60 (eno , dno , addr , hdate )
values (2323, 20 , '서울', '23/01/01');
 
alter table emp60 
add constraint CK_EMP60_AGE check (age >=0 and age <= 300 );
    
 insert into emp60 (eno , dno , addr , hdate , age )
values (9090, 20 , '서울', '23/01/01' ,88);
commit ;
-- 6-5 . NOT NULL  제약 조건 : 컬럼에 NULL 이 없도록 설정 , 반드시 값이 입력이 되어야 한다.
    -- 컬럼의 값이 NULL이 있으면 오류 발생
        
desc dept60;
select * from dept60;
    
alter table dept60
modify address1 constraint NN_DEPT60_ADDRESS1 not null;   -- null 값이 발견되어서 설정 불가
    
--  update로 null을 수정
update dept60
set address1 = '경기도'
where address1 is null;
    
select * from user_constraints where table_name in ('DEPT60' , 'EMP60');    
    
insert into dept60
values ( 99, '관리부' , '부산' , sysdate , 'ccc' , '제주');

-- 6-6. default : 제약 조건이 아니다. 제약조건이름을 부여할 수가 없다. 
    -- 컬럼의 값을 넣지 않을 경우 default로 설정된 값이 자동으로 들어감
    -- default 의 설정을 제거하기 위해서는 default null  --> 값을 넣지 않으면 null로 세팅 ( null이 기본값)
    
alter table dept60
add address2 varchar2(100) ;
    
alter table dept60
modify address2 default '서울';     -- constraint를 넣지 않는다. (제약조건 이름을 설정할 수 없기 때문에)

insert into dept60
values ( 92, '관리부' , '부산' , sysdate , 'ㅁcc' , '제주', default );             -- 기본값을 넣고 싶으면 생략하지 말고 값에 'default'입력해준다.  

commit;

select * from dept60;

insert into dept60 ( dno , address1)
values (25 , '강릉' );

-- deault 조건 제거 : default null
alter table dept60
modify address2 default null ;

-- 제약조건 제거 : PrimaryKry , Foreign Key , Unique , NOT NULL , Check
    -- alter tale 테이블명 drop 제약조건이름 ;

-- 제약조건 제거 : default
    -- alter table 테이블명 modify 컬럼명 default null ;