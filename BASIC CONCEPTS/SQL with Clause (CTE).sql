-- SQL CTE :- Common Table Expression(with clause)

-- Q1. fetch employees who earn more than average salary of all employees
select * from employee;

with avg_salary as 
		(select avg(salary) as avg_sal from employee)  
select * from
employee e, avg_salary av
where e.salary > av.avg_sal;

-- OR--

with avg_salary(avg_sal) as (select avg(salary) from employee)  
select * from
employee e, avg_salary av
where e.salary > av.avg_sal;

-- if we don't need decimal point (use cast function)

with avg_salary(avg_sal) as
		(select cast (avg(salary) as int) from employee)  
select * from
employee e, avg_salary av
where e.salary > av.avg_sal;


-- Q2. Find the sales who's sales where better than average sales accross all stores
/* we divide problem into different parts
1)total sales per each store	//total sales

		select s.store_id,sum(price) as total_sales_per_store
				from sales s
				group by s.store_id
				
2)find the average sales with respect all the stores	//avg_sales

	select cast(avg(total_sales_per_store)as int) as avg_sales_for_all_stores from (
				select s.store_id,sum(price) as total_sales_per_store
				from sales s
				group by s.store_id) x;

3)find the stores where total_sales > avg_sales of all stores		*/	
-- final answer
select * from (
				select s.store_id,sum(price) as total_sales_per_store
				from sales s
				group by s.store_id) total_sales
join 
			(select cast(avg(total_sales_per_store)as int) as avg_sales_for_all_stores
				from (select s.store_id, sum(price) as total_sales_per_store
					from sales s
					group by s.store_id)) avg_sales
					
on total_sales.total_sales_per_store > avg_sales.avg_sales_for_all_stores

-- using with clause

with total_Sales as (select s.store_id,sum(price) as total_sales_per_store
				from sales s
				group by s.store_id),
	avg_Sales as (select cast(avg(total_sales_per_store)as int) as avg_sales_for_all_stores
				from total_Sales) 
				
select * from total_Sales ts 
join avg_sales av					
on ts.total_sales_per_store > av.avg_sales_for_all_stores
















