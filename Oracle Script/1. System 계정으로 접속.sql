
select * from help;
select * from redo_log;

-- SQL�� �ּ� : �����ּ�

/*
    ������ �ּ�
*/

/*
    �Ϲ� ������ ���� �� �Ϲ� �������� ���� : ���� ����, ���� �ο�
*/
-- ���𰡸� ������ ���� �� ��� ���� -> �� ���� �͸� ����

-- system�������� ������ ����â������ ������ ������ �� �ִ�.

-- 1. hr ������ ���� : Oracle 12 ���� �̻� ���� ���� ������ -> c##������ (�ʱ��ѹ��� ����)
    -- ������ : hr ��ȣ : 1234
    
create user C##HR20 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

-- 2. ������ ������ �ο��ϱ� : connect, resource ���� 

grant resource, connect to C##HR20;    -- grant : �ο��ϰڴ�.


-- system �������� HR�������� create view ������ �ο���

grant create view  to C##HR20;    -- HR ������ view�� ���� �� �ִ� ������ �ְڴ�,


-- 3. ���̺� �����̽����� ���뷮 �Ҵ�

alter user C##HR20 quota unlimited on USERS; -- user space�� ������ ����� �� �ֵ��� ��


--4. ���� ����
drop user C##HR4 cascade  -- cascade: ������ �����ϸ鼭 �� �ȿ� ��ü�� �ٸ� ��� �͵鵵 ����

-- �ٸ� ����� ���̺��� ���� ����

select * from  "C##HR"."ACCOUNT10" ;
