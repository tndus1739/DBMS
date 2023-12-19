/*
    sequence : ������, �ڵ� ��ȣ �����
      - Ư�� �÷��� ��ȣ�� �ڵ����� ������.
      - ���� Ÿ���� �÷��� �����ؾ� ��.
      - user_sequences   <== ������ ������ Ȯ��
      - ������ ������ ����, �ڷδ� �ǵ��� �� ����, �ߺ��� ���� ��������� �ʴ´�.
      - �ڷ� �ǵ��� �� ���� ������ drop �ϰ� ���Ӱ� ������ �Ѵ�.
*/

-- 1. ������ ���� : ó�� �� 1, ���� �� : 1
create sequence seq1
    start with 1                     -- �ʱⰪ : 1
    increment by 1;                  -- ������ : 1
    
-- 2. �������� ������ Ȯ�� 
select * from user_sequences;

-- 3. ��� ���̺��� ����ؼ� sequence ���� Ȯ�� : 
select seq1.currval from dual;       -- ���� 2. ���� �������� ��ȣ Ȯ�� (currval = current values)
select seq1.nextval from dual;       -- ���� 1. ���� �������� ���� Ȯ�� (���� �۵����Ѿ� currval�� �۵���.)

-- 4. ���� insert �� Ư�� �÷��� sequence ����
create table abc (
    a int not null primary key,
    b varchar2(50),
    c varchar2(50)
    );
    
select * from abc;
    
insert into abc
values (seq1.nextval, '����','addr1');
commit;
select * from abc;
    