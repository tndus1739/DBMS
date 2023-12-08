/*  

★ 그룹 함수 : group by , having

select 컬럼명
from 테이블[뷰]
where 조건
group by 컬럼명 [동일한 값을 그룹핑]
(having  조건 [group by 한 결과 값의 조건]    -- having 생략가능
order by 컬럼명 asc [desc]

★ 집계 함수 : "number 타입"의 컬럼에 적용 ★ 주의     --> NULL을 자동으로 처리
  SUM - 컬럼의 모든 값의 합
  AVG - 컬럼의 평균값
  MAX - 컬럼의 최대값
  MIN - 컬럼의 최소값
  COUNT (*) - 그룹핑된 레코드 수 출력 
  
★ 주의 : 단일 행으로 출력이 되기 때문에 다른 컬럼과 사용시 오류
            단, group by절에 그룹핑된 컬럼은 출력할 수 있다. 
*/
desc employee;

select sum(salary), salary              -->  오류 : 단일 행으로 출력이 되기 때문에 다른 컬럼과 사용시 오류
from eemployee ;

-- 컬럼에 함수 사용 
-- 월급 (salary)
select sum (salary) 합계 , round(avg ( salary )  , 2) 평균 , max ( salary ) 최대값 , min ( salary ) 최소값 , count (*) "계산된 레코드 수"
from employee;

-- 집계 함수는 Null을 자동으로 처리함
select commission
from employee;

-- 컬럼에 함수 사용 (월급)
select sum (commission) 합계 , round(avg ( commission )  , 2) 평균 , max (commission) 최대값 , 
           min ( commission ) 최소값 , count (*) "계산된 레코드 수"
from employee;

-- 부서별로 월급의 합계, 평균, 최대월급 , 최소월급, 그룹핑된 수를 출력

select dno 부서번호 , sum(salary) 합계 , round (avg (salary))  평균 ,                                             --> 그룹핑된 컬럼은 출력할 수 있다. 
           max ( salary) 최대값 , min ( salary ) 최소값 , count (*) 그룹핑된수
from employee
group by dno;                        -- DNO 컬럼의 동일한 값을 그룹핑해서 집계함수를 적용함

select salary , dno
from employee
order by dno asc;

-- 직책(job)별로 월급의 합계, 평균 , 최대값, 최소값, 그룹핑된 수를 출력

select ename, job, salary
from employee
order by job;

select  job 직책, count (*) 그룹핑된수, sum(salary) 합계 , 
            round (avg (salary))평균 , max(salary) 최대값, min(salary) 최소값 
from employee
group by job;                                                      -- job 컬럼의 동일한 값을 그룹핑



select count (*) 전체레코드수 from employee;

/*

★ group by 절에서 where [조건] vs having [조건]
    where [조건] : gruop by 하기 전에 조건을 가져옴 , 별칭이름을 사용할 수 없다.
    having [조건] : group by 해서 나온 결과에 대한 조건 , 별칭이름을 사용할 수 없다.
    order by [컬럼명] asc[desc] : 별칭이름을 사용가능

*/
-- 차이점을 알아야한다.
-- 직급별로 월급의 합계 , 평균, 최대값, 최소값 , 그룹핑된 수를 출력하되 부서번호 20은 제외하고 , 부서별로 평균이 2000이상인 내용만 출력 , 평균을 desc 출력
select  job,  sum(salary) 합계 , round (avg (salary))평균 , 
           max(salary) 최대값, min (salary) 최소값 , count (job) 그룹핑된수       -- count안에 * 넣어도 되고 job넣어도 된다.
           from employee
where dno <> 20        --> group by 전의 조건                                    ★   where dno <> 20    =   where dno not in ( 20 )
group by job
having round (avg (salary)) >=2000 
order by round (avg (salary))  desc;                                                    -- order by 는 alias 별칭이름을 사용할 수 있지만 where 절과 having절은 별칭 사용불가

-- group by 절에서 컬럼이 2개 이상 일 때 ---> 두 컬럼에 걸쳐서 동일한 내용을 그룹핑함
        -- job , dno

select job, dno from employee
order by job asc;

select dno , job ,sum (salary) 합계 , count(*)
from employee
group by job , dno ;

-- 각 직책(job)에 대해서 월급의 합계 , 평균, 최대값 , 최소값, 카운트 수를 출력하되 입사일이 81년도 입사한 사원들만 적용
-- 월급의 평균이 1500만원 이상만 출력하되 평균을 내림차순 정렬

select job 직책 , sum (salary) 합계, round (avg( salary)) 평균  , max (salary) 최대값 , min (salary) 최소값 , count (job) 카운트수
from employee
where substr (hiredate , 1 , 2 ) = '81'        -- substr (hiredate , 1 , 2 ) = '81' = hiredate like '81%'
group by  job 
having round (avg( salary)) >= 1500
order by 평균 desc ;

/*
★ group by 절에서 사용되는 키워드
    - rollup :  group by 컬럼   --> 결과 마지막 라인에 전체 결과를 한 번 더 출력
    - cube :  그룹핑 마지막 라인에 결과 출력 , 마지막 라인에 전체 결과도 세부적으로 출력
*/

-- 1.  rollup , cube 키워드를 사용하지 않는 경우 : 그룹핑한 결과만 출력

    select dno, job , count(*) , sum(salary), round(avg(salary) , 2 ) , max (salary) , min (salary)
    from employee
    group by dno , job
    order by count(*) desc;
  
     select dno , job
     from employee
     order by job asc ;
     
-- 2. roll up 키워드를 사용하는 경우 : 그룹핑한 결과 출력, 전체 내용도 출력

    select dno, job , count(*) , sum(salary), round(avg(salary) , 2 ) , max (salary) , min (salary)
    from employee
    group by rollup ( dno , job )
    order by count(*) desc;
    
   -- rollup이라는 키워드 사용 
   -- (null)(null)    -->  전체 레코드 수 출력(14) , 전체월급의 합..  
   -- 10(null)        -->   10 번 부서에 대한 전체 레코드 수 출력 (6) , 10번 부서의 전체월급의 합..
    
-- 3. cube 키워드를 사용하는 경우 : 그룹핑한 결과 출력, 전체 내용도 출력 , 세부 사항까지 출력
    
    select dno, job , count(*) , sum(salary), round(avg(salary) , 2 ) , max (salary) , min (salary)
    from employee
    group by cube ( dno , job )
    order by count(*) desc;

/*
★ SubQuery : select 문 내에 select 쿼리 
- 여러번의 작업을 한 구문에서 처리
- where 절에서 많이 사용
*/

-- ename [사원이름]이 SCOTT인 사원의 직책과 같은 사원들을 출력   -----> 2번 쿼리가 필요함

-- 1. SCOTT 사원의 직책을 알아오는 쿼리
    select job , ename
    from employee
    where ename = 'SCOTT';

-- 2. 알아온 직책을 조건으로 해서 이름을 출력
     select ename , job
     from employee
     where job = 'ANALYST';

-- SubQuery 를 사용해서 하나의 쿼리로 처리함

select ename , job
from employee
where job = (select job from employee where ename = 'ALLEN');       -- 안에 있는 select문은 = 을 사용했기 때문에 단일구문이어야 한다. ( 컬럼이 2개 이상 들어가면 안됨)

select ename , job
from employee
where job = (select job , ename from employee where ename = 'ALLEN');      -- 안에 있는 select 문에 컬럼이 2개 이기 때문에 오류

--  SCOTT 와  ALLEN의 직책에 해당되지 않는 사원들을 모두 출력
    -- 1. scott의 직책을 출력하는 쿼리
    -- 2. allen의 직책을 출력하는 쿼리
    --3. where  job not in ('scott 의 직책' , ' allen의 직책')

    -- 1. scott의 직책을 출력하는 쿼리
    select job  from employee where ename = 'SCOTT';       -->  ANALYST
    -- 2. allen의 직책을 출력하는 쿼리
    select job  from employee where ename = 'ALLEN';       -->  SALESMAN
    --3. where  job not in ('scott 의 직책' , ' allen의 직책')
    select ename, job
    from employee
    where job not in ( 'ANALYST' , 'SALESMAN' );

  -- subquery 로 한라인으로 출력
  
  -- " = " 사용  : 단일 구문 사용해야 한다.
    select ename, job
    from employee
    where job not in (
           (select job from employee where ename =  'SCOTT' ),
           (select job from employee where ename =  'ALLEN')
           );    
           
  -- " in " , " or"  사용 : 2개 이상의 구문 사용가능
    select ename, job                                                                   
    from employee
    where job not in (
            select job from employee 
            where ename =  'SCOTT'  or  ename =  'ALLEN'
           );
           
    -- " in " 사용 : 2개 이상의 구문 사용가능       
   select ename, job
   from employee
   where job not in (
           select job from employee 
           where ename in (  'SCOTT' ,  'ALLEN')
           );    

--  단일 값 : =
-- 여러개의 값 ; in


-- 'SCOTT' 보다 많은 월급을 받는 사원들 정보, 월급을 출력

select salary from employee where ename = 'SCOTT';     --  scott 의 월급

select ename 사원 , salary 월급 
from employee
where salary > (select salary from employee where ename = 'SCOTT')
;

-- 최소급여를 받는 사원의 이름, 담당업무 , 급여 출력
select  min (salary)  from employee ;              -- 최소급여 받는 사원

select ename, job ,salary  
from employee
where salary = ( select min  (salary)  from employee );

-- 부서별로 최소 급여를 받는 사원정보의 이름 , 직책 , 월급을 출력 , 부서번호는 오름차순, 월급은 내림차순  : group by , dno , min , in를 사용

select dno 부서번호 ,ename 이름, job 직책 ,  salary 월급
from employee
where salary  in  ( select  min ( salary) from employee group by dno)    -->  (  ) 안 : 각 부서별 최소월급의 select한 값을 출력
order by dno asc , salary desc;

-- subquery
-- 각 부서의 최소 급여가 30번 부서의 최소 급여보다 큰 부서를 출력 , 이름 , 직책 , 월급 , 부서번호 출력

select dno , count (*) , min(salary)  부서별최소월급
from employee
group by dno                    -- 부서번호가  동일한 값을 그룹핑
having min( salary ) > ( 
        -- 서브쿼리 : 30번 부서의 최소 월급
        select  min (salary)  from employee 
        where dno = '30'
        );

















