/*
CREATE TABLE sales_data (
  sales_date date,
  customer_id varchar(30),
  amount varchar(50)
);

INSERT INTO sales_data (sales_date, customer_id, amount)
VALUES ('2021-01-01', 'Cust-1', '50$'),
       ('2021-01-02', 'Cust-1', '50$'),
       ('2021-01-03', 'Cust-1', '50$'),
       ('2021-01-01', 'Cust-2', '100$'),
       ('2021-01-02', 'Cust-2', '100$'),
       ('2021-01-03', 'Cust-2', '100$'),
       ('2021-02-01', 'Cust-2', '-100$'),
       ('2021-02-02', 'Cust-2', '-100$'),
       ('2021-02-03', 'Cust-2', '-100$'),
       ('2021-03-01', 'Cust-3', '1$'),
       ('2021-04-01', 'Cust-3', '1S'),
       ('2021-05-01', 'Cust-3', '1$'),
       ('2021-06-01', 'Cust-3', '1$'),
       ('2021-07-01', 'Cust-3', '-15'),
       ('2021-08-01', 'Cust-3', '-1$'),
       ('2021-09-01', 'Cust-3', '-1S'),
       ('2021-10-01', 'Cust-3', '-1$'),
       ('2021-11-01', 'Cust-3', '-15'),
       ('2021-12-01', 'Cust-3', '-15');		*/
	   

select * from sales_data;
create extension tablefunc;

SELECT 
    customer_id AS customer,
    TO_CHAR(sales_date, 'Mon-YY') AS sales_date,
    CAST(REPLACE(amount, '$', '') AS INT) AS amount
FROM sales_data;


select * from crosstab('SELECT 
    customer_id AS customer,
    TO_CHAR(sales_date, ''Mon-YY'') AS sales_date,
    CAST(REPLACE(amount, ''$'', '''') AS INT) AS amount
	FROM sales_data')
as(customer varchar,jan_21 int, feb_21 int,mar_21 int,apr_21 int,may_21 int,june_21 int,july_21 int,
  aug_21 int,sep_21 int,oct_21 int,nov_21 int,dec_21 int)