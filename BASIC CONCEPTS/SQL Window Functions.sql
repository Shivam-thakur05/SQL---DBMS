-- Window Functions : - row_number, rank, dense_rank, lead and lag
select * from employee;

select dept_name, max(salary) as max_salary
from employee
group by dept_name;

-- 1. OVER clause :- window functions to define a window or a subset of rows within a result set for which the function will be computed.
select e.*,
max(salary) over() as max_salary
from employee e;
-- partitioning of the result set into groups.
select e.*,
max(salary) over(partition by(dept_name)) as max_salary
from employee e;


-- 2. row_number :- assign a row number for every row
select e.*,
row_number() over() as rn
from employee e;
-- partitioning based on dept_name
select e.*,
row_number() over(partition by(dept_name)) as rn
from employee e;

-- Q Fetch the first 2 employees from each department to join the company.
select * from (
		select e.*,
		row_number() over(partition by(dept_name)) as rn
		from employee e) as x
where x.rn < 3;


/* 3. RANK :-The RANK() window function in SQL is used to assign a rank to each row in the result set based on the values
of specified columns. It is particularly useful when you want to determine the rank of a row relative to others
in the result set, according to certain criteria.*/

-- Q.fetch the top 2 employees in each department earning the max salary.
select e.*,
rank() over(partition by dept_name order by salary desc) as rnk
from employee e


select * from(
	select e.*,
	rank() over(partition by dept_name order by salary desc) as rnk
	from employee e) x
where x.rnk < 3;


/*4.DENSE RANK :-The DENSE_RANK() window function in SQL is similar to the RANK() function, but it assigns consecutive ranks
to rows without any gaps.It is particularly useful when you want to determine the rank of a row relative to others in the
result set. */
select e.*,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as DENSE_rnk
from employee e

select e.*,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as DENSE_rnk,
row_number() over(partition by(dept_name)) as rn
from employee e


/*5. The LEAD() and LAG() functions are window functions in SQL used to access data from subsequent rows (for LEAD())
and preceding rows (for LAG()), respectively, within the same result set, without using self-joins or subqueries. */

-- show the previous records
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prevv_emp_salary,
lead(salary) over (partition by dept_name order by emp_id) as next_emp_salary
from employee e;

select e.*,
lag(salary,2,0) over(partition by dept_name order by emp_id) as prevv_emp_salary
from employee e;


select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prevv_emp_salary,
case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
	 when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same as previous employee'
	 end sal_range
from employee e;












