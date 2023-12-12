/*
      [ JOIN 실습 ]
      
      member10 : 회원정보를 저장하는 테이블
      zipcode10 : 우편번호를 저장하는 테이블
      product10 : 제품정보를 저장하는 테이블
      order10 : 주문 정보를 저장하는 테이블
*/

-- 테이블 삭제
-- Foreign Key가 참조하는 테이블을 삭제 되지 않는다. : cascade constraints
-- 1) 참조하는 테이블을 먼저 삭제 후 삭제해야 한다.
-- 2) 테이블 삭제시 cascade constraints 옵션을 사용해서 강제 삭제

-- Member10 테이블에서 참조하고 있기 때문에 zipcode10 테이블을 삭제하면 오류발생
drop table zipcode10 ;

--Order10 테이블에서 참조하기 때문에 삭제 불가 
drop table member10 ;

-- select * from user_constraints where table_name = 'MEMBER10' ; 
drop table order10 ;
drop table product10 ;

-- 테이블 삭제 시  cascade constraints 옵션을 사용해서 강제 삭제
    -- zipcode10 테이블을 강제로  삭제함.

drop table zipcode10 cascade constraints ;
drop table member10 cascade constraints ;
drop table order10 cascade constraints ;
drop table product10 cascade constraints ;

create table zipcode10 (
        zipcode number (6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key,         -- Primary key : 중복된 값 허용불가
        si_do varchar2 (200) not null,                                                                                            -- constraint PK_ZIPCODE10_ZIPCODE 제약조건 이름 생략가능 
        gu_gun varchar2 (200) not null,                                                                                         -- but , 생략안하는게 좋음 ( 나중에 오류났을 때 빠르게 파악)
        bungi varchar2 (200) not null
        );
        
create table member10 (
        m_id number (4) not null constraint PK_MEMBER10_M_ID Primary key,         -- Primary key : 중복된 값 허용불가
        pass varchar2 (200) not null,
        name varchar2 (200) not null,
        email varchar2 (200) not null ,
        zipcode number (6) null,
        -- Foreign Key 제약조건 추가함 : member10(zipcode) ---> zipcode10(zipcode)
            constraint FK_MEMBER10_ZIPCODE foreign key (zipcode) references ZIPCODE10 (zipcode)
        );
        
 create table product10 (
        pro_id number (6) not null constraint PK_PRODUCT10_PRO_ID Primary key,         -- Primary key : 중복된 값 허용불가
        pro_name varchar2 (200) not null,
        pro_price number (7,2) not null,
        pro_cnt number (4) default 0  not null           -- 값이 없을 때 기본값으로 0을 넣는다.
        );
               
 create table order10 (
        ord_id number (6) not null constraint PK_ORDER10_ORD_ID Primary key,         -- Primary key : 중복된 값 허용불가
        m_id number (4) not null,                                -- FK : MEMBER10 (m_id)
        pro_id number (6)  not null ,                            -- FK : PRODUCT10 (pro_id)
       -- Foreign Key 2개
       constraint FK_ORDER10_M_ID foreign key (m_id) references member10 (m_id),
       constraint FK_ORDER10_PRO_ID foreign key (pro_id) references product10 (pro_id)
      );       
    
    -- 각 테이블에 레코드 5개씩 넣기 ( 4개의 테이블 join)
    
    -- ANSI JOIN 문을 사용해서 주문정보  (order10)테이블을 기준
    -- 주문자명, 주문자 메일주소 , 주문자번지 ( 시도) , 주문제품명 , 제품의 가격을 출력
    -- order10 , member10 , zipcode10 , product10
    
    -- zipcode10 테이블
    desc zipcode10 ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  1 , '서울시' , '구로구' , '100번지' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  2 , '서울시' , '종로구' , '200번지' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  3 , '경기도' , '파주시' , '300번지' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  4 , '서울시' , '마포구' , '400번지' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  5 , '경기도' , '고양시' , '500번지' ) ;
    commit ;
    
    -- Member10 테이블에는 참조 되지 않지만 zipcode10 테이블에는 존재함    --> RIGHT OUTER JOIN
    
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  6 , '서울시' , '강남구' , '600번지' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  7 , '경기도' , '일산서구' , '700번지' ) ;
    commit ;
    
    -- member10 테이블
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  1001 , 'tndus1739' , '이수경' , 'shtn888@naver.com'  ,  '1' ) ;
     insert into member10 (m_id , pass , name , email , zipcode )
    values (  2002 , 'huhu1898' , '이이경' , 'ooo5665@gmail.com'  ,  '2' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  3003 , 'shtn2266' , '고나은' , 'sh1234@naver.com'  ,  '3' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  4004 , 'gisd90987' , '정준호' , 'koko7767@gmial.com'  ,  '4' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  5005 , 'oooo8938' , '홍진경' , 'ddp0987@naver.com'  ,  null ) ;
    commit ; 
    -- member10 테이블에는 존재하지만 주문정보에는 없는 회원 추가 입력  --> LEFT OUTER JOIN
    
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  6006 , 'jkjk987' , '이선호' , 'kohj8867@gmial.com'  ,  '4' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  7007 , 'ooss1138' , '이미경' , 'ddpx2287@naver.com'  ,  '5' ) ;
    commit ; 
    
     -- product10 테이블  
    insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1156 , 'MacBook' , 150.00 , 1  ) ;  
    insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1178 , 'TV' , 350.00, 1) ;       
    insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1215 , 'Iphone' , 135.00 , 3  ) ;
    insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1378 , 'Cap' , 21.00 , 4  ) ;
    insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1411 , 'Computer' , 270.00 , 2 ) ; 
     insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1501 , 'Iphone mini' , 111.00 , default ) ;
    commit ;     
    
    -- 주문정보에는 없는 제품 ( 주문되지 않는 제품) ---> RIGHT OUTER JOIN
     insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1601 , 'Shoes' , 50.00 , 2 ) ; 
     insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1771 , 'Iphone plus' , 180.00 , 3 ) ;
    commit ;     
    
    
    -- order10 테이블
    insert into order10 (ord_id ,  m_id , pro_id  )
    values (  245785 , 1001 ,1156 ) ; 
     insert into order10 (ord_id ,  m_id , pro_id  )
    values (  254879 , 2002 ,1156 ) ; 
    insert into order10 (ord_id ,  m_id , pro_id  )
    values (  310205 , 3003 ,1178 ) ;  
     insert into order10 (ord_id ,  m_id , pro_id  )
    values ( 315689 , 4004 ,1215 ) ;  
     insert into order10 (ord_id ,  m_id , pro_id  )
    values ( 325989 , 5005 ,1411 ) ;
    commit ;    
    
    -- ---------------------------------------------------------------------------------------------------------------------------
     -- ANSI JOIN 문을 사용해서 주문정보  (order10)테이블을 기준
    -- 주문자명, 주문자 메일주소 , 주문자번지 ( 시도) , 주문제품명 , 제품의 가격을 출력
    -- order10 , member10 , zipcode10 , product10
    
    select * from order10 ;
    select * from member10 ;
    select * from zipcode10 ;
    select * from product10 ;
    
    select name 주문자명, email "주문자 메일주소" , bungi "주문자번지" ,  pro_name 주문제품명 , pro_price 제품가격
    from zipcode10 z 
        join  member10 m 
          on   z.zipcode = m.zipcode 
        join order10  o
          on  o.m_id = m.m_id
        join product10  p
          on o.pro_id = p.pro_id ;
          
-- 모델링 되지 앟는 주문 테이블   --> order11 테이블 (설계의 안좋은 예시)

create table order11 (
    o_id number(6) not null primary key ,      -- > 제약조건 이름이 안들어감
   
    m_name varchar2(200) not null ,               --  주문자 이름         -- varchar2  : 성능이 향상됨
    m_phone  varchar2(200) not null ,             --  주문자 핸드폰 번호
    m_add varchar2(200) not null ,                  --  주문자의 배송 주소
    m_email varchar2(200) null ,                      --  주문자의 메일 주소 
    
    p_id number (6) not null ,                            --  제품 번호
    p_name varchar2(200) not null ,                 --  제품 이름
    p_price number(7,2) not null ,                    --  제품 가격                     number(7,2) : 전체 7자리 소수점 2자리
    p_cnt number (6) null                                   --  제품 수량
    ) ;
    
    insert into order11 (o_id , m_name , m_phone , m_add , m_email , p_id ,p_name , p_price , p_cnt)
    values ( 10, '홍길동' , '010-7298-1173' , '서울' ,'aaa@naver.com' , 100 , '사과' , 25000 , 100 ) ;
    insert into order11 (o_id , m_name , m_phone , m_add , m_email , p_id ,p_name , p_price , p_cnt)
    values ( 20, '이길동' , '010-1234-1173' , '부산' ,'abbb@naver.com' , 200 , '딸기' , 30000 , 200 ) ;
    commit ;
    
    select * from
    order11 ;
    
    -- -----------------------------------------------------------------------------------------------------------------------------
/*
  ★ JOIN : ANSI JOIN
        
        - INNER JOIN : on절에 공통의 값만 출력
        - LEFT OUTER JOIN : 왼쪽 테이블의 모든 내용 출력
        - RIGHT OUTER JOIN : 오른쪽의 모든 내용 출력
        
*/

-- member10 ( 다 ) (자식)테이블과 zipcode10 ( 1 ) (부모)테이블  --> " 다 : 1 관계 " : member10테이블이 zipcode10 테이블을 참조한다.

select * 
from member10 m
    join zipcode10 z
     on m.zipcode = z.zipcode ;
     
-- member10에는 on절에 매칭되지 않더라도 오른쪽 테이블의 모든 값을 출력 : RIGHT OUTER JOIN     
 
 select *
 from member10 m
    right outer join zipcode10  z
    on m.zipcode = z.zipcode ;
     
-- 주문테이블 ( order10 ), 주문자 정보 ( member10 )   ----> on절의 키컬럼 : m_id

select *
from order10  o
    join member10 m
     on o.m_id = m.m_id;

-- 주문 정보에 없는 사용자 출력 (주문하지 않은 사용자) : RIGHT OUTER JOIN
     
select *
from order10  o
    right outer join member10 m
     on o.m_id = m.m_id;   
     
select *
from member10 m
    left outer join order10  o
     on m.m_id  = o.m_id ;      

 -- 3개 테이블 조인 : order10 , member10 , zipcode10
 
 select *
 from order10 o
    join member10 m
      on o.m_id = m.m_id
    join  zipcode10 z
      on m.zipcode = z.zipcode ;
      
-- 4개 테이블 조인 : order10 , member10 , zipcode10 , product10

select *
from order10 o
    join member10 m
      on o.m_id = m.m_id
    join zipcode10 z
      on m.zipcode = z.zipcode
    join product10 p
      on o.pro_id = p.pro_id ;
     
-- 주문하지 않는 사용자 정보도 출력 , 판매되지 않는 제품도 출력 ( OUTER JOIN 사용 )    

select *
from order10 o
     join member10 m
      on o.m_id = m.m_id
    join zipcode10 z
      on m.zipcode = z.zipcode
    right outer join product10 p
      on o.pro_id = p.pro_id ;     
 
 -- LEFT OUTER JOIN
 
 select *
from  member10 m
    left outer join order10 o
      on m.m_id  =  o.m_id 
     join zipcode10 z
      on m.zipcode = z.zipcode
     left outer join product10 p
      on o.pro_id = p.pro_id ;     
      

                   