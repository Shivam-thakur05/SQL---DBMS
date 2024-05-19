-- different Clause to use subquery like 
/*  Subquery with SELECT clause
	Subquery with FROM clause
	Subquery with WHERE clause
	Subquery with HAVING clause  */
	
-- Using subquery in SELECT clause
-- Q. Fetch all employee details and add remarks to those employees who earn more than the average pay.
select *
, (case when salary > (select avg(salary) from employee)
  		then 'Higher than average'
  		else null
  	end) as remarks
from employee;
-- this is not good practice to write query inside the select clause we can do alternate way
select *  
,(case when salary > avg_salary.sal
  		then 'Higher than average'
  		else null
  	end) as remarks
from employee
cross join (select avg(salary) sal from employee) as avg_salary;


-- Using subquery in HAVING clause
-- Q.Find the stores who have sold more units than the average units sold by all stores.
select store_name,sum(quantity)
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales);


-- Using subquery in INSERT clause
-- Q.Insert data to employee history table, Make sure not insert duplicate records.
select * from employee_history

insert into employee_history
select e.emp_id,e.emp_name,d.dept_name,e.salary,d.location
from employee e
join department d 
on d.dept_name = e.dept_name
where not exists(select 1
				from employee_history eh
				where eh.emp_id = e.emp_id);
				

-- Using subquery in UPDATE clause
/* Q.Give 10% increment to all employees in Banglore location based on the maximum salary earned by an emp in each dept.
Only consider employees in employee_history table. */
Update employee e
set salary = (select max(salary)+(max(salary)*0.1)
			  from employee_history eh
			  where eh.dept_name = e.dept_name)
where e.dept_name in (select dept_name
					 from department
					 where location='banglore')
and e.emp_id in (select emp_id from employee_history);


-- -- Using subquery in DELETE clause
-- Q. delete all department who do not have any employees.

delete from department
where dept_name in (select dept_name
				   from department d
				   where not exists(select 1 
									from employee e 
									where e.dept_name = d.dept_name)
				   )