-- challenge: which customer spent the most per country

-- top 10 customers
select customer_id,
	   country,
	   round(sum(price*quantity), 2) as total_spent
from online_transactions ot 
where customer_id <> ''
group by customer_id, country
order by total_spent desc
limit 10;

-- customer that spends the most per country
select country,
	   customer_id,
	   total_spent
from 
	(select customer_id,
		   country,
		   round(sum(price*quantity), 2) as total_spent,
		   rank() over (partition by country order by round(sum(price*quantity), 2) desc) as rank_number
	from online_transactions ot 
	where customer_id <> '' 
	group by customer_id, country
	order by total_spent desc)
where rank_number = 1
group by total_spent;



-- extract day, month and year 
select invoice_date,
	   STRFTIME("%d", invoice_date) as invoice_day,
	   STRFTIME("%m", invoice_date) as invoice_month,
	   STRFTIME("%Y", invoice_date) as invoice_year
from online_transactions ot 
limit 10;

select STRFTIME("%m", invoice_date) as invoice_month,
	   count(distinct invoice) as number_invoices
from online_transactions ot 
group by invoice_month;

-- the data ranges from dec 2010 to dec 2011, so you need ti take year into account as well
select min(invoice_date),
	   max(invoice_date)
from online_transactions ot;

-- option 1: number of invoices per month

select STRFTIME("%Y", invoice_date) as invoice_year,
	   STRFTIME("%m", invoice_date) as invoice_month,
	   count(distinct invoice)
from online_transactions ot 
group by invoice_year, invoice_month
;

-- option 2: number of invoices per month
select STRFTIME("%m", invoice_date) as invoice_month,
	   count(distinct invoice) as number_invoices
from online_transactions ot 
where STRFTIME("%Y", invoice_date) = '2011'
group by invoice_month
;

with ot_w_detail as (select *,
	   strftime("%Y", invoice_date) as invoice_year,
	   strftime("%m", invoice_date) as invoice_month,
	   case when strftime("%m", invoice_date) = '12' then 'Dec'
	   		when strftime("%m", invoice_date) = '01' then 'Jan'
			when strftime("%m", invoice_date) = '02' then 'Feb'
			when strftime("%m", invoice_date) = '03' then 'Mar'
			when strftime("%m", invoice_date) = '04' then 'Apr'
			when strftime("%m", invoice_date) = '05' then 'May'
			when strftime("%m", invoice_date) = '06' then 'Jun'
			when strftime("%m", invoice_date) = '07' then 'Jul'
			when strftime("%m", invoice_date) = '08' then 'Aug'
			when strftime("%m", invoice_date) = '09' then 'Sep'
			when strftime("%m", invoice_date) = '10' then 'Oct'
			when strftime("%m", invoice_date) = '11' then 'Nov'
	   		else 'TBD' end as invoice_month_name
from online_transactions ot)
select invoice_month_name,
	   count(distinct invoice) as number_invoices
from ot_w_detail
where invoice_year = '2011'
group by invoice_month_name
order by invoice_month
;




