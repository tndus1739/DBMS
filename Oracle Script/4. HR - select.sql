
/*
    select : 테이블의 값을 검색할 때
    select 컬럼명 from 테이블명[뷰명]
    select * from employee;
*/
-- employee 테이블의 모든 컬럼을 출력하기
-- * : 모든 컬럼을 다 출력해라
select * from employee;  -- 중간에 공백있어도 상관없음 / ( ; 까지 한 단락)

-- 특정 컬럼만 출력하기
select eno,ename, job                  -- 한 컬럼이 끝나면 , 넣어주기  (eno : 사원번호)
from employee;

-- 특정 컬럼을 여러번 출력하기 , 컬럼에 연산 가능 (컬럼이름이 변경될 수 있다.)     -- 동일한 컬럼을 여러번 출력할 수 있다.
select eno, ename, salary, ename, ename, salary , salary * 12            -- salary * 12 : 연봉
from employee;

-- 컬럼 이름을 별칭으로 바구고 출력하기       -- 공백, 특수문자 있으면 ""로 묶어줌
select eno as 사원번호,ename 사원명, salary as 월급 , salary*12 as 연봉   
from employee;

-- as 넣어도 되고 안넣어도 됨 (컬럼이름 변경할 때  as  사용)
-- 마지막 컬럼은 , 넣으면 안됨


-- employee 테이블의 각 컬럼의 의미
select *
from employee;

select eno 사원번호 , ename 사원명 , job 직책 , manager 직속상관,           --as 생략가능 , 컬럼이름에 공백, 특수문자 들어가면 "" 로 묶어줘야 함
       hiredate 입사날짜 , salary 월급 , commission 보너스 , dno 부서번호   --  마지막은 , 넣지마
from employee;