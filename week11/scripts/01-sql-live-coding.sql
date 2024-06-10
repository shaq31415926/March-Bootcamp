/*drop the table online_transactions_fixed*/
drop table online_transactions_fixed;



/*Querying the first 100 rows of table online transactions*/
select *
from online_transactions ot 
limit 100;

/*Querying the first ten rows of table stock description*/
select *
from stock_description sd 
limit 10;

/*Querying the customer_id and price column*/
select customer_id,
	   price
from online_transactions ot
limit 10;


/*How many rows does the online transaction table contain?*/
select count(*) as number_rows
from online_transactions;

/*How many rows does the stock description table contain?*/
select count(*) as number_rows
from stock_description;


/*How many customers do you have?*/
select distinct customer_id
from online_transactions ot; 

select count(distinct customer_id) as number_customers
from online_transactions ot; 


/*If you do not add distinct it will just count the number of rows or every appearance of customer id*/
select count(customer_id) as number_rows
from online_transactions ot; 
