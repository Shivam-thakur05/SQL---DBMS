-- Syntax
WITH [RECURSIVE] CTE_name AS
	(
	SELECT query (Non Recursive query or the Base query)
		UNION [ALL]
	SELECT query (Recursive query using CTE_name [with a terminantion condition])
	)
SELECT * FROM CTE_name;

-- Queries:-
-- Q1. Display number from 1 to 10 without using any in built functions.
-- Q2. Find the hierarchy of employees under a given manager.
-- Q3. Find the hierarchy of managers for a given employee.


-- Q1. Display number from 1 to 10 without using any in built functions.
with recursive numbers as
	(select 1 as n
	 union 
	 select n+1 
	 from numbers where n<10
	 )
select * from numbers;

-- Q2. Find the hierarchy of employees under a given manager.

/*
create a table name emp_datails

create table emp_details(
id int,
name varchar(50),
manager_id int,
salary int,
designation varchar(50));

insert into emp_details values
(1,'Shripadh',null,10000,'CEO'),
(2,'Satya',5,1400,'Software Engineer'),
(3,'Jia',5,500,'Data Analyst'),
(4,'David',5,1800,'Manager'),
(5,'Michael',7,3000,'Architect'),
(6,'Arvind',7,2400,'Manager'),
(7,'Asha',1,4200,'CTO'),
(8,'Maryam',1,3500,'Manager'),
(9,'Reshma',8,2000,'Business Analyst'),
(10,'Akshay',8,2500,'Java developer'),
(11,'Suraj',3,1000,'CEO'),
(12,'Sagar',3,2000,'CTO');	*/

select * from emp_details;

WITH RECURSIVE emp_hierarchy AS (
    SELECT id, name, manager_id, designation, 1 as lvl
    FROM emp_details 
    WHERE name = 'Asha'
    UNION ALL
    SELECT E.id, E.name, E.manager_id, E.designation, H.lvl+1 as lvl
    FROM emp_hierarchy H
    JOIN emp_details E ON H.id = E.manager_id
)
-- SELECT * FROM emp_hierarchy;
select H2.id as emp_id, H2.name as emp_name, E2.name as manager_name, H2.lvl as level
from emp_hierarchy H2
join emp_details E2 on E2.id = H2.manager_id;


-- Q3. Find the hierarchy of managers for a given employee.

WITH RECURSIVE emp_hierarchy AS (
    SELECT id, name, manager_id, designation, 1 as lvl
    FROM emp_details 
    WHERE name = 'David'
    UNION ALL
    SELECT E.id, E.name, E.manager_id, E.designation, H.lvl+1 as lvl
    FROM emp_hierarchy H
    JOIN emp_details E ON H.manager_id = E.id
)
select H2.id as emp_id, H2.name as emp_name, E2.name as manager_name, H2.lvl as level
from emp_hierarchy H2
join emp_details E2 on E2.id = H2.manager_id order by level ;