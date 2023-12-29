create table member2 (
id varchar2 (50) not null primary key,
name varchar2(50) not null,
pass1 varchar2 (50) not null,
sex varchar2 (6) not null ,
hobby varchar (20) ,
nation varchar2 (20) default 082 ,
zone  number (5) default 010,
phone1 number (5) ,
phone2 number(5),
profile varchar2 (200)
);

select * from member2;

drop table member2 ;

select * from users; 
