create table guestboard (
	name varchar2(200),
	email varchar2(200),
	subject varchar2(200),
	content varchar2(200)
	);
    
    select * from guestboard ;
    insert into guestboard (name , email , subject , content ) 
    values ('나','aaa','sks','ssss ');
    
    delete  guestboard
    where name in ( 'ㅁ' , '마' , '뭐' , '88888888' , '18');
    
    
    commit;
    
    --  developer에서는 반드시 commit 필요
    -- commit을 안하면 commit 하기 전까지는 Lock 이 걸려있어서 다른 사용자가 접근을 할 수 없음
    insert into guestboard (name , email , subject , content ) 
    values ('88888888','o','s','ssss6');
    
    
        create table mem (
     name varchar2(200),
     age  varchar2(200),
     weight varchar2(200),
     addr varchar2(200),
     phone  varchar2(200)
     );

select * from mem;
select * from tab;

     create table soso (
     name varchar2(200),
     age  varchar2(200),
     weight varchar2(200),
     addr varchar2(200),
     phone  varchar2(200)
     );

select * from soso;
commit;
    drop table soso;