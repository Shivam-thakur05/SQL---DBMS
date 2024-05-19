select *from product;

-- FIRST_VALUE
-- Write query to display the most expensive product under each category (corresponding to each record)
select *,
first_value(product_name) over (partition by product_catalog order by price desc) as most_exp_product
from product;

-- LAST_VALUE
-- Write query to display the least expensive product under each category (corresponding to each record)
select *,
first_value(product_name) over (partition by product_catalog order by price desc) as most_exp_product,
last_value(product_name) over (partition by product_catalog order by price desc) as least_exp_product
from product;


select *,
first_value(product_name) 
	over (partition by product_catalog order by price desc)
	as most_exp_product,
last_value(product_name)
	over (partition by product_catalog order by price desc
		 range between unbounded preceding and current row) --frame clause
	as least_exp_product
from product;
