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

select * from freeboard 
order by id asc;

 create table testTb1 (
    id number (4) not null primary key ,
    name varchar2 (50) not null ,
    email varchar2 (200) null

 ) ;

select * from testTb1 order by id asc;
drop table testTb1 ;






















