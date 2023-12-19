create table cde (
	 a int not null auto_increment primary key ,
	 b varchar(50),
	 c varchar(50)
	 );
	 
create sequence seq2
    start with 1 
    increment by 1 ;

SELECT * FROM user_sequences ;

select seq2.currval from dual ;             -- 현재 시퀀스의 번호 확인 (제일 처음 select seq1.currval from dual ; 실행시키면 오류)
select seq2.nextval from dual ;       

CREATE TABLE cde (
	c int NOT NULL PRIMARY KEY ,
	d varchar2 (50) ,
	e varchar2 (50)
	);

SELECT * FROM cde;
    
insert into cde
values (seq2.nextval ,  '뭐' , 'ㅇ') ;