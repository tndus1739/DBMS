use myDB;      -- ���� ����

/*
	�� identity : �÷��� ���� ���� ���� �� �ڵ����� �����ǵ��� �ϴ� �÷� 
	- �÷��� ���� ���� ���� �� �ڵ����� ���� 1�� ��� ����   -- MSSQL���� ���
	- identity �÷�����  ���� ���� �ʴ´�.
	- �ʱⰪ : 1 , ������ : 1
	- �������� ( int , bigint)
	- primary key


*/

create table abc (    -- a�÷��� ������ �ȵ�
	a int not null identity primary key,
	b varchar(50),
	c varchar(50)
	);

	insert into abc
	values ( '����' , 'add1');    -- ��� �����ϸ� �ڵ����� ���� 1�� ������. identity (MSSQL������ �����.)

	select * from abc;

	use mydb;


