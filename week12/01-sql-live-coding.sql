-- first twenty rows
select *
from online_transactions ot 
limit 20;

-- first twenty rows
select *
from stock_description sd
limit 20;

-- number of rows
select count(*) as number_rows
from online_transactions ot;

-- number of rows, 3952
select count(*) as number_rows
from stock_description sd;

-- how many stocks does the stock description table have? 
-- 3,905
select count(distinct stock_code) as number_stocks
from stock_description sd;

-- how many stock codes have multiple descriptions or appearing multiple times?
select stock_code,
		   count(*) as number_descriptions
from stock_description sd 
group by stock_code
having count(*) > 1;


-- option 1, write a sub query
select count(*) as number_stocks
from (
	select stock_code,
		   count(*) as number_descriptions
	from stock_description sd 
	group by stock_code
	having count(*) > 1);

-- option 2, use common table expressions
with description_count as (
	select stock_code,
		   count(*) as number_descriptions
	from stock_description sd 
	group by stock_code
	having count(*) > 1)
select count(*) as number_stocks
from description_count;


-- why do these stock codes have multiple descriptions
select *
from stock_description sd 
where stock_code in (select stock_code
						from stock_description sd 
						group by stock_code
						having count(*) > 1);



-- how many stocks does the online description table have?
-- 4,070
select count(distinct stock_code) as number_stocks
from online_transactions ot;


-- how many transactions have the stock code POST?
select count(*) as number_transactions
from online_transactions ot
where stock_code = 'POST';

-- how many stock codes contain a letter?
-- may lame way of doing it 
select count(distinct stock_code)
from online_transactions ot
where (
UPPER(stock_code) like '%A%' OR
UPPER(stock_code) like '%B%' or
UPPER(stock_code) like '%C%' or
UPPER(stock_code) like '%D%' or
UPPER(stock_code) like '%E%' or
UPPER(stock_code) like '%F%' or
UPPER(stock_code) like '%G%' or
UPPER(stock_code) like '%H%' or
UPPER(stock_code) like '%I%' or
UPPER(stock_code) like '%J%' or
UPPER(stock_code) like '%K%' or
UPPER(stock_code) like '%L%' or
UPPER(stock_code) like '%M%' or
UPPER(stock_code) like '%N%' or
UPPER(stock_code) like '%O%' or
UPPER(stock_code) like '%P%' or
UPPER(stock_code) like '%Q%' or
UPPER(stock_code) like '%R%' or
UPPER(stock_code) like '%S%' or
UPPER(stock_code) like '%T%' or
UPPER(stock_code) like '%U%' or
UPPER(stock_code) like '%V%' or
UPPER(stock_code) like '%W%' or
UPPER(stock_code) like '%X%' or
UPPER(stock_code) like '%Y%' or
UPPER(stock_code) like '%Z%')
;

-- how many stock codes ARE JUST A LETTER?
select count(distinct stock_code)
from online_transactions ot
where stock_code like '_'
;

-- challenge, how to get it working with a pattern
-- WOOH, JUNYI!!
select count(distinct stock_code)
from online_transactions ot
where stock_code glob '*[A-Za-z]*'
;

-- question: top 20 best selling products in Germany
select stock_code,
	   sum(quantity) as product_sold
from online_transactions ot 
where country = 'Germany'
group by stock_code
order by sum(quantity) desc
limit 20;

select *
from stock_description sd 
where stock_code = '22326';


select stock_code,
	   sum(quantity) as product_sold
from online_transactions ot 
where country = 'United Kingdom'
group by stock_code
order by sum(quantity) desc
limit 20;

select *
from stock_description sd 
where stock_code = '22197';

-- write a query that left joins description to the online trans table

select ot.*,
	   sd.description 
from online_transactions ot 
left join stock_description sd on ot.stock_code = sd.stock_code
;

-- number of rows that the online transaction table contains - 541k 

select count(*) as number_rows
from online_transactions ot 
left join stock_description sd on ot.stock_code = sd.stock_code
;

-- why do we have more rows than the left table
select *
from online_transactions ot 
left join stock_description sd on ot.stock_code = sd.stock_code
where ot.stock_code = '16020C';


-- how could we solve this?!
select count(*)
from online_transactions ot 
left join (select *
		   from stock_description
		   where description <> '?') sd on ot.stock_code = sd.stock_code

;

-- write a query that does an inner join instead
select ot.*,
	   sd.description 
from online_transactions ot 
join stock_description sd on ot.stock_code = sd.stock_code;


-- how many rows does the inner join output have?
select count(*)
from online_transactions ot 
join stock_description sd on ot.stock_code = sd.stock_code;

-- in an ideal world, the stock description table would not contaon multiple descriptions
select count(*)
from online_transactions ot 
join (select *
		   from stock_description
		   where description <> '?') sd on ot.stock_code = sd.stock_code;


-- how many stock codes are missing??
select count(distinct ot.stock_code)
from online_transactions ot 
left join stock_description sd on ot.stock_code = sd.stock_code
where description is null;

-- list of stock code 
select distinct ot.stock_code
from online_transactions ot 
left join stock_description sd on ot.stock_code = sd.stock_code
where description is null;


-- best selling product
select stock_code,
	   sum(quantity)
from online_transactions ot 
group by stock_code 
order by sum(quantity) DESC 
limit 20;

select ot.stock_code,
	   sd.description,
	   sum(quantity)
from online_transactions ot 
left join stock_description sd on ot.stock_code = sd.stock_code
group by ot.stock_code, sd.description  
order by sum(quantity) DESC 
limit 20;



select sd.description,
	   sum(ot.quantity) as total_sold
from online_transactions ot 
left join (select *
		  from stock_description
		  where description <> '?') sd on ot.stock_code = sd.stock_code
group by sd.description
order by total_sold DESC
limit 20;


select sd.description,
	   sum(ot.quantity) as total_sold
from online_transactions ot 
left join (select *
		  from stock_description
		  where description <> '?') sd on ot.stock_code = sd.stock_code
where country = 'Germany'
group by sd.description
order by total_sold DESC
limit 20;

select sd.description,
	   sum(ot.quantity) as total_sold
from online_transactions ot 
left join (select *
		  from stock_description
		  where description <> '?') sd on ot.stock_code = sd.stock_code
where country = 'United Kingdom'
group by sd.description
order by total_sold DESC
limit 20;






