CREATE DATABASE Dannys_Dinner;
USE Dannys_Dinner;

CREATE TABLE sales (
    "customer_id" VARCHAR(1),
    "order_date" DATE,
    "product_id" INTEGER,
);

INSERT INTO sales ("customer_id","order_date","product_id") 
VALUES 
('A', '2021-01-01', '1'),
('A', '2021-01-01', '2'),
('A', '2021-01-07', '2'),
('A', '2021-01-10', '3'),
('A', '2021-01-11', '3'),
('A', '2021-01-11', '3'),
('B', '2021-01-01', '2'),
('B', '2021-01-02', '2'),
('B', '2021-01-04', '1'),
('B', '2021-01-11', '1'),
('B', '2021-01-16', '3'),
('B', '2021-02-01', '3'),
('C', '2021-01-01', '3'),
('C', '2021-01-01', '3'),
('C', '2021-01-07', '3');

CREATE TABLE menu (
    "product_id" INTEGER,
    "product_name" VARCHAR(5),
    "price" INTEGER
);

INSERT INTO menu ("product_id","product_name","price")
VALUES
('1', 'sushi', '10'),
('2', 'curry', '15'),
('3', 'ramen', '12');

CREATE TABLE members (
    "customer_id" VARCHAR(1), 
    "join_date" DATE
);

INSERT INTO members ("customer_id","join_date")
VALUES 
('A', '2021-01-07'),
('B', '2021-01-09');

-- to show table name in database

    SELECT TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE='BASE TABLE'

-- to show column name in table
   exec sp_columns sales


****************************************************************************
Case Study Questions
Each of the following case study questions can be answered using a single SQL statement: 

-- 1.What is the total amount each customer spent at the restaurant?

    SELECT s.customer_id, SUM(m.price)  as "each_customer_spent" 
    FROM sales s INNER JOIN
    menu m ON s.product_id = m.product_id  GROUP BY s.customer_id
    order BY s.customer_id;

 -- 2. How many days has each customer visited the restaurant?

     SELECT customer_id, COUNT( distinct order_date) as "days_visited"
     FROM sales 
     GROUP BY customer_id ORDER BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?
      
      SELECT customer_id, 
             product_name
      FROM ( select s.customer_id,
             s.order_date,
             m.product_name,
             dense_rank() over (partition by s.customer_id 
      order by s.order_date) as "rank"
      FROM sales s LEFT JOIN menu m ON s.product_id = m.product_id
      LEFT JOIN members ms ON s.customer_id = ms.customer_id) a 
      WHERE a.rank = 1
      GROUP BY customer_id, product_name;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

        SELECT  top 1 m.product_name, COUNT(s.customer_id) as "times_purchased"
        FROM sales s INNER JOIN menu m ON s.product_id = m.product_id
        GROUP BY m.product_name
        ORDER BY times_purchased DESC;

--5. Which item was the most popular for each customer? 
       
         SELECT customer_id, 
                product_name
        FROM ( select s.customer_id,
                      m.product_name,
                      count(m.product_name) as "order_count",
                        dense_rank() over (partition by s.customer_id ORDER BY 
            count(m.product_name) DESC) as "rank"
            FROM sales s INNER JOIN menu m ON s.product_id = m.product_id
            GROUP BY s.customer_id, m.product_name) a
        WHERE a.rank = 1

--6. Which item was purchased first by the customer after they became a member?
        
        SELECT TOP 1 WITH TIES 
                s.customer_id, 
                m.product_name
        FROM sales s INNER JOIN menu m ON s.product_id = m.product_id
        INNER JOIN members ms ON s.customer_id = ms.customer_id
        WHERE s.order_date > ms.join_date
        order by row_number() over (partition by s.customer_id order by s.order_date);

--7. Which item was purchased just before the customer became a member?
    SELECT  
            customer_id,
            product_name
    FROM (select s.customer_id,
                 s.order_date,
                 m.product_name,
                 dense_rank() over (partition by s.customer_id
    ORDER BY s.order_date DESC) as "rank"
        FROM sales s 
        INNER JOIN menu m ON s.product_id = m.product_id
        INNER JOIN members ms ON s.customer_id = ms.customer_id 
        where s.order_date < ms.join_date) a
    WHERE rank = 1
    GROUP BY customer_id, product_name;

--8. What is the total items and amount spent for each member before they became a member?

    SELECT s.customer_id,
            count(distinct s.product_id) as "items",
            SUM(m.price) as "amount"
    FROM sales s INNER JOIN menu m ON s.product_id = m.product_id
    INNER JOIN members ms ON s.customer_id = ms.customer_id
    WHERE s.order_date < ms.join_date
    GROUP BY s.customer_id;


--9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?

    SELECT s.customer_id,
            SUM(cp.points) "points"
    FROM sales s INNER JOIN (SELECT * , 
                            CASE WHEN product_name = 'sushi' THEN price*20
                            ELSE price*10 END as "points"
                            FROM menu) cp ON s.product_id = cp.product_id
    GROUP BY s.customer_id;

--10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items,
-- not just sushi — how many points do customer A and B have at the end of January?

    SELECT customer_id,
            SUM(points) "points"
    FROM (SELECT s.customer_id,
            CASE WHEN product_name = 'sushi' AND
            s.order_date BETWEEN DATEADD(DAY, -1, ms.join_date) AND 
    DATEADD(DAY, 6, ms.join_date) THEN m.price*40
           WHEN product_name = 'sushi' or 
            s.order_date BETWEEN DATEADD(DAY, -1, ms.join_date) AND
    DATEADD(DAY, 6, ms.join_date) THEN m.price*20
              ELSE m.price*10 END as "points"
            FROM sales s INNER JOIN menu m ON s.product_id = m.product_id
            INNER JOIN members ms ON s.customer_id = ms.customer_id
            WHERE s.order_date<='2021-01-31') a
    GROUP BY customer_id;

--11. Creating basic data tables that Danny and his team can use to quickly derive
-- insights without needing to join the underlying tables using SQL.
    
    SELECT s.customer_id,
           m.product_name,
           s.order_date,
           m.price,
              CASE WHEN s.order_date >= ms.join_date THEN 'Y'
                ELSE 'N' END as "member"
    FROM sales s INNER JOIN menu m ON s.product_id = m.product_id
    INNER JOIN members ms ON s.customer_id = ms.customer_id
    order by s.customer_id, s.order_date, m.product_name;


/*--12.Danny also requires further information about the ranking of customer products, 
but he purposely does not need the ranking for non-member purchases so he expects null 
ranking values for the records when customers are not yet part of the loyalty program*/

     select *,
       case when member = 'Y' then rank() over (partition by 
       customer_id, member order by order_date)
            else NULL end ranking
from (select s.customer_id,
             s.order_date,
             m.product_name,
             m.price,
             case when s.order_date >= ms.join_date then 'Y'
                  else 'N' end member
      from sales s
      left join menu m on s.product_id = m.product_id
      left join members ms on s.customer_id = ms.customer_id) a
order by customer_id, order_date, product_name;
        
           