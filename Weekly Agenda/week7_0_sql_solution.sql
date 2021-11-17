--What is the sales quantity of product according to the brands and sort them highest-lowest

select b.[brand_name], p.product_name, count(o.[quantity]) [Sales Quantitiy of Product]
from [production].[brands] b
inner join [production].[products] p
on b.brand_id = p.brand_id
inner join [sales].[order_items] o
on p.product_id = o.product_id
group by b.brand_name, p.product_name
order by [Sales Quantitiy of Product] desc;


--Select the top 5 most expensive products

select top 5 [product_name], [list_price]
from [production].[products]
order by [list_price] desc;

--What are the categories that each brand has

select b.[brand_name], c.[category_name]
from [production].[brands] b
inner join [production].[products] p
on b.brand_id = p.brand_id
inner join [production].[categories] c
on p.category_id = c.category_id
group by b.brand_name, c.category_name


--Select the avg prices according to brands and categories

select b.[brand_name], c.[category_name], avg(p.[list_price]) as [Avg Price]
from [production].[brands] b
inner join [production].[products] p
on b.brand_id = p.brand_id
inner join [production].[categories] c
on p.category_id = c.category_id
group by b.brand_name, c.category_name


--Select the annual amount of product produced according to brands

select p.[model_year],b.[brand_name], count(p.[product_name])
from [production].[brands] b
inner join [production].[products] p
on b.brand_id = p.brand_id
group by p.[model_year],b.[brand_name]
order by p.[model_year]

select distinct b.brand_name, p.model_year,
	count(p.[product_id]) over (PARTITION BY  b.brand_name, p.model_year) as annual_amount_brands
from [production].[brands] b
inner join [production].[products] p
on b.brand_id=p.brand_id
order by b.brand_name, p.model_year

--Select the least 3 products in stock according to stores.

select  d.store_id, c.product_id, c.product_name, sum(c.toplam) top_stok
from
[production].[stocks] d
cross apply
		(
		select top(3) b.product_id, b.product_name, sum(a.quantity) toplam
		from
		[production].[stocks] a, [production].[products] b
		where
		a.product_id=b.product_id
		and
		a.store_id= d.store_id
		group by
		b.product_id, b.product_name
		order by
		toplam
		) c
group by
d.store_id, c.product_id, c.product_name
order by
store_id, top_stok



SELECT	*
FROM	(
		select ss.store_name, p.product_name, SUM(s.quantity) product_quantity,
		row_number() over(partition by ss.store_name order by SUM(s.quantity) ASC) least_3
		from [sales].[stores] ss
		inner join [production].[stocks] s
		on ss.store_id=s.store_id
		inner join [production].[products] p
		on s.product_id=p.product_id
		GROUP BY ss.store_name, p.product_name
		HAVING SUM(s.quantity) > 0
		) A
WHERE	A.least_3 < 4


;with temp_cte
as(
select ss.[store_name], pp.[product_name],
row_number() over(partition by ss.[store_name] order by ss.[store_name]) as [row number]
from [production].[products] pp
inner join [production].[stocks] ps
on pp.product_id = ps.product_id
inner join [sales].[stores] ss
on ps.store_id = ss.store_id
)
select * from temp_cte
where [row number] < 4

--Select the store which has the most sales quantity in 2016

select top 1 s.[store_name], sum(i.[quantity])
from [sales].[stores] s
inner join [sales].[orders] o
on s.store_id = o.store_id
inner join [sales].[order_items] i
on o.order_id = i.order_id
where  datename(year, o.[order_date]) = '2016' -- year(o.[order_date])
group by s.[store_name] 
order by sum(i.[quantity]) desc;

--Select the store which has the most sales amount in 2016

select * from [sales].[order_items]

select top 1 s.[store_name], sum(i.[list_price]) as sales_amount_2016
from [sales].[stores] s
inner join [sales].[orders] o
on s.store_id = o.store_id
inner join [sales].[order_items] i
on o.order_id = i.order_id
where  datename(year, o.[order_date]) = '2016' -- year(o.[order_date])
group by s.[store_name] 
order by sum(i.[list_price]) desc;

--Select the personnel which has the most sales amount in 2016

select top 1 s.[first_name], s.[last_name], sum(i.[list_price]) as sales_amount_2016
from [sales].[staffs] s
inner join [sales].[orders] o
on s.staff_id = o.staff_id
inner join [sales].[order_items] i
on o.order_id = i.order_id
where  datename(year, o.[order_date]) = '2016'
group by s.[first_name], s.[last_name] 
order by sum(i.[list_price]) desc;


--Select the least 3 sold products in 2016 and 2017 according to city. (Çözümü tam deðil)

;with temp2_cte
as(
select p.[product_name], datename(year, o.[order_date]) as order_date,
row_number() over(partition by datename(year, o.[order_date]) order by datename(year, o.[order_date])) as [row number]
from [production].[products] p
inner join [sales].[order_items] i
on p.product_id = i.product_id
inner join [sales].[orders] o
on o.order_id = i.order_id
where  datename(year, o.[order_date]) in ('2016', '2017')
)
select * from temp2_cte
where [row number] < 4

--Select the least 3 sold products in 2016 and 2017 according to city. 

select e.city, d.product_id, d.product_name, sum(d.top_sat) toplam_satis
from
[sales].[stores] e
cross apply
		(
		select top (3) c.product_id, c.product_name, sum(b.quantity) top_sat
		from
		[sales].[orders] a, [sales].[order_items] b, [production].[products] c
		where
		a.order_id=b.order_id
		and
		b.product_id= c.product_id
		and
		a.store_id=e.store_id
		and
		(a.order_date LIKE '__16______' or a.order_date LIKE '__17______')
		group by
		c.product_id, c.product_name
		order by
		top_sat
		) d
group by
e.city, d.product_id, d.product_name
order by
e.city, toplam_satis

