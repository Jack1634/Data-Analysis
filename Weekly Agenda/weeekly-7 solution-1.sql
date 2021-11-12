--0.Answer the following questions according to bikestore database

-- What is the sales quantity of product according to the brands and sort them highest-lowest
-- (Markalara göre ürünün satýþ miktarý nedir ve bunlarý en yüksek-en düþük olarak sýralayýnýz.)

SELECT B.brand_name ,SUM (C.quantity) AS QUANTÝTY_OF_PRODUCT
FROM product.product A
INNER JOIN product.brand B on A.brand_id = B.brand_id
INNER JOIN sale.order_item C on A.product_id= C.product_id
GROUP BY B.brand_name
ORDER BY QUANTÝTY_OF_PRODUCT DESC;


-- Select the top 5 most expensive products

SELECT TOP 5 product_name,list_price 
FROM product.product
ORDER BY list_price DESC


-- What are the categories that each brand has

SELECT DISTINCT B.brand_name,C.category_name
FROM product.product A 
INNER JOIN product.brand b ON  A.brand_id = B.brand_id
INNER JOIN product.category C ON A.category_id=C.category_id

-- Select the avg prices according to brands and categories

SELECT C.category_name,B.brand_name,  AVG(A.list_price) AS AVG_PRÝCE_ACCORDÝNG_TO_BRANDS
FROM product.product A 
INNER JOIN product.brand b ON  A.brand_id = B.brand_id
INNER JOIN product.category C ON A.category_id=C.category_id
GROUP BY B.brand_name,C.category_name


SELECT brand_name,
		CONVERT(DECIMAL, [Children Bicycles]) AS [Children Bicycles],
		CONVERT(DECIMAL, [Comfort Bicycles]) AS [Comfort Bicycles],
		CONVERT(DECIMAL, [Cruisers Bicycles]) AS [Cruisers Bicycles],
		CONVERT(DECIMAL, [Cyclocross Bicycles]) AS [Cyclocross Bicycles],
		CONVERT(DECIMAL, [Electric Bikes]) AS [Electric Bikes],
		CONVERT(DECIMAL, [Mountain Bikes]) AS [Mountain Bikes],
		CONVERT(DECIMAL, [Road Bikes]) AS [Road Bikes]
FROM
	(SELECT category_name, brand_name, list_price
	 FROM product.product AS P
		  INNER JOIN product.brand AS B ON P.brand_id=B.brand_id
		  INNER JOIN product.category AS C ON P.category_id=C.category_id
	 ) AS BaseData
PIVOT(
	 AVG(list_price)
	 FOR category_name
	 IN ([Children Bicycles]
		 ,[Comfort Bicycles]
		 ,[Cruisers Bicycles]
		 ,[Cyclocross Bicycles]
		 ,[Electric Bikes]
		 ,[Mountain Bikes]
		 ,[Road Bikes])
) AS PivotTable

-- Select the annual amount of product produced according to brands

SELECT  B.brand_name, A.model_year, count(C.quantity) as annual_amount_of_product
FROM product.product A 
INNER JOIN product.brand B on A.brand_id = B.brand_id
INNER JOIN product.stock C on A.product_id= C.product_id
GROUP By  B.brand_name, A.model_year
order by B.brand_name DESC;



-- Select the least 3 products in stock according to stores.

with t as 
(
select ss.store_id, ss.store_name, s.product_id, s.quantity, p.product_name
from sale.store ss join product.stock s on ss.store_id=s.store_id join product.product p on s.product_id=p.product_id
)
select tt.store_id, tt.store_name, tt.product_id, tt.product_name, tt.quantity, tt.ordered
from 
    (select store_id, store_name, product_id, product_name, quantity, 
    row_number() over(partition by store_id order by quantity) as ordered
    from t) as tt 
where ordered in (1,2,3)


-- Select the store which has the most sales quantity in 2018(

    select top 1  A.store_name , SUM(C.quantity ) as most_sales_quantity
	from sale.store A, sale.orders B, sale.order_item C
	where A.store_id =B.store_id and B.order_id=C.order_id 
	and order_date between '2018-01-01' and '2018-12-31'
    group by  A.store_name
	order by most_sales_quantity desc;


-- Select the store which has the most sales amount in 2018

    select top 1  A.store_name , sum((C.quantity*C.list_price)*(1-C.discount)) as most_amount
	from sale.store A, sale.orders B, sale.order_item C
	where A.store_id =B.store_id and B.order_id=C.order_id  and year(B.order_date)= 2018
    group by  A.store_name
	order by most_amount desc;



-- Select the personnel which has the most sales amount in 2018

    select top 1 A.first_name, A.last_name , sum((C.quantity*C.list_price)*(1-C.discount)) as most_amount
	from sale.staff A, sale.orders B, sale.order_item C  
	where A.staff_id =B.staff_id and B.order_id=C.order_id  and year(B.order_date)= 2018
    group by A.first_name, A.last_name
	order by most_amount desc;


  -- Select the least 3 sold products in 2018 and 2019 according to city.


 SELECT TOP 3 D.city, a.product_name, SUM(B.quantity) as least3   
FROM product.product A, sale.order_item B, sale.orders C, sale.store D
where A.product_id=B.product_id and B.order_id=C.order_id and C.store_id=D.store_id 
and (YEAR(order_date)=2018 or YEAR(order_date)=2019)
GROUP BY D.city, a.product_name
ORDER BY least3


select tt.year, tt.city, tt.product_id, tt.product_name, tt.quantity, tt.ordered
from
    (select t.year, t.city, t.product_id, t.product_name, t.quantity, 
    row_number() over(partition by t.year, t.city order by t.quantity) as ordered
    from
        (select distinct year(o.order_date) as [year], s.city, i.product_id, p.product_name,
        sum(i.quantity) over(partition by year(o.order_date), s.city, i.product_id) as quantity
        from sale.store s join sale.orders o on s.store_id=o.store_id join sale.order_item i on o.order_id=i.order_id join product.product p on p.product_id=i.product_id
        where year(o.order_date) in (2018, 2019)) as t) as tt
where tt.ordered in (1,2,3)
 
---////////////////////////////////////////////////////////////////////////////////////
---1. Find the customers who placed at least two orders per year.

select b.first_name, b.last_name , COUNT(a.order_date) as least_two ,year(a.order_date)
from sale.orders A 
INNER JOIN sale.customer B 
on a.customer_id = b.customer_id
GROUP BY A.customer_id, b.first_name, b.last_name, year(a.order_date)
having COUNT(a.order_date) > 1



---2. Find the total amount of each order which are placed in 2020. Then categorize them according to limits stated below.(You can use case when statements here)

select a.order_id,  sum((A.quantity*A.list_price)*(1-A.discount)) as total_amount,
	case
		 when sum((A.quantity*A.list_price)*(1-A.discount)) < 500 then 'very low'
	     when sum((A.quantity*A.list_price)*(1-A.discount)) >= 500  and sum((A.quantity*A.list_price)*(1-A.discount)) < 1000    then  'low'
		 when sum((A.quantity*A.list_price)*(1-A.discount)) >=  1000 and sum((A.quantity*A.list_price)*(1-A.discount)) < 5000   then  'medium'
		 when sum((A.quantity*A.list_price)*(1-A.discount)) >=  5000 and sum((A.quantity*A.list_price)*(1-A.discount)) < 10000  then  'medium'
		 else  'very high' end as total_amount
	from sale.order_item  A, sale.orders B
	where A.order_id =B.order_id and year(B.order_date)= 2020
    group by  A.order_id
	


--3. By using Exists Statement find all customers who have placed more than two orders.
--solution-1

 select b.first_name, b.last_name , COUNT(a.order_date) as least_two 
from sale.orders A 
INNER JOIN sale.customer B 
on a.customer_id = b.customer_id
GROUP BY A.customer_id, b.first_name, b.last_name 
having COUNT(a.order_date) > 2

--solution2
SELECT first_name, last_name, customer_id
FROM sale.customer a
WHERE exists(
            select COUNT(*)
            FROM sale.orders b WHERE b.customer_id = a.customer_id
            HAVING COUNT(*) > 2
            )
ORDER BY first_name, last_name;






--4. Show all the products and their list price, that were sold with more than two units in a sales order.

select DISTINCT A.product_id,A.product_name, B.list_price, B.quantity
from product.product A, sale.order_item B
where A.product_id=B.product_id and B.quantity >= 2







--5. Show the total count of orders per product for all times. (Every product will be shown in one line and the total order count will be shown besides it)

select A.product_id, COUNT(DISTINCT c.order_date) AS TOTAL
from product.product A, sale.order_item b, sale.orders c
where A.product_id=B.product_id and c.order_id =b.order_id
GROUP BY A.product_id








--6. Find the products whose list prices are more than the average list price of products of all brands
--solution-1
select b.brand_id,A.product_name
from product.product A ,product.brand B
where A.brand_id = B.brand_id  and A.list_price >  ( select AVG(list_price) from product.product)

--solution--2

select t.product_name, t.list_price, t.avg_price_by_brand
from 
    (select p.product_name, p.list_price, 
    avg(list_price) over(partition by b.brand_name) as avg_price_by_brand
    from product.product p join product.brand b on b.brand_id=p.brand_id) as t
where t.list_price > t.avg_price_by_brand
