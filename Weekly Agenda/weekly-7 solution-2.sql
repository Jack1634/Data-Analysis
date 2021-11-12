
--- 0
--- What is the sales quantity of product according to the brands and sort them highest-lowest

select distinct b.brand_name,
sum(o.quantity) over (partition by b.brand_id) as total_quantity
from sale.order_item o join product.product p on o.product_id=p.product_id join product.brand b on b.brand_id=p.brand_id
order by total_quantity desc;

select b.brand_name, sum(o.quantity) as total_quantity
from sale.order_item o join product.product p on o.product_id=p.product_id join product.brand b on b.brand_id=p.brand_id
group by b.brand_name
order by total_quantity desc

--- Select the top 5 most expensive products

select top 5 product_name, list_price
from product.product
order by list_price desc

--- What are the categories that each brand has

select distinct b.brand_name, c.category_name
from product.category c join product.product p on c.category_id=p.category_id join product.brand b on b.brand_id=p.brand_id
order by b.brand_name, c.category_name

--- Select the avg prices according to brands and categories

select distinct b.brand_name, c.category_name,
avg(p.list_price) over(partition by b.brand_name, c.category_name) as avg_prices
from product.category c join product.product p on c.category_id=p.category_id join product.brand b on b.brand_id=p.brand_id
order by b.brand_name, c.category_name

--- Select the annual amount of product produced according to brands

select distinct b.brand_name, p.model_year,
sum(s.quantity) over(partition by b.brand_name, p.model_year) as annual_total
from product.product p join product.brand b on p.brand_id=b.brand_id join product.stock s on s.product_id=p.product_id

--- Select the least 3 products in stock according to stores.

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

--- Select the store which has the most sales quantity in 2018

select top 1 s.store_name, sum(i.quantity) as total_quantity
from sale.store s join sale.orders o on s.store_id=o.store_id join sale.order_item i on o.order_id=i.order_id
where year(o.order_date) = 2018
group by s.store_name
order by total_quantity desc

--- Select the store which has the most sales amount in 2018

select top 1 s.store_name, sum(i.quantity * i.list_price * (1 - i.discount)) as total_amount
from sale.store s join sale.orders o on s.store_id=o.store_id join sale.order_item i on o.order_id=i.order_id
where year(o.order_date) = 2018
group by s.store_name
order by total_amount desc

--- Select the personnel which has the most sales amount in 2018

select top 1 s.staff_id, s.first_name, s.last_name, sum(i.quantity * i.list_price * (1 - i.discount)) as total_amount
from sale.staff s join sale.orders o on s.staff_id=o.staff_id join sale.order_item i on o.order_id=i.order_id
where year(o.order_date) = 2018
group by s.staff_id, s.first_name, s.last_name
order by total_amount desc

--- Select the least 3 sold products in 2018 and 2019 according to city.

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

--- 1. Find the customers who placed at least two orders per year.

select distinct t.customer_id, t.first_name, t.last_name, t.year, t.order_count
from
    (select c.customer_id, c.first_name, c.last_name, year(o.order_date) as [year],
    count(o.order_id) over(partition by c.customer_id, year(o.order_date)) as order_count
    from sale.customer c join sale.orders o on c.customer_id=o.customer_id) as t
where t.order_count >= 2;

--- 2. Find the total amount of each order which are placed in 2020. Then categorize them according to limits stated below.(You can use case when statements here)

select distinct t.order_id, t.amount,
case when t.amount < 500 then 'Very Low'
when t.amount >= 500 and t.amount < 1000 then 'Low'
when t.amount >= 1000 and t.amount < 5000 then 'Medium'
when t.amount >= 5000 and t.amount < 10000 then 'High'
when t.amount >= 10000 then 'Very High' end as Amount_Category
from
    (select o.order_id,
    sum(i.quantity * i.list_price * (1 - i.discount)) over(partition by o.order_id) as amount
    from sale.orders o join sale.order_item i on o.order_id=i.order_id
    where year(o.order_date) = 2020) as t

--- 3. By using Exists Statement find all customers who have placed more than two orders.

select c.customer_id, c.first_name, c.last_name 
from sale.customer c 
where exists 
    (select count(o.order_id)
    from sale.orders o
    where c.customer_id=o.customer_id 
    group by o.customer_id 
    having count(o.order_id) > 2)
order by c.customer_id

--- 4. Show all the products and their list price, that were sold with more than two units in a sales order.

select distinct p.product_id, p.product_name, p.list_price
from sale.order_item i join product.product p on i.product_id=p.product_id
where i.quantity >= 2

--- 5. Show the total count of orders per product for all times. (Every product will be shown in one line and the total order count will be shown besides it)

select i.product_id, p.product_name, count(o.order_id) as order_counts
from sale.orders o join sale.order_item i on o.order_id=i.order_id join product.product p on i.product_id=p.product_id
group by i.product_id, p.product_name 

--- 6. Find the products whose list prices are more than the average list price of products of all brands

select t.product_name, t.list_price, t.avg_price_by_brand
from 
    (select p.product_name, p.list_price, 
    avg(list_price) over(partition by b.brand_name) as avg_price_by_brand
    from product.product p join product.brand b on b.brand_id=p.brand_id) as t
where t.list_price > t.avg_price_by_brand