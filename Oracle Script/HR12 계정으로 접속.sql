select * from board ;

-- title 컬럼으로 검색하는 쿼리

select * from board
where title like '%?%' ;  -- 앞뒤로 어떤 값이 와도 상관 없다. 

-- write 컬럼으로 검색하는 쿼리
select * from board
where write like '%?%' ; 

-- content 컬럼으로 검색하는 쿼리
select * from board
where content like '%?%' ; 

-- regdate 컬럼으로 검색하는 쿼리 
select * from board
where  regdate like '%?%' ; 

select * from board
where cnt > 10 ;


-- -------------------------------


