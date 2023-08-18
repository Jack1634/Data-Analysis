
--  1. What is the sales quantity of product according to the brands and sort them highest-lowest

--- Solution-1---
SELECT c.brand_name, sum(d.quantity) total_quantity
FROM sale.order_item D
join (SELECT A.product_id, B.brand_name  FROM product.product A JOIN product.brand B ON A.brand_id=B.brand_id) AS C
ON C.product_id =d.product_id 
group by c.brand_name 
order by total_quantity desc;


---Solution2---

SELECT   B.brand_name, sum(C.quantity) total_quantity
FROM  product.product A INNER JOIN product.brand B on A.brand_id = B.brand_id
INNER JOIN sale.order_item C on A.product_id = c.product_id
group by B.brand_name 
order by total_quantity desc;

--- 2. Select the top 5 most expensive products----


SELECT  top 5 * 
FROM product.product  
order by  list_price desc;


--  3. What are the categories that each brand has

SELECT  DISTINCT c.category_name, b.brand_name
FROM  product.product A INNER JOIN product.brand B on A.brand_id = B.brand_id
INNER JOIN product.category C on A.category_id = c.category_id
group by  c.category_name, B.brand_name;

--  4. Select the avg prices according to brands and categories--

SELECT c.category_name, b.brand_name , avg(A.list_price)  as avg_list
FROM  product.product A INNER JOIN product.brand B on A.brand_id = B.brand_id
INNER JOIN product.category C on A.category_id = c.category_id
group by c.category_name, b.brand_name 