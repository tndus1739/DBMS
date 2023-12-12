create table tb_zipcode20 (
        zipcode varchar2 (7) not null constraint PK_tb_zipcode20_zipcode Primary key,        
        side varchar2 (30) null,                                                                                          
        gugun varchar2 (30)  null,                                                                         
        dong varchar2 (30) null, 
        bungi varchar2 (30) null
     
        );
drop table tb_zipcode20 ;

create table member20 (
        id varchar2 (20) not null constraint PK_member20_id Primary key,         -- Primary key : �ߺ��� �� ���Ұ�
        pwd varchar2 (20) null,                                                                                            -- constraint PK_ZIPCODE10_ZIPCODE �������� �̸� �������� 
        name varchar2 (50)  null,                                                                                         -- but , �������ϴ°� ���� ( ���߿� �������� �� ������ �ľ�)
        zipcode varchar2 (7) null,
        address varchar2 (20) null,
        tel varchar2 (13) null ,
        indate date default sysdate,
        constraint FK_MEMBER20_id_tb_zipcode20 foreign key (zipcode) references tb_zipcode20 (zipcode)
    
        );
        
        drop table member20;
        
create table products20 (
        product_code varchar2 (20) not null constraint PK_products20_products_code Primary key,        
        product_name varchar2 (100) null,                                                                                          
        product_kind char (1)  null,                                                                         
        product_price1 varchar2 (10) null, 
        product_price2 varchar2 (10) null,
       product_content varchar2 (1000) null,
       product_image varchar2 (50) null,
       sizeSt varchar2 (5) null,
       sizeEt varchar2 (5) null,
       products_quantity varchar2 (5) null,
       useyn char (1) null ,
       indate date 
        );        
       
      drop table products20 ;  
        
        
 create table orders20 (
        o_seq number (10) not null constraint PK_orders20_o_seq Primary key,        
        product_code varchar2 (20) null,                                                                                          
        id varchar2 (16)  null,                                                                         
        product_size varchar2 (5) null, 
        quantity varchar2 (5) null,
        result char (1),
        indate date,
       constraint FK_orders20_product_code_products foreign key (product_code) references products20 (product_code),
       constraint FK_orders20_id_member foreign key (id) references member20 (id)
        
        );
        
        drop table orders20 ;
        
  insert into tb_zipcode20 (zipcode, side ,gugun  , dong , bungi )
  values ( '1001' , '�����' , '������' , '������' , '100����'   );
  insert into tb_zipcode20 (zipcode, side ,gugun  , dong , bungi )
  values ( '1011' , '�����' , '������' , '������' , '200����'   );
  insert into tb_zipcode20 (zipcode, side ,gugun  , dong , bungi )
  values ( '1012' , '��⵵' , '���ֽ�' , '������' , '300����'   );
  insert into tb_zipcode20 (zipcode, side ,gugun  , dong , bungi )
  values ( '1013' , '�����' , '���α�' , '������' , '400����'   );
  insert into tb_zipcode20 (zipcode, side ,gugun  , dong , bungi )
  values ( '1014' , '��⵵' , '�ϻ굿��' , '������' , '500����'   );
  commit;
  
   insert into member20 (id , pwd , name , zipcode , address , tel , indate  )
  values ( 'aaaaa' , '1234' , 'ȫ�浿' , '1001' , '����� ������ '  , '010-0000-0000' , default );
   insert into member20 (id , pwd , name , zipcode , address , tel , indate  )
  values ( 'bbbbb' , '4567' , '�̱浿' , '1011' , '����� ���α� '  , '010-1111-1111' , default );
   insert into member20 (id , pwd , name , zipcode , address , tel , indate  )
  values ( 'ccccc' , '7890' , '��浿' , '1012' , '��⵵ ���ֽ� '  , '010-2222-2222' , default );
   insert into member20 (id , pwd , name , zipcode , address , tel , indate  )
  values ( 'ddddd' , '1173' , '���浿' , '1013' , '����� ���α� '  , '010-3333-3333' , default );
   insert into member20 (id , pwd , name , zipcode , address , tel , indate  )
  values ( 'eeeee' , '7410' , '��浿' , '1014' , '��⵵ ������ '  , '010-4444-4444' , default );
  commit;
  
    insert into products20 (product_code , product_name , product_kind , product_price1 , product_price2 , product_content , product_image ,  sizeSt , sizeEt , products_quantity , useyn , indate)
  values ( '1111' , 'iphone11' , 'p' , '150' , '300'  , '������' , 'phone' , '10' , '10' , '100 ' , 'y' , default );
   insert into products20 (product_code , product_name , product_kind , product_price1 , product_price2 , product_content , product_image ,  sizeSt , sizeEt , products_quantity , useyn , indate)
  values ( '2222' , 'iphone12' , 'p' , '150' , '300'  , '������' , 'phone' , '10' , '10' , '200 ' , 'y' , default );
   insert into products20 (product_code , product_name , product_kind , product_price1 , product_price2 , product_content , product_image ,  sizeSt , sizeEt , products_quantity , useyn , indate)
  values ( '3333' , 'iphone13' , 'p' , '150' , '300'  , '������' , 'phone' , '10' , '10' , '300 ' , 'n' , default );
   insert into products20 (product_code , product_name , product_kind , product_price1 , product_price2 , product_content , product_image ,  sizeSt , sizeEt , products_quantity , useyn , indate)
  values ( '4444' , 'iphone14' , 'p' , '150' , '300'  , '������' , 'phone' , '10' , '10' , '400 ' , 'n' , default );
  insert into products20 (product_code , product_name , product_kind , product_price1 , product_price2 , product_content , product_image ,  sizeSt , sizeEt , products_quantity , useyn , indate)
  values ( '5555' , 'iphone15' , 'p' , '150' , '300'  , '������' , 'phone' , '10' , '10' , '500 ' , 'n' , default );
 commit;
 
 
 insert into orders20 (o_seq , product_code , id ,product_size ,quantity , result , indate  )
  values ( '0001' , '1111' , 'aaaaa' , '1010' , '2'  , 'y' , default );
   insert into orders20 (o_seq , product_code , id ,product_size ,quantity , result , indate  )
  values ( '0002' , '2222' , 'bbbbb' , '2020' , '2'  , 'y' , default );
   insert into orders20 (o_seq , product_code , id ,product_size ,quantity , result , indate  )
  values ( '0003' , '3333' , 'ccccc' , '3030' , '3'  , 'n' , default );
   insert into orders20 (o_seq , product_code , id ,product_size ,quantity , result , indate  )
  values ( '0004' , '4444' , 'ddddd' , '4040' , '2'  , 'y' , default );
   insert into orders20 (o_seq , product_code , id ,product_size ,quantity , result , indate  )
  values ( '0005' , '5555' , 'eeeee' , '5050' , '4'  , 'n' , default );
   commit;


    create view vv_join
    as
    select   name �ֹ��ڼ���  , product_name ��ǰ�ڵ� , product_price1 �ǸŰ���
    from orders20 o 
            join member20 m
              on   o.id = m.id           
            join  tb_zipcode20 z
              on   m.zipcode = z.zipcode
            join products20 p
              on o.product_code = p.product_code ;
             
  select * 
  from member20;
    
        create view vv_join
    as
    select   name �ֹ��ڼ���  , z.zipcode �����ȣ  , m.indate �ֹ��� , product_price2 ��ǰ����
    from tb_zipcode20 z
            join member20 m
              on   m.zipcode = z.zipcode         
            join  orders20 o 
              on   o.id = m.id  
            join products20 p
              on o.product_code = p.product_code ;
                     
              
              
              
              