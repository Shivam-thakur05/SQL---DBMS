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

-- Q. Find department who do not have any employees 
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