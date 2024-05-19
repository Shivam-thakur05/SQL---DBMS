select * from employee;
select * from department;
select * from manager;
select * from projects;


-- join part 1
-- inner join/JOIN --
-- fetch the employee name and the department name they belong to. :
select e.emp_name,d.dept_name from 
employee e inner join department d 
on e.dept_id = d.dept_id;


-- left join = inner join + any additional record in the left table
-- fetch the all employee name and the department name they belong to. :
select e.emp_name,d.dept_name from 
employee e left join department d 
on e.dept_id = d.id;


-- right join = inner join + any additional record in the right table
-- fetch the all employee name and the department name they belong to. :
select e.emp_name,d.dept_name from 
employee e right join department d 
on e.dept_id = d.id;


-- fetch details of ALL emp, their manager, their department and proejcts they work on.
select e.emp_name,d.dept_name,m.manager_name ,p.project_name from
employee e left join department d 
on e.dept_id = d.id 
join manager m on
e.manager_id = m.manager_id
join projects p on
p.dept_id = e.dept_id;




-- join part 2
-- full join = INNER JOIN + all remaining records from table(return null value for any columns fetch)
-- 						  + all remaining records from right table (returns null value for any columns fetch)
select e.emp_name,d.dept_name from employee e
full join department d 
on d.id = e.dept_id;

-- CROSS JOIN 
-- CROSS JOIN returns cartesian product
select e.emp_name,d.dept_name from employee e
cross join department d;

select * from company  --when we cross join make sure the one table should contain only on e record

-- write a query to fetch the employee name and their corresponding department name also make 
-- sure to display the company name location corresponding to each employee.
select e.emp_name,d.dept_name,c.company_name,c.location from employee e
join department d on
e.dept_id = d.id
cross join company c;

-- NATURAL JOIN 
alter table department rename column id to dept_id;

select e.emp_name,d.dept_name
from employee e 
natural join department d;


-- SELF JOIN : join the table by itself
select * from family update family set age = 66 where member_id = 'F6';
-- write a query to fetch the child name and their age corresponding to their parent name and parent name

select child.name as child_name,child.age as child_age, parent.name as parent_name, parent.age as parent_age
from family as child
join family as parent on child.parent_id = parent.member_id;

