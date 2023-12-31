/*   ★★★★★

       ★ ERD 표 참고 ( 테이블 - 데이터 )
       
       ★  JOIN : DataBase 에는 많은 테이블이 존재 , 모델링을 통해서 테이블이 분리되어 있음 
        -  R-DBMS : 테이블과 테이블은 Relatioinship 관계 ( 테이블과 테이블이 관계를 가지고 있다.)
            employee 테이블과 department 테이블은 하나의 테이블인데 모델링 ( 1, 2, 3 정규화) 을 통해서 분리해 놓은 것
            
       ★  모델링 : 중복제거 , 성능향상 , 불필요한 하드용량 차지 방지
         - 테이블을 분리시켜 놓은 이유 : 불필요한 하드용량 차지 방지 , 중복제거 
         
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
                 
                 
                 
*/

    select * from employee ;         -- employee 테이블의 dno 컬럼은 department테이블의 dno 컬럼을 참조한다.  ( 참조 : Foreign Key)
                                                        
    select * from department ;      -- 부모테이블
    
--  ★ 테이블 복사 : 원본 테이블의 제약조건은 복사되어 오지 않는다.
--                           Alter Table을 사용해서 제약조건을 부여
    
  create table emp01                                -- table을 만들어라 ( emp01 : employee테이블을 기준으로 복사한 것)
  as 
  select * from employee ;
  
  create table dept01
  as
  select * from department ;
  
  /*
         ★ 테이블의 제약조건을 확인하는 명령어
         user_constraints : 데이터 사전  --> 테이블의 각종 정보를 알려주는  테이블
  */
    
    select * from user_constraints ;           -- 모든 데이터베이스 테이블의 제약조건 보기     -->   Constraints_type 에서 R : Foreign Key  / P : Primary Key
    
    select * from user_constraints              
    where table_name in ('EMPLOYEE' , 'DEPARTMENT') ;        -- EMPLOYEE' , 'DEPARTMENT' 테이블의 제약조건 보기
    
  -- 테이블을 복사하면 테이블의 컬럼에 부여된 제약조건은 복사되어 오지 않는다. ( 컬럼과 값만 복사되어온다.)
  -- Alter Table 을 사용해서 제약조건을 부여해야 함
  -- Alter Table : 생성된 테이블을 수정
   select * from user_constraints              
   where table_name in ('EMP01' , 'DEPT01') ;  
 
 --  dept01 테이블에 dno 컬럼에  Primary Key 제약 조건을 추가
  alter table dept01
  add constraint PK_DEPT01_DNO primary key (dno);      -- dno 컬럼에 primary key 제약조건을 넣겠다.
 
  --  emp01 테이블에 eno 컬럼에 Primary Key 제약 조건을 추가
  alter table emp01
  add constraint PK_EMP01_ENO primary key (eno); 
  
  --  emp01 테이블에 dno 컬럼에 Foreign Key 부여 , 참조 ( References) 할 테이블의 컬럼은 Dept01 테이블의 dno 컬럼을 참조
  
  alter table emp01
  add constraint FK_EMP01_DNO foreign key (dno) references dept01(dno);
  
  -- Primary Key 컬럼을 확인
  desc emp01 ;
  
  select * from emp01;       -- dno 컬럼은 depy01테이블의 dno컬럼에 있는 값만 가져올 수 있다. (foreign key 제약조건이 있기 때문에)
  
  -- 값을 넣을 때 컬럼에 부여된 제약조건을 잘 확인하고 값을 insert
  -- eno : Preimary Key 가 등록, 중복된 값을 넣으면 안됨
  -- dno : Foreign Key 가 등록 , Dept01 테이블의 dno컬럼에 존재하는 값만 넣어야 한다.
  
--  insert into emp01 ( eno, ename , job , manager , hiredate , salary , commission , dno)            -- 오류발생 ( eno컬럼에 동일한 값 넣으면 안됨 , dno 컬럼에는 부모테이블에 있는 값만 넣어야 함)
--  values ( 7934 , 'SOOYEON' , 'PRESIDENT' , 7782 , '23/12/11' , 1500 , null , 50 ) ;                       -- 오류 보고 -  ORA-00001: 무결성 제약 조건(C##HR.PK_EMP01_ENO)에 위배됩니다

insert into emp01 ( eno, ename , job , manager , hiredate , salary , commission , dno)
values ( 7901 , 'SOOYEON' , 'PRESIDENT' , 7782 , '23/12/11' , 1500 , null , 10 ) ;

commit ;     -- DML ( insert, update , delete )에서 DB에 영구히 저장되도록 함
                    -- 커밋을 해야 DB에 영구적으로 저장이 되고 안하면 메모리에 저장이 된다. (오라클에만 적용)
                    
select * from emp01;  

select * from dept01 ;

-- dept테이블에 값 넣기 : dno 컬럼 -> Primary Key 가 있음 ( 중복된 값을 넣을 수 없다.)

desc dept01 ;

insert into dept01  ( dno , dname , loc)
values ( 50, 'HR' , 'SEOUL' ) ;

commit ;    --  DML ( insert, update , delete )에서 반드시 commit 반드시 적용 ★★★★★

select * from dept01 ;

select * from emp01 ;      -- > emp01 테이블에는 primary key와 foreign key 제약조건이 들어있다. 

/*
  ★★  JOIN  : 여러 테이블의 컬럼을 출력할 때 JOIN을 통해서 하나의 테이블 처럼 출력
   - join 을 할때는 두 테이블의 공통 키 컬럼을 확인
   - emp01 , dept01 테이블의 공통 키 컬럼은 dno
   - EQUI JOIN : 오라클에서만 작동하는 JOIN 구문
   - ANSI JOIN : 모든 DBMS 에서 공통으로 사용되는 JOIN 구문
*/

/*
  ★★  EQUI JOIN 구문으로 두 테이블 조인
   - from 절에서 JOIN할 테이블을 명시 ( , (콤마)로 구분)
   - 테이블이름은 별칭이름으로 둠
   - where 절에서 반드시 두 테이블의 공통키 컬럼을 명시해야 함
   - and 절에서 조건을 처리
   - 공통키 컬럼을 출력시 반드시 테이블명 ,  컬럼명을 명시 
*/
select e.eno , e.ename , e.job , d.dno, d.dname , d.loc                -- 컬럼 앞에 테이블이름 ( e , d)  생략가능하지만 dno 컬럼은 생략 불가
from emp01 e , dept01 d                                                                   -- from + 조인할 테이블  (emp01을 e라고 alias 시킴)
where e.dno = d.dno ;                                                                       -- where 절에서 반드시 두 테이블의 공통키 컬럼을 명시해야 함

select e.eno , e.ename , e.job , d.dno, d.dname , d.loc                
from emp01 e , dept01 d                                                                   
where e.dno = d.dno         
and d.dno = 10 ;

/*
   ★★★  ANSI JOIN : 모든 DBMS 에서 공통으로 사용되는 JOIN 구문
    
    - INNER JOIN : 두 테이블에서 키컬럼의 공통되는 부분만 출력  (80% 이상은 INNER JOIN )
    - OUTER JOIN :
             º LEFT OUTER JOIN
             º RIGHT OUTER JOIN
             º FULL OUTER JOIN
    - SELF JOIN
    - CLOSS JOIN
*/

-- INNER JOIN : ANSI JOIN
    -- from  절에 JOIN테이블 이름을 명시
    -- 가장 많이 사용되기 때문에 INNER KEY는 생략가능
    -- on 절에 두 테이블의 공통 키 컬럼을 명시 , 두 테이블의 공통인 것만 출력
    
-- 테이블 이름을 alias (별칭) 사용하지 않은 경우
select eno , ename , salary , dept01.dno , dname , loc    -- 다른 컬럼의 테이블이름은 다 생략가능해도 dno 컬럼은 생략불가 ( 공통키 컬럼을 가지고 있기 때문에)
from emp01 INNER JOIN dept01               -- INNER 생략가능  ( 그냥 JOIN 은  INNER JOIN 을 말함) 
on emp01.dno = dept01.dno ;                  -- 테이블이름은 알리아스 시켜놓으면 테이블 별칭을 사용해도 되는데 알리아스 시키지 않으면 테이블이름을 다 입력해야 함

-- 테이블 이름을 alias (별칭) 사용한 경우
select eno , ename , salary , d.dno , dname , loc
from emp01 e  JOIN dept01 d 
on e.dno = d.dno                                        -- on 절에 두테이블에 공통 키컬럼을 명시
where e.dno = 20                                        
order by ename desc;

-- INNER JOIN : ANSI SQL : 모든 DBMS에서 공통으로 사용되는 SQL 퀄리 ( Oracle, MYSQL , MSSQL , DB2 , ... )
    -- ON절에 두 테이블의 공통분모만 출력

select *                                                                -- 원래는 하나의 테이블이나 중복된 값이 많아서 모델링을 통해서 분리되었는데 다시 하나의 테이블처럼 가져오는게 JOIN
from emp01 e join dept01 d
on e.dno = d.dno;

-- OUTER JOIN (가끔 사용함)
    -- LEFT OUTER JOIN : 두 테이블의 공통 부분과  왼쪽 (emp01) 테이블의 모든 내용을 출력
    -- RIGHT OUTER JOIN :두 테이블의 공통 부분과  오른쪽  (dept01) 테이블의 모든 내용을 출력
    -- FULL OUTER JOIN : 왼쪽 , 오른쪽 테이블의 모든 내용을 출력
 
 select * from dept01;
 
 insert into dept01 (dno , dname , loc )
 values ( 60 , 'MANAGE' , 'BUSAN' );
 commit ;
 
    
select *                                                                     -- INNER JOIN ( INNER 생략가능)
from emp01 e join dept01 d                                   -- e.dno 와  d.dno 에서  매칭되는  값만 출력
on e.dno = d.dno ;

select *                                                                     -- LEFT OUTER JOIN ( 왼쪽 테이블의 내용은 모두 출력)
from emp01 e LEFT OUTER JOIN dept01 d
on e.dno = d.dno;

select *                                                                     -- RIGHT OUTER JOIN  ( 오른쪽 테이블의 내용은 모두 출력)
from emp01 e  RIGHT OUTER JOIN dept01 d
on e.dno = d.dno;

select *                                                                      -- FULL OUTER JOIN  ( 두테이블 (왼쪽 ,오른쪽 테이블)의 모든 내용을 모두 출력)
from emp01 e  FULL OUTER JOIN dept01 d
on e.dno = d.dno;

-- SELF JOIN : 자신의 테이블을  JOIN , 자신의 테이블을  반드시 별칭이름으로 가상으로 생성해서 JOIN
    -- 조직도 출력 , 직급 상사를 바로 출력할 때 사용
    
select e.eno 사원번호 , e.ename 사원이름 , e.manager "직속 상관번호" ,          -- SELF JOIN  
m.eno 직속상관사번 , m.ename 직속상관명       
from  emp01 e JOIN emp01 m                                                                             -- 두 테이블이 동일한 테이블이라서 반드시 별칭이름 사용
on e.manager = m.eno ;                                                                                      -- 직속상관 이름과 그 직속상관의 이름이 뭔지

-- SELF JOIN 으로 사원이름에 대한 직속상관이 누구인지 출력

-- 직속상관이 없는 사원을 출력 : LEFT OUTER JOIN
select e.eno 사원번호 , e.ename 사원이름 , e.manager "직속 상관번호" ,          
m.eno 직속상관사번 , m.ename 직속상관명       
from  emp01 e LEFT OUTER JOIN emp01 m                                                                             
on e.manager = m.eno ;             

-- 사원번호는 있지만 어떤 사원의 상관이 아닝 사원도 모두 출력해라 : RIGHT OUTER JOIN
select e.eno 사원번호 , e.ename 사원이름 , e.manager "직속 상관번호" ,          
m.eno 직속상관사번 , m.ename 직속상관명       
from  emp01 e RIGHT OUTER JOIN emp01 m                                                                             
on e.manager = m.eno ;             

-- 직속 상관이 없는 것 ( 왼쪽) , 사원번호는 가지지만 어떤사원의 직속 상관이 아닌 사원(오른쪽) : FULL OUTER JOIN
select e.eno 사원번호 , e.ename 사원이름 , e.manager "직속 상관번호" ,          
m.eno 직속상관사번 , m.ename 직속상관명       
from  emp01 e FULL OUTER JOIN emp01 m                                                                             
on e.manager = m.eno ;    

select eno , ename , manager , eno , ename
from employee ;

-- 사원이름 'SCOTT'의 부서명 (dname) , 부서위치(loc)  (INNER JOIN사용)  --> ename : 'SCOTT'은 emp01 /  dept01 : dname , loc
-- ANSI JOIN 

select * from emp01 ;
select * from dept01 ;

-- emp01, dept01 을 JOIN해서 출력

select e.ename 사원이름 ,   d.dname 부서명 , d.loc 부서위치    -- select 절에 dno를 입력하면 오류발생 (e.dno 나 d.dno라고 입력해야 함)
from emp01 e join dept01 d
on  e.dno = d.dno
where e.ename ='SCOTT';

-- 월급이 2000만원 이상인 사원의 이름, 부서명, 부서위치, 월급을 출력 : ANSI JOIN
 select e.ename 사원이름 , d.dname 부서명 , d.loc 부서위치 ,  e.salary 월급
 from emp01 e join dept01 d
 on e.dno = d.dno
 where salary >= 2000 ;

select ename 사원이름 ,  salary  월급, dname 부서명 , loc 부서위치 , e.dno
 from emp01 e join dept01 d
 on e.dno = d.dno
 where salary >= 2000 
 order by d.dno desc;
 
-- ANSI JOIN
-- 직책(job)이 'MANAGER'인 사원이름(ename) , 부서번호(dno) , 부서명(dname) , 부서위치( loc) 를 출력하되 사원이름을 내림차순 정렬
select job 직책 , ename 사원이름 , e.dno 부서번호 , dname 부서명 , loc  부서위치
from emp01  e join  dept01 d
on e.dno = d.dno
where job = 'MANAGER'
order by ename desc ;

-- ------------------------------------------------------------------------------------------------------------------------------
-- ★  view (뷰) : 가상의 테이블 ,  값은 가지지 않고 코드만 가진다.
    -- 1. 실제 테이블의 특정 컬럼만 출력할 때  --> 보안
    -- 2. 복잡한 쿼리를 한 번 만들어서 실행 --> 복잡한 join 쿼리를 단순화 할  수 있다. 


-- view를 실습하기 위한 샘플테이블 : emp02

drop table emp02 cascade constraints ;

create table emp02
as
select eno, ename , salary , commission , job , hiredate , dno
from employee
where salary >= 1500 ;


select * from emp02 ;

create table dept02
as
select * from department ;

-- 기존의 원본테이블 : employee . department --> emp01 , dept01
-- 필드명, 값만 복사됨
-- 컬럼에 부여된 제약조건은 복사되지 않음  --> Alter Table 을 사용해서 제약조건 추가

select * from user_constraints where table_name in ( 'EMPLOYEE' ,'DEPARTMENT') ;
select * from user_constraints where table_name in ( 'EMP02' ,'DEPT02') ;   -- > 아직 제약조건이 안들어가있다.

--1)  DEPT02 테이블의 dno ( Primary Key) 를 먼저 설정 
-- 2) EMP02 테이블의 eno (Primary Key) , dno (FK)  --> dept02 (dno)

alter table DEPT02
add constraints PK_DEPT02_DNO primary key (dno) ;

alter table EMP02
add constraints  PK_EMP02_ENO primary key ( eno) ;

alter table EMP02
add constraints FK_EMP02_DNO foreign key (dno) references dept02 (dno);

-- view  생성 
-- 실제 테이블의 중요 정보를 감추고 출력 , 보안 향상 가능
-- as 다음에 select코드를 가지고 있음

select * from emp02 ;    -- 실제 테이블(emp02)  : 값을 가지고 있다.

-- 뷰 생성 --> 실제 테이블의 값을 가지는 것이 아니라 실행 코드만  쿼리만 작동됨
create view v_emp02     
as 
select ename, job , dno
from emp02 ;

--뷰 실행
select 컬럼명 from 테이블명[뷰명]

select * from v_emp02 ;

-- 1. 데이터 사전 : user_테이블  -->  시스탬의 정보가 저장되어있는 테이블

select * from user_views ;

-- 2. 사용의 편의성, 복잡한 구문을 view 를 생성해서 저장시켜 두고 실행 -->  JOIN

-- 두 테이블을 조인해서 월급이 2500이상인 사원 정보를 출력
create view v_join
as
select ename , job ,salary , dname , loc
from emp02 e
     join dept02 d
       on e.dno = d.dno
where salary >= 2500 ;

select * from v_join ;

-- employee, department 테이블의 부서별로 최소 월급을 받는 사원이름, 사원직책 , 부서명, 부서위치를 출력하되  부서번호 20번은 제외하고 최소월급이 1500 이상인 사원정보만 출력
--join , group by (부서별로) , having , where
-- 뷰안에 쿼리를 저장하고 뷰를 실해해서 출력


-- 부서별로 최소 월급을 받는 사원 정보를 출력하는 view, 20번 부서는 제외됨
create view v_join2
as
select ename 사원이름 , job 사원직책 , dname 부서명 , loc 부서위치 , d.dno 부서번호
from employee e
    join department d
      on e.dno = d.dno
where salary in (
    -- 부서별로 최소 월급
    select min ( salary)  from employee
    where dno <>20
    group by dno
     having min (salary ) >= 900 
  ) ;

select * from v_join2 ;

-- view 에 정렬 컬럼까지 적용된
create view v_join3
as
select ename 사원이름 , job 사원직책 , dname 부서명 , loc 부서위치 , d.dno 부서번호
from employee e
    join department d
      on e.dno = d.dno
where salary in (
    -- 부서별로 최소 월급
    select min ( salary)  from employee
    where dno <>20
    group by dno
     having min (salary ) >= 900 
  )
  order by ename desc ;
 select * from v_join3 ;

-- view 에 as 블락에 select 문이 옴
    -- 실제 값을 가지고 있지 않음 , select 코드만 들어있음
    -- 실제 테이블의 컬럼에 잘 매칭 될 경우
    -- insert , update , delete 를 view를 통해서 할 수 있다. 단 실제 테이블에 각 컬럼의 제약 조건에 맞을 때 가능
    
 select * from emp02;
 
 -- view 생성
 create view v_test01
 as
 select eno, ename , dno
from emp02;

--view 삭제
drop view v_test01;

--view 실행
select * from v_test01;

--view에 값을 넣을 수 있다. --> 실제 테이블에 값이 들어감 (원래 view는 값이 없음)
insert into v_test01 (eno, ename , dno)
values (8080 , 'HONG' , 30);
commit;

-- view를 사용해서 값을 수정 : update (반드시 where 조건이 들어가야 함 , 컬럼명은 Primary Key 가 들어간 컬럼이어야 한다. )

update v_test01
set ename = 'KIM'
where eno = 8080;
commit;

-- view를 사용해서 값을 삭제 : delete  (반드시 where 조건이 들어가야 함 , 컬럼명은 Primary Key 가 들어간 컬럼이어야 한다. )

delete v_test01
where eno = 8080;
commit;

-- v_test02 : insert (안됨)
create view v_test02
as
select eno,  ename , salary        -- dno 컬럼이 없어서 
from emp02 ;

insert into v_test02 ( eno , ename , salary)
values (9090, 'SIM' , 3500 ) ;

-- 테이블의 특정 컬럼에 not null 제약 조건 추가

alter table emp02
modify dno NOT NULL ;

delete v_test02
where eno = 9090;
commit ;

