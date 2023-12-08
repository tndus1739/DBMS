/*  

�� �׷� �Լ� : group by , having

select �÷���
from ���̺�[��]
where ����
group by �÷��� [������ ���� �׷���]
(having  ���� [group by �� ��� ���� ����]    -- having ��������
order by �÷��� asc [desc]

�� ���� �Լ� : "number Ÿ��"�� �÷��� ���� �� ����     --> NULL�� �ڵ����� ó��
  SUM - �÷��� ��� ���� ��
  AVG - �÷��� ��հ�
  MAX - �÷��� �ִ밪
  MIN - �÷��� �ּҰ�
  COUNT (*) - �׷��ε� ���ڵ� �� ��� 
  
�� ���� : ���� ������ ����� �Ǳ� ������ �ٸ� �÷��� ���� ����
            ��, group by���� �׷��ε� �÷��� ����� �� �ִ�. 
*/
desc employee;

select sum(salary), salary              -->  ���� : ���� ������ ����� �Ǳ� ������ �ٸ� �÷��� ���� ����
from eemployee ;

-- �÷��� �Լ� ��� 
-- ���� (salary)
select sum (salary) �հ� , round(avg ( salary )  , 2) ��� , max ( salary ) �ִ밪 , min ( salary ) �ּҰ� , count (*) "���� ���ڵ� ��"
from employee;

-- ���� �Լ��� Null�� �ڵ����� ó����
select commission
from employee;

-- �÷��� �Լ� ��� (����)
select sum (commission) �հ� , round(avg ( commission )  , 2) ��� , max (commission) �ִ밪 , 
           min ( commission ) �ּҰ� , count (*) "���� ���ڵ� ��"
from employee;

-- �μ����� ������ �հ�, ���, �ִ���� , �ּҿ���, �׷��ε� ���� ���

select dno �μ���ȣ , sum(salary) �հ� , round (avg (salary))  ��� ,                                             --> �׷��ε� �÷��� ����� �� �ִ�. 
           max ( salary) �ִ밪 , min ( salary ) �ּҰ� , count (*) �׷��εȼ�
from employee
group by dno;                        -- DNO �÷��� ������ ���� �׷����ؼ� �����Լ��� ������

select salary , dno
from employee
order by dno asc;

-- ��å(job)���� ������ �հ�, ��� , �ִ밪, �ּҰ�, �׷��ε� ���� ���

select ename, job, salary
from employee
order by job;

select  job ��å, count (*) �׷��εȼ�, sum(salary) �հ� , 
            round (avg (salary))��� , max(salary) �ִ밪, min(salary) �ּҰ� 
from employee
group by job;                                                      -- job �÷��� ������ ���� �׷���



select count (*) ��ü���ڵ�� from employee;

/*

�� group by ������ where [����] vs having [����]
    where [����] : gruop by �ϱ� ���� ������ ������ , ��Ī�̸��� ����� �� ����.
    having [����] : group by �ؼ� ���� ����� ���� ���� , ��Ī�̸��� ����� �� ����.
    order by [�÷���] asc[desc] : ��Ī�̸��� ��밡��

*/
-- �������� �˾ƾ��Ѵ�.
-- ���޺��� ������ �հ� , ���, �ִ밪, �ּҰ� , �׷��ε� ���� ����ϵ� �μ���ȣ 20�� �����ϰ� , �μ����� ����� 2000�̻��� ���븸 ��� , ����� desc ���
select  job,  sum(salary) �հ� , round (avg (salary))��� , 
           max(salary) �ִ밪, min (salary) �ּҰ� , count (job) �׷��εȼ�       -- count�ȿ� * �־ �ǰ� job�־ �ȴ�.
           from employee
where dno <> 20        --> group by ���� ����                                    ��   where dno <> 20    =   where dno not in ( 20 )
group by job
having round (avg (salary)) >=2000 
order by round (avg (salary))  desc;                                                    -- order by �� alias ��Ī�̸��� ����� �� ������ where ���� having���� ��Ī ���Ұ�

-- group by ������ �÷��� 2�� �̻� �� �� ---> �� �÷��� ���ļ� ������ ������ �׷�����
        -- job , dno

select job, dno from employee
order by job asc;

select dno , job ,sum (salary) �հ� , count(*)
from employee
group by job , dno ;

-- �� ��å(job)�� ���ؼ� ������ �հ� , ���, �ִ밪 , �ּҰ�, ī��Ʈ ���� ����ϵ� �Ի����� 81�⵵ �Ի��� ����鸸 ����
-- ������ ����� 1500���� �̻� ����ϵ� ����� �������� ����

select job ��å , sum (salary) �հ�, round (avg( salary)) ���  , max (salary) �ִ밪 , min (salary) �ּҰ� , count (job) ī��Ʈ��
from employee
where substr (hiredate , 1 , 2 ) = '81'        -- substr (hiredate , 1 , 2 ) = '81' = hiredate like '81%'
group by  job 
having round (avg( salary)) >= 1500
order by ��� desc ;

/*
�� group by ������ ���Ǵ� Ű����
    - rollup :  group by �÷�   --> ��� ������ ���ο� ��ü ����� �� �� �� ���
    - cube :  �׷��� ������ ���ο� ��� ��� , ������ ���ο� ��ü ����� ���������� ���
*/

-- 1.  rollup , cube Ű���带 ������� �ʴ� ��� : �׷����� ����� ���

    select dno, job , count(*) , sum(salary), round(avg(salary) , 2 ) , max (salary) , min (salary)
    from employee
    group by dno , job
    order by count(*) desc;
  
     select dno , job
     from employee
     order by job asc ;
     
-- 2. roll up Ű���带 ����ϴ� ��� : �׷����� ��� ���, ��ü ���뵵 ���

    select dno, job , count(*) , sum(salary), round(avg(salary) , 2 ) , max (salary) , min (salary)
    from employee
    group by rollup ( dno , job )
    order by count(*) desc;
    
   -- rollup�̶�� Ű���� ��� 
   -- (null)(null)    -->  ��ü ���ڵ� �� ���(14) , ��ü������ ��..  
   -- 10(null)        -->   10 �� �μ��� ���� ��ü ���ڵ� �� ��� (6) , 10�� �μ��� ��ü������ ��..
    
-- 3. cube Ű���带 ����ϴ� ��� : �׷����� ��� ���, ��ü ���뵵 ��� , ���� ���ױ��� ���
    
    select dno, job , count(*) , sum(salary), round(avg(salary) , 2 ) , max (salary) , min (salary)
    from employee
    group by cube ( dno , job )
    order by count(*) desc;

/*
�� SubQuery : select �� ���� select ���� 
- �������� �۾��� �� �������� ó��
- where ������ ���� ���
*/

-- ename [����̸�]�� SCOTT�� ����� ��å�� ���� ������� ���   -----> 2�� ������ �ʿ���

-- 1. SCOTT ����� ��å�� �˾ƿ��� ����
    select job , ename
    from employee
    where ename = 'SCOTT';

-- 2. �˾ƿ� ��å�� �������� �ؼ� �̸��� ���
     select ename , job
     from employee
     where job = 'ANALYST';

-- SubQuery �� ����ؼ� �ϳ��� ������ ó����

select ename , job
from employee
where job = (select job from employee where ename = 'ALLEN');       -- �ȿ� �ִ� select���� = �� ����߱� ������ ���ϱ����̾�� �Ѵ�. ( �÷��� 2�� �̻� ���� �ȵ�)

select ename , job
from employee
where job = (select job , ename from employee where ename = 'ALLEN');      -- �ȿ� �ִ� select ���� �÷��� 2�� �̱� ������ ����

--  SCOTT ��  ALLEN�� ��å�� �ش���� �ʴ� ������� ��� ���
    -- 1. scott�� ��å�� ����ϴ� ����
    -- 2. allen�� ��å�� ����ϴ� ����
    --3. where  job not in ('scott �� ��å' , ' allen�� ��å')

    -- 1. scott�� ��å�� ����ϴ� ����
    select job  from employee where ename = 'SCOTT';       -->  ANALYST
    -- 2. allen�� ��å�� ����ϴ� ����
    select job  from employee where ename = 'ALLEN';       -->  SALESMAN
    --3. where  job not in ('scott �� ��å' , ' allen�� ��å')
    select ename, job
    from employee
    where job not in ( 'ANALYST' , 'SALESMAN' );

  -- subquery �� �Ѷ������� ���
  
  -- " = " ���  : ���� ���� ����ؾ� �Ѵ�.
    select ename, job
    from employee
    where job not in (
           (select job from employee where ename =  'SCOTT' ),
           (select job from employee where ename =  'ALLEN')
           );    
           
  -- " in " , " or"  ��� : 2�� �̻��� ���� ��밡��
    select ename, job                                                                   
    from employee
    where job not in (
            select job from employee 
            where ename =  'SCOTT'  or  ename =  'ALLEN'
           );
           
    -- " in " ��� : 2�� �̻��� ���� ��밡��       
   select ename, job
   from employee
   where job not in (
           select job from employee 
           where ename in (  'SCOTT' ,  'ALLEN')
           );    

--  ���� �� : =
-- �������� �� ; in


-- 'SCOTT' ���� ���� ������ �޴� ����� ����, ������ ���

select salary from employee where ename = 'SCOTT';     --  scott �� ����

select ename ��� , salary ���� 
from employee
where salary > (select salary from employee where ename = 'SCOTT')
;

-- �ּұ޿��� �޴� ����� �̸�, ������ , �޿� ���
select  min (salary)  from employee ;              -- �ּұ޿� �޴� ���

select ename, job ,salary  
from employee
where salary = ( select min  (salary)  from employee );

-- �μ����� �ּ� �޿��� �޴� ��������� �̸� , ��å , ������ ��� , �μ���ȣ�� ��������, ������ ��������  : group by , dno , min , in�� ���

select dno �μ���ȣ ,ename �̸�, job ��å ,  salary ����
from employee
where salary  in  ( select  min ( salary) from employee group by dno)    -->  (  ) �� : �� �μ��� �ּҿ����� select�� ���� ���
order by dno asc , salary desc;

-- subquery
-- �� �μ��� �ּ� �޿��� 30�� �μ��� �ּ� �޿����� ū �μ��� ��� , �̸� , ��å , ���� , �μ���ȣ ���

select dno , count (*) , min(salary)  �μ����ּҿ���
from employee
group by dno                    -- �μ���ȣ��  ������ ���� �׷���
having min( salary ) > ( 
        -- �������� : 30�� �μ��� �ּ� ����
        select  min (salary)  from employee 
        where dno = '30'
        );

















