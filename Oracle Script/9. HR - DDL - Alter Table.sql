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

