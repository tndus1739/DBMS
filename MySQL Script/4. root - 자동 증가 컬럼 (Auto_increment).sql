
-- 자동 증가 컬럼 : auto_increment , 초기값  : 1 , 증가값 : 1
-- MYSQL : identity
-- 오라클 : sequence

create table abc (                         
	a int not null auto_increment primary key,     -- a컬럼은 자동 증가되는 컬럼이라서 a컬럼에는 값 넣으면 안됨
	b varchar(50),
	c varchar(50)
	);

select * from abc;

-- MYSQL에서는 컬럼을 명시해야한다 (자 동 증가 컬럼인 a는 명시 안해도 됨)
insert into abc (b,c)
values( '서울' , 'add1');
