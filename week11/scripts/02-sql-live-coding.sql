/*first ten rows of the online transactions table*/
select *
from online_transactions ot 
limit 10;


/*select the distinct values of customer_id and country*/
select distinct customer_id,
	   Country
from online_transactions
limit 10;

/*first ten rows of the stock description*/
select *
from stock_description sd 
limit 10;


/* # of customers - 4,373 customers*/
select count(distinct customer_id) as number_customers
from online_transactions ot;

/* # of invoices - 25,900 invoices */
select count(distinct invoice) as number_invoices
from online_transactions;

/*first and last invoice*/
select min(invoice_date) as min_invoice_date,
	   max(invoice_date) as max_invoice_date
from online_transactions;

/* # of stocks that were sold - 4,070 items were sold*/
select count(distinct stock_code) as number_items
from online_transactions ot;

/* # of stock codes that have ? - 47 */
select count(stock_code) as number_stocks
from stock_description sd
where description = '?'; 

-- are you aware of the like condition?
select *
from stock_description sd
-- check if ? appears as a the last character
where description like '%?';

select *
from stock_description sd
-- check if ? appears as a the first character
where description like '?%';

select *
from stock_description sd
-- check if ? appears
where description like '%?%';

/* # of stocks in the stock description table - 3,905*/
-- WHY ARE WE GETTING DIFFERENT NUMBERS?
select count(distinct stock_code) as number_stocks
from stock_description sd;

select count(stock_code) as number_stocks
from stock_description sd;

-- stock description table is MESSY
-- 1. Descriptions contain ?
-- 2. There are duplicated stock codes
-- 3. We dont have all the stock codes that have been sold

-- most expensive product

select stock_code,
	   max(price)
from online_transactions ot
where Country = 'Australia';

select *
from stock_description sd 
where stock_code = 'POST';

-- average price 
SELECT round(avg(price), 2) as avg_price
from online_transactions ot 
where country = 'France';

-- number of customers
SELECT count(distinct customer_id) as number_customers
from online_transactions ot 
where country = 'United Kingdom';

-- total # of invoices
SELECT count(distinct invoice) as number_invoices
from online_transactions ot 
where country = 'Portugal';

-- total volume of sales
SELECT sum(quantity) as total_volume 
from online_transactions ot 
where country = 'Australia';

-- total revenue
select sum(price*quantity) as total_amount
from online_transactions ot 
where country = 'Australia';


select max(price) as most_expensive_price,
	   round(avg(price), 2) as avg_price,
	   count(distinct customer_id) as number_customers,
	   count(distinct invoice) as number_invoices,
	   sum(quantity) as total_volume
from online_transactions ot
where country in ('Australia', 'United Kingdom', 'Portugal', 'Germany')
;

--Number of transactions per country, defined by the number of rows
select Country,
	   count(*) as number_transactions
from online_transactions ot 
group by Country
order by number_transactions desc;


-- Number of customers per country
select country,
	   count(distinct customer_id) as number_customers
from online_transactions ot
group by country
order by number_customers desc
limit 5;

--This is a summary table of different metrics for every country
select country,
	   max(price) as most_expensive_price,
	   round(avg(price), 2) as avg_price,
	   count(distinct customer_id) as number_customers,
	   count(distinct invoice) as number_invoices,
	   sum(quantity) as total_volume
from online_transactions ot 
-- where country in ('Germany', 'Portugal', 'France', 'Australia', 'United Kingdom')
group by country
order by number_customers desc;

--Top 10 countries with highest average price
select country,
	   round(avg(price), 2) as avg_price
from online_transactions ot 
group by country
order by avg_price DESC
limit 10;

--Country with most customers
select country,
	   count(distinct customer_id) as number_customers
from online_transactions ot 
group by country 
order by number_customers DESC 
limit 1;


--Country with second most customers
select country,
	   count(distinct customer_id) as number_customers
from online_transactions ot 
group by country 
order by number_customers DESC 
limit 2;

select country,
	   count(distinct customer_id) as number_customers
from online_transactions ot
-- <> not equal
where country <> 'United Kingdom'
group by country 
order by number_customers DESC 
limit 1;


-- option 1: use a sub query
-- which country has the most customers
select country
from online_transactions ot 
group by country 
order by count(distinct customer_id) DESC 
limit 1;

select country,
	   count(distinct customer_id) as number_customers
from online_transactions ot
-- <> not equal
where country <> (select country
					from online_transactions ot 
					group by country 
					order by count(distinct customer_id) DESC 
					limit 1)
group by country 
order by number_customers DESC 
limit 1;

-- question: which country has the least amount of customers?
select country,
	   count(distinct customer_id)
from online_transactions ot 
group by country 
order by count(distinct customer_id)
limit 10;

-- option 2, use row number - we did not cover this in class
select country,
	   number_customers
from (
	select country,
		   count(distinct customer_id) as number_customers,
		   row_number() over (order by number_customers desc) as row_number
	from bootcamp.online_transactions ot 
	group by country
	order by number_customers desc)
where row_number = 2
;

-- option 3, rank the countries
select country,
	   count(distinct customer_id) as number_customers,
	   --rank() over (order by count(distinct customer_id) desc) as rank
	   dense_rank() over (order by count(distinct customer_id) desc) as rank
from online_transactions
group by country;
	
select country,
	   number_customers
from
(select country,
	   count(distinct customer_id) as number_customers,
	   --rank() over (order by count(distinct customer_id) desc) as rank
	   dense_rank() over (order by count(distinct customer_id) desc) as rank
from online_transactions
group by country)
where rank=2;

-- question: why is rank better than row number?
-- question: what is the difference between dense_rank and rank?


--customer that spent the most
select customer_id,
       country,
	   round(sum(quantity*price), 2) as total_order_amount
from online_transactions ot 
where customer_id <> ''
group by customer_id 
order by total_order_amount desc
limit 1;

-- challenge: identify top customers per country?



