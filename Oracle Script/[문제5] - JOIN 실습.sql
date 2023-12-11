/*
      [ JOIN 실습 ]
      
      member10 : 회원정보를 저장하는 테이블
      zipcode10 : 우편번호를 저장하는 테이블
      product10 : 제품정보를 저장하는 테이블
      order10 : 주문 정보를 저장하는 테이블
*/

create table zipcode10 (
        zipcode number (6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key,         -- Primary key : 중복된 값 허용불가
        si_do varchar2 (200) not null,
        gu_gun varchar2 (200) not null,
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
    values (  2 , '서울시' , '종로구' , '200번지' ) 
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  3 , '경기도' , '파주시' , '300번지' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  4 , '서울시' , '마포구' , '400번지' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  5 , '경기도' , '고양시' , '500번지' ) ;
    
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
    
    -- --------------------------------------------
     -- ANSI JOIN 문을 사용해서 주문정보  (order10)테이블을 기준
    -- 주문자명, 주문자 메일주소 , 주문자번지 ( 시도) , 주문제품명 , 제품의 가격을 출력
    -- order10 , member10 , zipcode10 , product10
    
    select * from order10 ;
    select * from member10 ;
    select * from zipcode10 ;
    select * from product10 ;
    
    select name 주문자명, email "주문자 메일주소" , bungi "주문자번지" ,  pro_name 주문제품명 , pro_price 제품가격
    from zipcode10 z join  member10 m 
    on   z.zipcode = m.zipcode 
              join order10  o
             on  o.m_id = m.m_id
             join product10  p
             on o.pro_id = p.pro_id ;