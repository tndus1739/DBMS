select * from board ;

-- title �÷����� �˻��ϴ� ����

select * from board
where title like '%?%' ;  -- �յڷ� � ���� �͵� ��� ����. 

-- write �÷����� �˻��ϴ� ����
select * from board
where write like '%?%' ; 

-- content �÷����� �˻��ϴ� ����
select * from board
where content like '%?%' ; 

-- regdate �÷����� �˻��ϴ� ���� 
select * from board
where  regdate like '%?%' ; 

select * from board
where cnt > 10 ;


-- -------------------------------


