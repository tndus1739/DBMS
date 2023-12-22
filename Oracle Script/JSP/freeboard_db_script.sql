    /* Oracle DB (XE)  �� */ 
--- �Խ��� ( ���� �亯�� �Խ��� ) 
Create Table freeboard (
    id number constraint PK_freeboard_id Primary Key,   -- �Խñ� ��ȣ
    name varchar2(100) not null, 
    password varchar2(100) not null, 		-- �ڽ��� ���� ������ 
    email varchar2(100) null, 
    subject varchar2(100) not null, 		-- ����
    content varchar2(2000) not null, 		-- �۳���
    inputdate varchar2(100) not null, 		-- �۾���¥
  
    -- �亯���� ó���ϴ� �÷� 
    masterid number default 0 , 
    readcount number default 0 , 			-- �� ��ȸ��
    replaynum number default 0 , 
    step number default 0
); 

select * from freeboard ; 
select * from freeboard order by id asc ; 


delete freeboard ;
commit ;

/* MSSQL  DB (myDB)  �� */ 
--- �Խ��� ( ���� �亯�� �Խ��� ) 
Create Table freeboard (
    id int constraint PK_freeboard_id Primary Key, 
    name varchar(100) not null, 
    password varchar(100) not null, 
    email varchar(100) null, 
    subject varchar(100) not null, 
    content varchar(2000) not null, 
    inputdate varchar(100) not null, 
    -- �亯���� ó���ϴ� �÷� 
    masterid int default 0 , 
    readcount int default 0 , 
    replaynum int default 0 , 
    step int default 0
); 

/* MY-SQL  DB (myDB)  �� */ 
Create Table freeboard (
    id int ,
    constraint PK_freeboard_id Primary Key (id) , 
    name varchar(100) not null, 
    password varchar(100) not null, 
    email varchar(100) null, 
    subject varchar(100) not null, 
    content varchar(2000) not null, 
    inputdate varchar(100) not null, 
    -- �亯���� ó���ϴ� �÷� 
    masterid int default 0 , 
    readcount int default 0 , 
    replaynum int default 0 , 
    step int default 0
); 



select * from freeboard; 

