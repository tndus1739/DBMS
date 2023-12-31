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

-- TRUNC : 특정 자리에서 잘라내 버림    --> 특정 날짜를 연산할 때 사용  (ex) 오늘 날짜에서 100 이후의 날짜가 언제인가?
select trunc ( 98.7654 ) T1,
           trunc ( 98.7654 , 2  ) T2,
           trunc ( 98.7654 , -1 ) T3,
           trunc ( 98.7654 , -2 ) T4
from dual ;        

-- MOD : 나머지 값만 출력  
-- MOD ( 인자 1 , 인자 2)
-- TRUNC : 몫만 출력할 때

select mod( 3 , 2) as "MOD 나머지만 출력" ,            -- 나머지만 출력
           trunc ( 31 / 2 )  as "TRUNC  몫만 출력"   -- 몫만 출력
from dual ;

/*
 ★ 날짜함수
 - sysdate : 현재 시스템의 날짜를 출력하는 함수
 - months_between : 두 날짜 사이의 개월 수를 출력
 - add_months : 툭정 날짜에서 개월수를 더해서 출력
 - next_day : 특정 날자에서 다음에 초래하는 요일을 인자로 받아서 도래하는 날짜를 출력
 - last_day  : 달의 마지막 날짜를 출력
 - round ( 날짜 ) : 날짜를 반올림 : 15일 이상 반올림 , 15일 미만 : 삭제
 - trunc  ( 날짜 )  : 날짜를 잘라내는 함수
*/

select sysdate from dual ;     -- 23/12/07 (현재 시스템의 날짜)

-- 날짜에 연산이 가능
select sysdate 현재날짜 , sysdate - 1 어제날짜 , sysdate + 1 내일날짜 from dual ;

-- 오늘에서 100일전 날짜
select sysdate - 100 "100일 전 날짜" from dual;

-- 오늘에서 1000일 후 날짜
select sysdate + 1000 "1000일 후 날짜" from dual;

-- 입사일에서 오늘날짜까지 총근무일수를 구함 ( 자료형이 date 타입의 컬럼이어야 함)  -> ( sysdate - hiredate)

desc employee;

-- 총근무일수 = trunc ( 오늘 날짜 - 입사날짜 )
select ename 이름, trunc(sysdate - hiredate ) 총근무일수            -- trunc 함수가 소수점 이하 다 자름
from employee;

-- 이름, 입사일 ,입사일에서부터 1000일 시점의 날짜를 출력
select ename 이름 , hiredate 입사날짜 , hiredate + 1000  "입사 후 1000일 날짜"
from employee;

-- 특정 날짜에서 월을 기준으로 출력 : TRUNC ( 날짜 , 'MONTH') , ROUND (날짜 , 'MONTH')
select hiredate 원본날짜, trunc ( hiredate, 'MONTH') , round( hiredate , 'MONTH') from employee;

-- 현재까지의 근무개월 수를 출력 : months_between ( 날짜 , 날짜 ) : 두 날짜 사이의 개월수 출력
select ename 이름 , hiredate 입사날짜 , trunc (months_between ( sysdate , hiredate )) "현재까지의 근무개월수" from employee ;

-- add_months :  특정날짜에서 몇개월 이후의 날짜를 출력
-- 오늘날짜에서 100개월 이후의 날짜 ( add_months 사용)  , 100일 후의 날짜   (  date 타입일 때 가능 )
select  sysdate 오늘날짜 , add_months (sysdate , 100) "100개월 후" , sysdate + 100 "100일 후의 날짜" from dual;    -- alias에서 숫자가 먼저나오면 "  " 로 묶어줘야 한다.

-- last_day : 그 날짜의 마지막 날짜를 출력함
select last_day (sysdate) from dual;

-- 모든 사원의 입사한 날의 마지막 날짜가 무엇인지 출력
select hiredate 입사날짜 , last_day( hiredate ) "입사한 날의 마지막 날짜" from employee;

/*
 ★★★형식 변환 함수
 
 -  TO_CHAR : 날짜형, 숫자형를 문자형으로 변환
 -  TO_DATE : 문자를 날짜형식으로 변환
 -  TO_NUMBER : 문자를 숫자형식으로 변환
 
*/

select sysdate from dual ;                                                                             -- 23/12/07 로 출력

-- YYYY : 년도 , MM : 월 , DD  : 일 , HH : 시간 , MI : 분 , SS : 초  , MON  : ( 1월 , 2월 , 3월 ... ) , DAY : 요일 (월요일, 화요일..) , DY (월, 화, 수 ...)       
-- 
select TO_CHAR (sysdate , 'YYYY-MM-DD HH : MI : SS') from dual;                

select hiredate 입사날짜 , TO_CHAR ( hiredate , 'YYYY-MM-DD  HH : MI : SS') 입사날짜2
from employee;

select hiredate 입사날짜 , TO_CHAR ( hiredate , 'YYYY"년"MM"월"DD"일"  HH"시" MI"분" SS"초"') 입사날짜2    -- 년 , 월, 일을 각 각  "  " 로 묶어주면 한글로 출력가능
from employee;

select TO_CHAR (sysdate, 'YYYY-MM-DD MON DAY DY HH : MI : SS') from dual ;




-- TO_CHAR : 숫자를 문자형으로 변환
/*
    0 : 자릿수를 처리함, 자릿수가 많으면 0으로 처리됨
    9 : 자릿수를 처리함, 자릿수가 많으면 공백으로 처리됨
    L : 각 지역의 통화를 기호로 표시함
    
    .  : 소수점으로 처리됨
    ,  : 천단위 구분자 

*/

select TO_CHAR (9876 , '000,000' ) from dual ;      --> 0은 자릿수를 나타냄
select TO_CHAR (9876 , '999,999' ) from dual ;
select TO_CHAR (9876 , 'L000,000' ) from dual ; 
select TO_CHAR (9876 , 'L999,999' ) from dual ;

select salary 월급 , to_char (salary , 'L999,999') "월급(한국)"
from employee;

-- TO_DATE : 문자 , 숫자를 날짜형식으로 바꿈
    -- 날짜 + 100 일
    -- months_between (날짜, 날짜) : 개월 수
    
select  to_date ('1998-10-10', 'yyyy-mm-dd')from dual;

-- 1981년 01월 01일에서 100일 지난 시점의 날짜 ,  100개월 지난 시점의 날짜 출력 , add_months (날짜 , 개월수) 사용

-- 1981년 01월 01일에서 100일 지난 시점의 날짜
select to_date ('1981/01/01', 'yyyy/mm/dd') + 100 "100일 후 날짜"  
from dual;

-- 1981년 01월 01일에서 100개월 지난 시점의 날짜
select  to_date ( add_months ( '1981-01-01' , 100), 'yyyy-mm-dd') from dual;
select  add_months (to_date ('1981-01-01' , 'yyyy-mm-dd'), 100)  from dual; 

-- 날짜타입으로 변환 
select to_date (810101, 'yymmdd' )   from dual ;

-- 자신의 생일에서 현재까지 몇 개월 살았는지 며칠 살았는지 출력 --> months_between ( 현재날짜, 생일) : 개월수
    -- sysdate - 생일 ( date )

select trunc( months_between( sysdate , to_date (19930108 , 'yyyymmdd') ) ) " 현재까지의 살아온 개월 수" ,
          trunc (sysdate - (to_date ('1993/01/08' ,'yyyy/mm/dd'))) " 현재까지 살아온 일수" 
from dual;


 select trunc (sysdate - to_date (19930108 ,'yyyymmdd')) " 현재까지 살아온 일수" from dual ;
 


