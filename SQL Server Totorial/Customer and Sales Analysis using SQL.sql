--On average, how many orders do we receive per day? Plus, what's our average sales per day?
	with avg_sales_per_day as (
		select OrderDate, 
			count(distinct SalesOrderNumber) as order_count,
				sum(SalesAmount) as Sales
		from  [dbo].[FactInternetSales]
		group by OrderDate
	)

	select 
	avg(Sales) as avg_sales_day,
	avg(order_count) avg_order_count
	from avg_sales_per_day


	Use AdventureWorksDW2019
	GO
--1.	Find out how many customers have repeat purchase. Define new vs returning customer. 
	with customers as (
	select 
	CustomerKey,
	ROW_NUMBER() Over (partition by CustomerKey Order by CustomerKey) as rownum
	from [dbo].[FactInternetSales] f
	)
	, repeat_buyers as (
	select distinct 
		CustomerKey
	FROM customers
	where  rownum > 1
	)
	, first_purchase as (
	select distinct
		CustomerKey
	FROM customers
	where  rownum = 1
	)
	select 
		case
			when r.CustomerKey IS NOT NULL
			then 'repeat'
			else 'new'
			end as repeat_new,
			count(*) as number_of_customer,
			(	select count(distinct customerkey)
				from customers
				) as total_customers,
				FORMAT(cast(count(*) as decimal(18,2))/cast((select count(distinct customerkey)
										from customers) as decimal(18,2)), 'P') as repeat_rate
	from first_purchase f 
	left join  repeat_buyers r on f.CustomerKey = r.CustomerKey
	group by 
		case
			when r.CustomerKey IS NOT NULL
			then 'repeat'
			else 'new'
			end