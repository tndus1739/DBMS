/*
        Oracle의 다양한 함수 사용하기       ; 인풋 ---> 기능 ---> 결과
        1. 문자를 처리하는 함수
        2. 숫자를 처리하는 함수
        3. 날짜를 처리하는 함수
        4. 변환 함수
        5. 일반 함수

  ★  문자를 처리하는 함수 
  
   - UPPER : 소문자를 대문자로 변환해주는 함수
   - LOWER : 소문자로 처리해주는 함수
   - INITCAP : 첫 자만 대문자로 처리해주는 함수
   - LENGTH : 글자수를 반환 ( 한글자 당 ->  영문 : 1byte , 한글 : 1 byte )
   - LENGTHB : 글자수를 반환 ( 영문 :  영문 : 1byte , 한글 : 3 byte )
   - CONCAT : 문자열을 연결해주는 함수
   - SUBSTR : 글자를 잘라오는 함수
   - INSTR : 특정 문자의 위치값을 출력
   - LPAD : 글자 자릿수를 입력 받아서 나머지는 특정 기호로 채움 (왼쪽)
   - RPAD : 글자 자릿수를 입력 받아서 나머지는 특정 기호로 채움 (오른쪽)
   - RTRIM : 오른쪽의 공백 제거
   - LTRIM : 왼쪽의 공백 제거
   
   - dual : 가상의 테이블

*/

SELECT UPPER ('Oracle') from dual ;

select * from employee ;

select ename as 원본이름 , UPPER (ename)  대문자이름 , LOWER (ename)  소문자이름 , INITCAP(ename) "첫 자만 대문자" from employee;

-- 검색이 안됨 : 컬럼의 값은 대소문자를 구분
select *
from employee
where ename = 'smith';

select *
from employee
where ename = UPPER('smith');

select LENGTH ( 'Oracle mania' ) from dual ;         -- 12자리 (공백까지 포함)
select LENGTH ( '오라클 매니아') from dual ;            -- 7자리 ( 공백까지 포함)
select length ( 'Oracle mania' ) from dual ; 


select LENGTHB ( 'Oracle mania' ) from dual ;         -- 12자리 (공백까지 포함)
select LENGTHB ( '오라클 매니아') from dual ;            -- 19자리 ( 공백까지 포함)   -> 한글 1자 : 3byte ( UTF - 8 )

select ename 원본 , LENGTH ( ename) 글자수 from employee ;       --  그 컬럼의 글자수를 출력해줌
select ename 원본 , LENGTHB ( ename) 글자수 from employee ;

-- CONCAT : 문자열과 문자열을 연결해주는 함수
-- ||  : 컬럼을 연결해주는 연산자

select 'Oracle' ,  'Mania' from dual;

select concat ('Oracle' ,  'Mania')  as 연결됨  from dual;

select concat ( ename , job ) from employee;

select ename || job  from employee;

select   ename || '         '  ||    job  as "이름과 직책" from employee;       -- as 안 넣어도 되기는 하는데 안 넣으면 식별 어려움

-- SUBSTR : 문자를 잘라오는 함수 , substsr ( 컬럼 , 4 , 3 ) ---> 컬럼에 있는 문자열 중 4번째 자리에서 3글자를 잘라와서 출력

select substr ( 'Oracle Mania' , 4, 3)  from  dual;            --> index : 1번 부터 시작

select ename 원본이름 , substr ( ename , 2, 3 )  as 잘라온이름 from employee;

select * from employee;

-- employee 테이블에서 이름, 입사월만 출력 (SUBSTR 함수 사용)

select ename 사원이름 , substr ( hiredate , 4 , 2) as  입사월 from employee; 

-- employee 테이블에서 이름, 입사월만 출력 (SUBSTR 함수 사용 , 2월달에 입사한 사원만 출력)

select ename 사원이름 , substr ( hiredate , 4 , 2) as  입사월 from employee
where substr ( hiredate , 4 , 2) = '02' ; 

-- select ename 사원이름 , substr ( hiredate , 4 , 2) as  입사월 from employee        ---- 가상으로 만들어진 이름을 사용하면 오류발생
-- where 입사월 = '02' ; 

-- 81년도에 입사한 사원의 이름 , 입사년, 입사월, 입사일을 출력 ( substr, where 사용)

select ename 사원이름 , substr (hiredate , 1, 2 ) as 입사년 , substr (hiredate , 4, 2 ) as 입사월 , substr (hiredate , 7, 2 )  as 입사일
from employee
where  substr (hiredate , 1, 2) = 81;

 /* 
★  INSTR : 특정 문자의 index 번호를 출력  , index 번호는 1부터 시작
  - instr ( 컬럼명 , 'A' ) : 컬럼에서 문자열 중에서 'A' r가 있는 index 번호를 출력
  - instr ( 컬럼명 , 'A' , 4 ) : index 4번 부터 오른쪽을 A가 들어있는 index 번호를 출력
  - 검색 되지 않으면 0 으로 출력
*/

select ( instr ( 'Oracle Mania' , 'a' )) from dual ;    -- 3  : a가 위치한 index 번호

select ( instr ( 'Oracle Mania' , 'a' , 4 )) from dual ;  -- 9 : index 4번 이후부터 'a' 가 위치한 index 검색 ( 공백 포함)

select ename 이름 , instr ( ename , 'M')  as  M의위치
from employee;

/*
-- 중요한 데이터는 일부를 감추고 출력
★  LPAD : LPAD ( 컬럼명, 늘릴자릿수 , '*')  : 공백 자리에 * 을 채움 ( 왼쪽) 
★  RPAD : RPAD ( 컬럼명, 늘릴자릿수 , '*')  : 공백 자리에 * 을 채움 ( 오른쪽) 

*/
select '770824-123456' 주민번호 , lpad ( '770824-1' , 20 , '*')  as "LPAD" from dual;         -- 함수 뒤에 컬럼이름 설정할 때는 " " 로 묶어줘야함

select '770824-123456' 주민번호 , rpad ( '770824-1' , 20 , '*')  as "RPAD" from dual; 

select * from employee;

-- hiredate 컬럼을 년도만 출력하고 나머지는 *로 출력 ( substr, rpad 를 사용해서 처리)

select ename 이름 ,  rpad (substr ( hiredate , 1, 2), 8 , '*' )  as 입사년월일 
from employee;

/*
★ 공백 처리
- RTRIM : 오른쪽의 공백을 제거
- LTRIM : 왼쪽의 공백을 제거
- TRIM : 왼쪽, 오른쪽 공백을 모두 제거
*/

select '            Oracle Mania                '   as 원본  ,
        ltrim ('            Oracle Mania                ') 왼쪽의공백제거,
        rtrim('            Oracle Mania                ') 오른쪽의공백제거,
        trim('            Oracle Mania                ') 모든공백제거
from dual;

select * from employee
where ename = LTRIM( '    SMITH');

-- 앞 뒤 공백 제거 후 값을 대문자로 변환
select * 
from employee
where ename = upper ( trim ('    smith'));

/*
★ 숫자를 처리하는 함수 
- ROUND : 반올림하는 함수
- TRUNC : 특정자리수에서 잘라내어버림
- MOD : 나머지 값만 출력
*/

-- ROUND : 특정자릿수에서 반올림 ( 5이상은 반올림, 5미만은 잘라내서 버림)
/*
    ROUND (실수) : 소숫점 뒷자리에서 반올림
    ROUND (실수, 소수점자릿수) :
                - 소숫점 자리 (양수) : 소숫점 기준으로 오른쪽으로 이동해서 , 그 "뒷자리"에서 반올림됨   ----> ★주의
                - 수숫점 자리 (음수) : 소수점 기준으로 왼쪽으로 이동해서 , 그 "자리"에서 반올림됨
*/

select 98.7654 as 원본,
          round (98.7654)  as R1,                 -- 소숫점 뒤에서 반올림 (round 함수에 인자 없으면 정수 출력)
          round (98.7654, 2 )  as R2 ,           -- 소숫점 오른쪽으로 2자리 이동 후 그 뒤에서 반올림
          round (98.7654, -1 )  as  R3,         -- 소숫점 왼쪽으로 1자리 이동 후 그 자리에서 반올림
          round (98.7654, -2 )  as  R4,         -- 소숫점 왼쪽으로 2자리 이동 후 그 자리에서 반올림
          round (98.7654, -3 )  as  R5          -- 소숫점 왼쪽으로 3자리 이동 후 그 자리에서 반올림
from dual;

-- 근로 소득세 : 월급의 3.3  ( salary * 0.033 = 소득세 )
select salary 월급 , salary * 0.033 소득세  , round ( salary * 0.033) R1 , round ( (salary * 0.033) ,  2 )  R2,
           round (salary - ( salary * 0.033) , 2 ) 실수령액
from employee;

-- TRUNC : 특정 자리에서 잘라내 버림
select trunc ( 98.7654 ) T1,
           trunc ( 98.7654 , 2  ) T2,
           trunc ( 98.7654 , -1 ) T3,
           trunc ( 98.7654 , -2 ) T4
from dual ;        





