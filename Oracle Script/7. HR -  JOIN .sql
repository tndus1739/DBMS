/*
       ★  JOIN : DataBase 에는 많은 테이블이 존재 , 모델링을 통해서 테이블이 분리되어 있음 ( 테이블과 테이블은 Relatioinship 관계   : R - DBMS )
            employee 테이블과 department 테이블은 하나의 테이블인데 모델링 ( 1, 2, 3 정규화) 을 통해서 분리해 놓은 것
       ★  모델링 : 중복제거 , 성능향상 , 불필요한 하드용량 차지 방지
       
       ★ 제약조건 : 테이블의 컬럼에 들어가는 키 , 데이터의 무결성 ( 결함없는 데이터 -> 내가 원하는 값만 넣도록 하는 것 )
           - Primary Key  제약조건 
           
             →  테이블의 컬럼에 1번만 넣을 수 있다. 
                  2개의 컬럼을 묶어서 PK를 넣을 수 있다. (원래는 하나당 하나의 PK)
                  테이블을 생성할 때 반드시 PK (Primary Key)이 존재해야 한다.  
                  Update , Delete 구문에서 PK 컬럼을 where 조건으로 사용함
                  특정 컬럼에 중복된 값을 넣지 못하도록 함
                  반드시 not null 컬럼이어야 함 ( null 사용 불가)                            
                  index가 자동으로 생성된다. ( index : 컬럼의 검색을 빠르게 함)
                  join시 ON에서 많이 사용하는 키 컬럼
                                              
           - Unique Key 제약조건 :
             
             →  컬럼에 중복된 값을 넣지 못하도록 함
                  null을 넣을 수 있다. 단, 1번만 가능 ( not null , null )
                  하나의 테이블에 여러번 Unique Key 를 넣을 수 있다.
                  index 가 자동으로 생성된 . JOIN시 ON에 사용됨
                  
           - Foreign Key  제약조건 : 
      
            →  다른 테이블 (부모테이블)의 특정 컬럼을 참조해서 값을 넣도록 함
                 부모테이블을 참조해서 넣기 때문에 부모테이블에 없는 값은 참조해서 값을 넣을 수 없다.
                 Foreign Key 가 참조하는 컬럼은 부모테이블의 Primary Key , Unique Key 를 참조함
            
           - NOT NULL 
           
           → 컬럼에 NULL을 넣을 수 없도록 하는 제약조건
           
           - CHECK
           
            → 컬럼에 조건을 넣어서 내가 원하는 값만 넣을 수 있도록 함
                ex) 월 (month) 컬럼에 1 ~ 12 가지 넣을 수 있도록 check 제약조건 사용
           
           - DEFAULT
           
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
 
    
select *                                                              -- INNER JOIN ( INNER 생략가능)
from emp01 e join dept01 d                            -- e.dno 와  d.dno 에서  매칭되는  값만 출력
on e.dno = d.dno ;

select *                                                              -- LEFT OUTER JOIN ( 왼쪽 테이블의 내용은 모두 출력)
from emp01 e LEFT OUTER JOIN dept01 d
on e.dno = d.dno;

select *                                                              -- RIGHT OUTER JOIN  ( 오른쪽 테이블의 내용은 모두 출력)
from emp01 e  RIGHT OUTER JOIN dept01 d
on e.dno = d.dno;

select *                                                              -- FULL OUTER JOIN  ( 두테이블 (왼쪽 ,오른쪽 테이블)의 모든 내용을 모두 출력)
from emp01 e  FULL OUTER JOIN dept01 d
on e.dno = d.dno;

-- SELF JOIN : 자신의 테이블을  JOIN , 자신의 테이블을  반드시 별칭이름으로 가상으로 생성해서 JOIN
    -- 조직도 출력 , 직급 상사를 바로 출력할 때 사용
    
select e.eno 사원번호 , e.ename 사원이름 , e.manager "직속 상관번호" , m.eno 직속상관사번 , m.ename 직속상관명
from  emp01 e JOIN emp01 m                                          -- 두 테이블이 동일한 테이블이라서 반드시 별칭이름 사용
on e.manager = m.eno ;                                                     -- 직속상관 이름과 그 직속상관의 이름이 뭔지

select eno , ename , manager , eno , ename
from employee ;






