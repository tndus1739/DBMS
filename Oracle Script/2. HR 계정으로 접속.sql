/*
    CRUD : Create, Read Update, Delete
            (����) (�˻�) (����)  ( ����)    

*/

-- ������ ���̺� ����
Create Table member (
    idx number not null ,
    name varchar2(50) not null,
    id varchar2(50) not null,
    pw varchar2(50) not null,
    addr varchar2(50) not null
   ) ;
    
-- �˻� : select
select * from member;

-- �Է� : ���̺꿡 ���� ����
insert into member ( idx, name , id , pw, addr)
values ( 1, 'ȫ�浿' ,'nsy' , '1234' , '����');

commit ;    -- DB�� ������ �����϶�


insert into member ( idx, name , id , pw, addr)
values ( 2, '��⵿' ,'nsy1' , '3334' , '�λ�');

commit ;    -- DB�� ������ �����϶�

--HR_���̺���� ���ֱ�

-- C##HR3 ������ �����ϰ�  HR3�������� ����, member ���̺� ���� �� ���ڵ� 2�� �ֱ�