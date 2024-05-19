 select * from department;
 select * from employee;

-- what is subquery? How does SQL process a statement containing sub-query?
-- Q. Find the employees who's salary is more than the average salary earned by all employees.

select avg(salary) from employee	--44166.666666666667

select * from employee where salary > 44166.666666666667	--without subquery	--not always correct in future
--using subquery
select * from employee	--outer query / main query
where salary > (select avg(salary) from employee);	--subquery / innerquery

--types of subquery
-- 1. Scalar subquery :- it always return 1 row and 1 column
select e.* from
employee e 
join (select avg(salary) as sal from employee) as avg_sal
on e.salary > avg_sal.sal;


-- 2. Multiple row subquery :- more then 1 row and column
-- Q. Find the employee who earn the highest salary in each department
select dept_name, max(salary)
from employee 
group by dept_name

select * from employee 
where (dept_name,salary) in (select dept_name, max(salary)
								from employee 
								group by dept_name);
								
--single column, multiple row subquery
-- Q. Find the department who do not have any employees
select * from 
department where
dept_name not in (select distinct dept_name from employee);



-- 3.Correlated Subquery : A subquery which is related to the outer query (without outer query inner can't execute).
-- Q. Find the employees in each department who earn more than the average salary in that department.
select * 
from employee e1 
where salary > (select avg(salary) from employee e2
			   where e2.dept_name = e1.dept_name);

-- Q. Find department who do not have any employees (example of subquery with where clause)
select * from department d
where not exists (select 1 from employee e 
				 where e.dept_name = d.dept_name);
				 
select 1 from employee e where e.dept_name = 'lakshya'		--additional line



-- 4. Nested Subquery : Subquery inside a subquery
select * from sales;
-- Q.Find stores who's sales where better than the average across all stores
/* we need to find
1)find the total sales for each store.
2)find avg sales for all the stores.
3)compare 1&2 */

select * from
	(select store_name,sum(price) as total_sales
	from sales group by store_name) sales
join(select avg(total_sales) as sales
	from (select store_name,sum(price) as total_sales
		 from sales
		 group by store_name) x )avg_sales
	on sales.total_sales > avg_sales.sales;

-- best way to write when write same query multiple times (example of subquery with from clause)
with sales as
	(select store_name,sum(price) as total_sales
	 from sales
	 group by store_name)
select * from sales
join (select avg(total_sales) as sales
	 from sales x) avg_sales
on sales.total_sales > avg_Sales.sales;


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


