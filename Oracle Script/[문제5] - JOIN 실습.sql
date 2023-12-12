/*
      [ JOIN �ǽ� ]
      
      member10 : ȸ�������� �����ϴ� ���̺�
      zipcode10 : �����ȣ�� �����ϴ� ���̺�
      product10 : ��ǰ������ �����ϴ� ���̺�
      order10 : �ֹ� ������ �����ϴ� ���̺�
*/

-- ���̺� ����
-- Foreign Key�� �����ϴ� ���̺��� ���� ���� �ʴ´�. : cascade constraints
-- 1) �����ϴ� ���̺��� ���� ���� �� �����ؾ� �Ѵ�.
-- 2) ���̺� ������ cascade constraints �ɼ��� ����ؼ� ���� ����

-- Member10 ���̺��� �����ϰ� �ֱ� ������ zipcode10 ���̺��� �����ϸ� �����߻�
drop table zipcode10 ;

--Order10 ���̺��� �����ϱ� ������ ���� �Ұ� 
drop table member10 ;

-- select * from user_constraints where table_name = 'MEMBER10' ; 
drop table order10 ;
drop table product10 ;

-- ���̺� ���� ��  cascade constraints �ɼ��� ����ؼ� ���� ����
    -- zipcode10 ���̺��� ������  ������.

drop table zipcode10 cascade constraints ;
drop table member10 cascade constraints ;
drop table order10 cascade constraints ;
drop table product10 cascade constraints ;

create table zipcode10 (
        zipcode number (6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key,         -- Primary key : �ߺ��� �� ���Ұ�
        si_do varchar2 (200) not null,                                                                                            -- constraint PK_ZIPCODE10_ZIPCODE �������� �̸� �������� 
        gu_gun varchar2 (200) not null,                                                                                         -- but , �������ϴ°� ���� ( ���߿� �������� �� ������ �ľ�)
        bungi varchar2 (200) not null
        );
        
create table member10 (
        m_id number (4) not null constraint PK_MEMBER10_M_ID Primary key,         -- Primary key : �ߺ��� �� ���Ұ�
        pass varchar2 (200) not null,
        name varchar2 (200) not null,
        email varchar2 (200) not null ,
        zipcode number (6) null,
        -- Foreign Key �������� �߰��� : member10(zipcode) ---> zipcode10(zipcode)
            constraint FK_MEMBER10_ZIPCODE foreign key (zipcode) references ZIPCODE10 (zipcode)
        );
        
 create table product10 (
        pro_id number (6) not null constraint PK_PRODUCT10_PRO_ID Primary key,         -- Primary key : �ߺ��� �� ���Ұ�
        pro_name varchar2 (200) not null,
        pro_price number (7,2) not null,
        pro_cnt number (4) default 0  not null           -- ���� ���� �� �⺻������ 0�� �ִ´�.
        );
               
 create table order10 (
        ord_id number (6) not null constraint PK_ORDER10_ORD_ID Primary key,         -- Primary key : �ߺ��� �� ���Ұ�
        m_id number (4) not null,                                -- FK : MEMBER10 (m_id)
        pro_id number (6)  not null ,                            -- FK : PRODUCT10 (pro_id)
       -- Foreign Key 2��
       constraint FK_ORDER10_M_ID foreign key (m_id) references member10 (m_id),
       constraint FK_ORDER10_PRO_ID foreign key (pro_id) references product10 (pro_id)
      );       
    
    -- �� ���̺� ���ڵ� 5���� �ֱ� ( 4���� ���̺� join)
    
    -- ANSI JOIN ���� ����ؼ� �ֹ�����  (order10)���̺��� ����
    -- �ֹ��ڸ�, �ֹ��� �����ּ� , �ֹ��ڹ��� ( �õ�) , �ֹ���ǰ�� , ��ǰ�� ������ ���
    -- order10 , member10 , zipcode10 , product10
    
    -- zipcode10 ���̺�
    desc zipcode10 ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  1 , '�����' , '���α�' , '100����' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  2 , '�����' , '���α�' , '200����' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  3 , '��⵵' , '���ֽ�' , '300����' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  4 , '�����' , '������' , '400����' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  5 , '��⵵' , '����' , '500����' ) ;
    commit ;
    
    -- Member10 ���̺��� ���� ���� ������ zipcode10 ���̺��� ������    --> RIGHT OUTER JOIN
    
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  6 , '�����' , '������' , '600����' ) ;
    insert into zipcode10 (zipcode , si_do , gu_gun , bungi )
    values (  7 , '��⵵' , '�ϻ꼭��' , '700����' ) ;
    commit ;
    
    -- member10 ���̺�
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  1001 , 'tndus1739' , '�̼���' , 'shtn888@naver.com'  ,  '1' ) ;
     insert into member10 (m_id , pass , name , email , zipcode )
    values (  2002 , 'huhu1898' , '���̰�' , 'ooo5665@gmail.com'  ,  '2' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  3003 , 'shtn2266' , '����' , 'sh1234@naver.com'  ,  '3' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  4004 , 'gisd90987' , '����ȣ' , 'koko7767@gmial.com'  ,  '4' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  5005 , 'oooo8938' , 'ȫ����' , 'ddp0987@naver.com'  ,  null ) ;
    commit ; 
    -- member10 ���̺��� ���������� �ֹ��������� ���� ȸ�� �߰� �Է�  --> LEFT OUTER JOIN
    
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  6006 , 'jkjk987' , '�̼�ȣ' , 'kohj8867@gmial.com'  ,  '4' ) ;
    insert into member10 (m_id , pass , name , email , zipcode )
    values (  7007 , 'ooss1138' , '�̹̰�' , 'ddpx2287@naver.com'  ,  '5' ) ;
    commit ; 
    
     -- product10 ���̺�  
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
    
    -- �ֹ��������� ���� ��ǰ ( �ֹ����� �ʴ� ��ǰ) ---> RIGHT OUTER JOIN
     insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1601 , 'Shoes' , 50.00 , 2 ) ; 
     insert into product10 (pro_id ,  pro_name , pro_price ,  pro_cnt  )
    values (  1771 , 'Iphone plus' , 180.00 , 3 ) ;
    commit ;     
    
    
    -- order10 ���̺�
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
     -- ANSI JOIN ���� ����ؼ� �ֹ�����  (order10)���̺��� ����
    -- �ֹ��ڸ�, �ֹ��� �����ּ� , �ֹ��ڹ��� ( �õ�) , �ֹ���ǰ�� , ��ǰ�� ������ ���
    -- order10 , member10 , zipcode10 , product10
    
    select * from order10 ;
    select * from member10 ;
    select * from zipcode10 ;
    select * from product10 ;
    
    select name �ֹ��ڸ�, email "�ֹ��� �����ּ�" , bungi "�ֹ��ڹ���" ,  pro_name �ֹ���ǰ�� , pro_price ��ǰ����
    from zipcode10 z 
        join  member10 m 
          on   z.zipcode = m.zipcode 
        join order10  o
          on  o.m_id = m.m_id
        join product10  p
          on o.pro_id = p.pro_id ;
          
-- �𵨸� ���� �۴� �ֹ� ���̺�   --> order11 ���̺� (������ ������ ����)

create table order11 (
    o_id number(6) not null primary key ,      -- > �������� �̸��� �ȵ�
   
    m_name varchar2(200) not null ,               --  �ֹ��� �̸�         -- varchar2  : ������ ����
    m_phone  varchar2(200) not null ,             --  �ֹ��� �ڵ��� ��ȣ
    m_add varchar2(200) not null ,                  --  �ֹ����� ��� �ּ�
    m_email varchar2(200) null ,                      --  �ֹ����� ���� �ּ� 
    
    p_id number (6) not null ,                            --  ��ǰ ��ȣ
    p_name varchar2(200) not null ,                 --  ��ǰ �̸�
    p_price number(7,2) not null ,                    --  ��ǰ ����                     number(7,2) : ��ü 7�ڸ� �Ҽ��� 2�ڸ�
    p_cnt number (6) null                                   --  ��ǰ ����
    ) ;
    
    insert into order11 (o_id , m_name , m_phone , m_add , m_email , p_id ,p_name , p_price , p_cnt)
    values ( 10, 'ȫ�浿' , '010-7298-1173' , '����' ,'aaa@naver.com' , 100 , '���' , 25000 , 100 ) ;
    insert into order11 (o_id , m_name , m_phone , m_add , m_email , p_id ,p_name , p_price , p_cnt)
    values ( 20, '�̱浿' , '010-1234-1173' , '�λ�' ,'abbb@naver.com' , 200 , '����' , 30000 , 200 ) ;
    commit ;
    
    select * from
    order11 ;
    
    -- -----------------------------------------------------------------------------------------------------------------------------
/*
  �� JOIN : ANSI JOIN
        
        - INNER JOIN : on���� ������ ���� ���
        - LEFT OUTER JOIN : ���� ���̺��� ��� ���� ���
        - RIGHT OUTER JOIN : �������� ��� ���� ���
        
*/

-- member10 ( �� ) (�ڽ�)���̺�� zipcode10 ( 1 ) (�θ�)���̺�  --> " �� : 1 ���� " : member10���̺��� zipcode10 ���̺��� �����Ѵ�.

select * 
from member10 m
    join zipcode10 z
     on m.zipcode = z.zipcode ;
     
-- member10���� on���� ��Ī���� �ʴ��� ������ ���̺��� ��� ���� ��� : RIGHT OUTER JOIN     
 
 select *
 from member10 m
    right outer join zipcode10  z
    on m.zipcode = z.zipcode ;
     
-- �ֹ����̺� ( order10 ), �ֹ��� ���� ( member10 )   ----> on���� Ű�÷� : m_id

select *
from order10  o
    join member10 m
     on o.m_id = m.m_id;

-- �ֹ� ������ ���� ����� ��� (�ֹ����� ���� �����) : RIGHT OUTER JOIN
     
select *
from order10  o
    right outer join member10 m
     on o.m_id = m.m_id;   
     
select *
from member10 m
    left outer join order10  o
     on m.m_id  = o.m_id ;      

 -- 3�� ���̺� ���� : order10 , member10 , zipcode10
 
 select *
 from order10 o
    join member10 m
      on o.m_id = m.m_id
    join  zipcode10 z
      on m.zipcode = z.zipcode ;
      
-- 4�� ���̺� ���� : order10 , member10 , zipcode10 , product10

select *
from order10 o
    join member10 m
      on o.m_id = m.m_id
    join zipcode10 z
      on m.zipcode = z.zipcode
    join product10 p
      on o.pro_id = p.pro_id ;
     
-- �ֹ����� �ʴ� ����� ������ ��� , �Ǹŵ��� �ʴ� ��ǰ�� ��� ( OUTER JOIN ��� )    

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
      

                   