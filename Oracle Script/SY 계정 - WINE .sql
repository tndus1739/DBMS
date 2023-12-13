
-- 테이블 만들기

-- sale 테이블
create table sale ( 
sale_date date default sysdate  not null constraint PK_SALE_SALE_DATE primary key,
wine_code varchar2 (6) not null ,
mem_id varchar2 (30) not null,
sale_amount varchar2 (5) default 0 not null,
sale_price  varchar2 (6) default 0 not null,
sale_tot_price  varchar2 (15) default 0 not null,
constraint FK_SALE_WINE_WINE_CODE foreign key (wine_code) references wine (wine_code),
constraint FK_SALE_MEMBER_MEM_ID foreign key (mem_id) references member (mem_id)
);

-- member 테이블
create table member (
mem_id varchar2 (6)constraint PK_MEMBER_MEM_ID primary key,
mem_grade varchar2 (20)  ,
mem_pw varchar2 (20) not null,
mem_birth date default sysdate not null ,
mem_tel varchar2 (20),
mem_pt varchar2 (10) default 0  not null , 
constraint FK_MEMBER_GRADE_PT_RATE_MEM_GRADE foreign key ( mem_grade ) references grade_pt_rate ( mem_grade ) 
);

-- grade_pt_rate 테이블
create table grade_pt_rate (
mem_grade varchar2 (20) not null constraint PK_GRADE_PT_RATE_MEM_GRADE primary key,
grade_pt_rate number (3,2) 
);

-- today 테이블
create table today (
today_code varchar2(6) not null constraint PK_TODAY_TODAY_CODE primary key,
today_sens_value number(3),
today_intell_value number(3),
today_phy_value number(3)
);

--nation 테이블
create table nation (
nation_code varchar2(26) not null constraint PK_NATION_NAYION_CODE  primary key,
nation_name varchar2(50) not null
);

--wine 테이블
create table wine(
wine_code varchar2(26) not null constraint PK_WINE_WINE_CODE primary key,
wine_name  varchar2(100) not null ,
wine_url blob ,
nation_code varchar2(6) not null,
wine_type_code varchar2(6) not null,
wine_sugar_code number(2),
wine_price number (15) default 0  not null ,
wine_vintage date ,
theme_code varchar2(6),
today_code varchar2(6) ,
constraint FK_WINE_NATION_CODE foreign key (nation_code)  references nation (nation_code),
constraint FK_WINE_WINE_TYPE_WINE_TYPE_CODE foreign key (wine_type_code) references wine_type (wine_type_code),
constraint FK_WINE_THEME_THEME_CODE foreign key (theme_code) references theme (theme_code) ,
constraint FK_WINE_TODAY_TODAY_CODE foreign key (today_code) references today (today_code) 
);

-- theme 테이블
create table theme (
theme_code varchar2 (6) not null constraint PK_THEME_THEME_CODE primary key,
theme_name varchar2(50) not null
);

-- stock_management 테이블
create table stock_management  (
stock_code varchar2 (6) not null constraint PK_STOCK_MANAGEMENT_STOCK_CODE primary key,
wine_code  varchar2 (6) ,
manager_id  varchar2 (30),
ware_date date default sysdate not null ,
stock_amount number (5) default 0 ,
constraint FK_STOCK_MANAGEMENT_WINE_WINE_CODE foreign key (wine_code) references wine (wine_code) ,
constraint FK_STOCK_MANAGEMENT_MANAGER_MANAGER_ID foreign key (manager_id) references  "manager" (manager_id) 
);

--manager 테이블
create table "manager" (
manager_id varchar2 (30) not null constraint PK_MANAGER_MANAGER_ID primary key,
manager_pwd varchar2 (20) not null ,
manager_tel varchar2 (20) 
);

--wine_type 테이블
create table wine_type (
wine_type_code varchar2 (6) not null constraint PK_WINE_TYPE_WINE_TYPE_CODE primary key,
wine_type_name varchar2 (50) 
);

-- ---------------------------------------------------------------------------------------------------------------

-- 데이터 입력


-- sale 테이블

insert into sale (sale_date,wine_code ,  mem_id , sale_amount ,  sale_price , sale_tot_price )
values ( default , '0001' , 'mem-1' , '1000' , '202000' , '52000000'  ) ;
insert into sale (sale_date,wine_code ,  mem_id , sale_amount ,  sale_price , sale_tot_price )
values ( '22/07/07' , '0002' , 'mem-2' , '2000' , '202000' , '52000000'  ) ;
insert into sale (sale_date,wine_code ,  mem_id , sale_amount ,  sale_price , sale_tot_price )
values ( '23/01/01' , '0003' , 'mem-3' , '3000' , '202000' , '52000000'  ) ;
insert into sale (sale_date,wine_code ,  mem_id , sale_amount ,  sale_price , sale_tot_price )
values ( '20/10/10' , '0004' , 'mem-4' , '4000' , '202000' , '52000000'  ) ;
insert into sale (sale_date,wine_code ,  mem_id , sale_amount ,  sale_price , sale_tot_price )
values ( '21/11/13' , '0005' , 'mem-5' , '5000' , '202000' , '52000000'  ) ;

delete sale;

-- member 테이블
insert into member (mem_id , mem_grade , mem_pw ,  mem_birth , mem_tel , mem_pt )
values ( 'mem-1' , 'S' , '9876' , sysdate, '010-9874-8888' , '700000'  ) ;
insert into member (mem_id , mem_grade , mem_pw ,  mem_birth , mem_tel , mem_pt )
values ( 'mem-2' , 'A' , '9876' , '23/10/10', '010-9874-8888' , '80000'  ) ;
insert into member (mem_id , mem_grade , mem_pw ,  mem_birth , mem_tel , mem_pt )
values ( 'mem-3' , 'B' , '9876' , sysdate, '010-9874-2222' , '1000000'  ) ;
insert into member (mem_id , mem_grade , mem_pw ,  mem_birth , mem_tel , mem_pt )
values ( 'mem-4' , 'C' , '9876' , '23/11/10', '010-1111-8888' , '700000'  ) ;
insert into member (mem_id , mem_grade , mem_pw ,  mem_birth , mem_tel , mem_pt )
values ( 'mem-5' , 'D' , '9876' , sysdate, '010-9874-8888' , '4000'  ) ;

delete  member ;

-- grade_pt_rate 테이블
insert into grade_pt_rate (mem_grade ,grade_pt_rate )
values ( 'S' , 9.1 ) ;
insert into grade_pt_rate (mem_grade ,grade_pt_rate )
values ( 'A' , 8.2 ) ;
insert into grade_pt_rate (mem_grade ,grade_pt_rate )
values ( 'B' , 7 ) ;
insert into grade_pt_rate (mem_grade ,grade_pt_rate )
values ( 'C' , 7.9 ) ;
insert into grade_pt_rate (mem_grade ,grade_pt_rate )
values ( 'D' , 6.5 ) ;


-- today 테이블
insert into today (today_code ,today_sens_value , today_intell_value ,today_phy_value  )
values ( 'AAA' , 90 , 90 , 100) ;
insert into today (today_code ,today_sens_value , today_intell_value ,today_phy_value  )
values ( 'BBB' , 81 , 90 , 100) ;
insert into today (today_code ,today_sens_value , today_intell_value ,today_phy_value  )
values ( 'CCC' , 77 , 90 , 300) ;
insert into today (today_code ,today_sens_value , today_intell_value ,today_phy_value  )
values ( 'DDD' , 20 , 100 , 400) ;
insert into today (today_code ,today_sens_value , today_intell_value ,today_phy_value  )
values ( 'EEE' , 90 , 90 , 100) ;

delete today ;

--nation 테이블
insert into nation (nation_code ,nation_name )
values ( '1111' , 'KOREA' ) ;
insert into nation (nation_code ,nation_name )
values ( '2222' , 'AMERICA' ) ;
insert into nation (nation_code ,nation_name )
values ( '3333' , 'KOREA' ) ;
insert into nation (nation_code ,nation_name )
values ( '4444' , 'KOREA' ) ;
insert into nation (nation_code ,nation_name )
values ( '5555' , 'KOREA' ) ;

--wine 테이블

insert into wine  (wine_code ,wine_name, wine_url , nation_code , wine_type_code , wine_sugar_code , wine_price , wine_vintage , theme_code ,  today_code)
values ( '0001' , 'aa', UTL_RAW.CAST_TO_RAW('sdlfj') , '1111' , 'w-1' , 10 , 300000 , '23/11/02' ,   '010101' , 'AAA') ;
insert into wine  (wine_code ,wine_name, wine_url , nation_code , wine_type_code , wine_sugar_code , wine_price , wine_vintage , theme_code ,  today_code)
values ( '0002' , 'bb', UTL_RAW.CAST_TO_RAW('sdlfj') , '2222' , 'w-2' , 20 , 30000 , '93/12/02' ,   '020202' , 'BBB') ;
insert into wine  (wine_code ,wine_name, wine_url , nation_code , wine_type_code , wine_sugar_code , wine_price , wine_vintage , theme_code ,  today_code)
values ( '0003' , 'cc', UTL_RAW.CAST_TO_RAW('sdlfj') , '3333' , 'w-3' , 30 , 100000 , '84/10/31' ,   '030303' , 'CCC') ;
insert into wine  (wine_code ,wine_name, wine_url , nation_code , wine_type_code , wine_sugar_code , wine_price , wine_vintage , theme_code ,  today_code)
values ( '0004' , 'dd', UTL_RAW.CAST_TO_RAW('sdlfj') , '4444' , 'w-4' , 40 , 200000 , '78/11/02' ,   '040404' , 'DDD') ;
insert into wine  (wine_code ,wine_name, wine_url , nation_code , wine_type_code , wine_sugar_code , wine_price , wine_vintage , theme_code ,  today_code)
values ( '0005' , 'ee', UTL_RAW.CAST_TO_RAW('sdlfj') , '5555' , 'w-5' , 50 , 50000 , '65/11/22' ,   '050505' , 'EEE') ;

delete wine ;

-- theme 테이블
insert into theme (theme_code ,theme_name )
values ( '010101' , 'www' ) ;
insert into theme (theme_code ,theme_name )
values ( '020202' , 'ooo' ) ;
insert into theme (theme_code ,theme_name )
values ( '030303' , 'ppp' ) ;
insert into theme (theme_code ,theme_name )
values ( '040404' , 'sss' ) ;
insert into theme (theme_code ,theme_name )
values ( '050505' , 'qqq' ) ;



-- stock_management 테이블

insert into stock_management (stock_code ,wine_code,manager_id , ware_date , stock_amount)
values ( 's-1' , '0001' , 'm-1' , sysdate , 50 ) ;
insert into stock_management (stock_code ,wine_code,manager_id , ware_date , stock_amount)
values ( 's-2' , '0002' , 'm-2' , sysdate , default ) ;
insert into stock_management (stock_code ,wine_code,manager_id , ware_date , stock_amount)
values ( 's-3' , '0003' , 'm-3' , '23/12/01' , 50 ) ;
insert into stock_management (stock_code ,wine_code,manager_id , ware_date , stock_amount)
values ( 's-4' , '0004' , 'm-4' , sysdate , 100 ) ;
insert into stock_management (stock_code ,wine_code,manager_id , ware_date , stock_amount)
values ( 's-5' , '0005' , 'm-5' , sysdate , 90 ) ;

delete stock_management ;
--manager 테이블

insert into "manager" (manager_id , manager_pwd , manager_tel)
values ( 'm-1' , 'asasas', '010-000-1111' ) ;
insert into "manager" (manager_id , manager_pwd , manager_tel)
values ( 'm-2' , 'dfdfd', '010-111-1111' ) ;
insert into "manager" (manager_id , manager_pwd , manager_tel)
values ( 'm-3' , 'adddd', '010-222-1111' ) ;
insert into "manager" (manager_id , manager_pwd , manager_tel)
values ( 'm-4' , 'asasas', '010-333-1111' ) ;
insert into "manager" (manager_id , manager_pwd , manager_tel)
values ( 'm-5' , 'asasas', '010-444-1111' ) ;

--wine_type 테이블

insert into wine_type (wine_type_code ,wine_type_name )
values ( 'w-1' , 'wine1' ) ;
insert into wine_type (wine_type_code ,wine_type_name )
values ( 'w-2' , 'wine2' ) ;
insert into wine_type (wine_type_code ,wine_type_name )
values ( 'w-3' , 'wine3' ) ;
insert into wine_type (wine_type_code ,wine_type_name )
values ( 'w-4' , 'wine4' ) ;
insert into wine_type (wine_type_code ,wine_type_name )
values ( 'w-5' , 'wine5' ) ;

select  s.mem_id  아이디 , wine_name 와인이름 , w.wine_code 와인코드 , mem_tel 전화번호 , nation_name 국가이름 , theme_name 테마이름
from sale s
   join member m
   on s.mem_id = m.mem_id 
   join wine w
   on s.wine_code = w.wine_code
   join nation n
   on n.nation_code = w.nation_code 
   join theme t
   on t.theme_code = w.theme_code ;


