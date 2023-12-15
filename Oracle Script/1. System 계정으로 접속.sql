
select * from help;
select * from redo_log;

-- SQL의 주석 : 한줄주석

/*
    여러줄 주석
*/

/*
    일반 계정을 생성 후 일반 계정으로 접속 : 계정 생성, 권한 부여
*/
-- 무언가를 실행할 때는 블럭 잡고 실행 -> 블럭 잡힌 것만 실행

-- system계정으로 접속한 쿼리창에서만 계정을 생성할 수 있다.

-- 1. hr 계정을 생성 : Oracle 12 버정 이상 부터 계정 생성시 -> c##계정명 (초기한번만 설정)
    -- 계정명 : hr 암호 : 1234
    
create user C##HR20 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

-- 2. 계정에 권한을 부여하기 : connect, resource 권한 

grant resource, connect to C##HR20;    -- grant : 부여하겠다.


-- system 계정에서 HR계정에게 create view 권한을 부여함

grant create view  to C##HR20;    -- HR 계정에 view를 만들 수 있는 권한을 주겠다,


-- 3. 테이블 스페이스에서 서용량 할당

alter user C##HR20 quota unlimited on USERS; -- user space를 무제한 사용할 수 있도록 함


--4. 계정 삭제
drop user C##HR4 cascade  -- cascade: 계정을 삭제하면서 그 안에 객체나 다른 모든 것들도 삭제

-- 다른 사용자 테이블의 내용 보기

select * from  "C##HR"."ACCOUNT10" ;
