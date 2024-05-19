-- join part 2
-- FULL JOIN = INNER JOIN + all remaining records from table(return null value for any columns fetch)
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