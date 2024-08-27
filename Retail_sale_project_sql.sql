DROP TABLE IF EXISTS retail_sales;
create table retail_sales (
    transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)

select * from retail_sales

select * from retail_sales 
	where 
transactions_id is null 
or sale_date is null 
or sale_time is null
or customer_id is null
or gender is null
or age is null 
or category is null
or quantiy is null 
or price_per_unit is null
or cogs is null
or total_sale is null

DELETE from retail_sales 
	where 
transactions_id is null 
or sale_date is null 
or sale_time is null
or customer_id is null
or gender is null
or age is null 
or category is null
or quantiy is null 
or price_per_unit is null
or cogs is null
or total_sale is null

--Data exploration

--How many sales we have?
select count(*) from retail_sales

--How many customers we have ?
select count(distinct customer_id) from retail_sales

--Data Analysis and business key problems

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
Select * 
from retail_sales
where sale_date = '2022-11-05'

--Write a SQL query to retrieve where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select sale_date,category, quantiy from retail_sales 
where category = 'Clothing' and quantiy >= 4 and to_char(sale_date , 'YYYY-MM') = '2022-11'

--SQL query to calculate total sales for each query

select category , sum(total_sale) from retail_sales
group by category

--Average age of customers who purchased the item from the beauty category

select category , round(avg(age) , 2) from retail_sales
group by category
having category = 'Beauty'

-- Find all the transactions where total sale is greater than 1000

select transactions_id , total_sale 
from retail_sales
where total_sale>1000
order by total_sale

--Find total number of transactions made by each gender in each category

select category , gender, count(transactions_id) 
from retail_sales
group by category, gender 
order by category

-- Calculate average sales of each month and find best selling month in each year

select * from 
(	
select 
EXTRACT(YEAR from sale_date) as year,
EXTRACT(MONTH from sale_date) as month,
avg(total_sale) as avg,
RANK() over(partition by EXTRACT(YEAR from sale_date) order by avg(total_sale) desc) as rank   
from retail_sales   
group by 1,2
	)
where rank = 1


-- 5 customers based on highest total sales

select customer_id , sum(total_sale) as sum from retail_sales
group by customer_id
order by sum desc
limit 5

-- Find the number of unique customers who purchased items for each category

select category , count(distinct customer_id )
from retail_sales
group by category

-- SQL query to create each shift and number of orders (Eg. Morning <12, afternoon 12-17 , Evening >17)

select shift , count(*) from 
	(
	select * ,
	case
	when extract(hour from sale_time) < 12 then 'Morning'
	when extract(hour from sale_time)>12 and extract(hour from sale_time)<17  then 'Afternoon'
	else 'Evening'
	end as shift
	from retail_sales
)
group by shift
	
--End of project---
