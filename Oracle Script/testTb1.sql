Create Table freeboard (
    id number constraint PK_freeboard_id Primary Key,   -- 게시글 번호
    name varchar2(100) not null, 
    password varchar2(100) not null, 		-- 자신의 글을 삭제시 
    email varchar2(100) null, 
    subject varchar2(100) not null, 		-- 제목
    content varchar2(2000) not null, 		-- 글내용
    inputdate varchar2(100) not null, 		-- 글쓴날짜
    -- 답변글을 처리하는 컬럼 
    masterid number default 0 , 
    readcount number default 0 , 			-- 글 조회수
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






















