select * from tb_customer_data;
select * from tb_product_info;
select * from tb_order_details;

-- Q. Fetch the order summary (to be given to client/vendor)
create or replace view order_summary
as
select o.ord_id,o.date,p.prod_name,c.cust_name,
(p.price*o.quantity) - ((p.price*o.quantity)*disc_percent::float/100) as cost
from tb_customer_data c
join tb_order_details o on o.cust_id = c.cust_id
join tb_product_info p on p.prod_id = o.prod_id;

select * from order_summary;

-- why we use the views in sql , main purpose of view
/*1)security :- By hiding the query used to generate the view.
2)Simplify complex sql queries - 1.sharing a view is better than sharing complex query,
								 2.avoiding re writing same complex query multiple times.	*/

-- performing security 
create role james
login
password 'Bambam@6202';
grant select on order_summary to james;

-- we can also change the structure or views like table
alter view order_summary rename column date to order_date;



-- create view for product table
create view expensive_products
as
select * from tb_product_info where price > 1000;

select * from expensive_products;
alter table tb_product_info add column prod_config varchar(100);


-- Updatable views
create or replace view expensive_products
as
select * from tb_product_info;

select * from expensive_products;
update expensive_products
set prod_name = 'Airpods Pro', brand = 'Apple'
where prod_id = 'P10';


-- some points to how to updatable views
/* 1) view query formed using just 1 table/view.
2) view query cannot have DISTINCT clause.
3) view query cannot have GROUP BY clause.If query contain group by then cannot update such views.	

create view order_count
as
select date, count(1) as no_of_order
from tb_order_details
group by date;

select * from order_count;

update order_count
set no_of_order = 0
where date = '2020-06-01';

4)if query contains WITH clause then cannot update such views.
5)if query contains window function then cannot update such views.	*/


-- WITH CHECK OPTION
create or replace view apple_products
as 
select * from tb_product_info where brand = 'apple'
with check option;

insert into apple_products
values ('P22','Note 22','apple',2500,null);

select * from apple_products;
select * from tb_product_info;
