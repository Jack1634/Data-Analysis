

--DAwSQL Session - Recap 

--E-Commerce Project Solution



--1. Join all the tables and create a new table called combined_table. (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)


SELECT *
INTO
combined_table
FROM
(
SELECT 
cd.Cust_id, cd.Customer_Name, cd.Province, cd.Region, cd.Customer_Segment, 
mf.Ord_id, mf.Prod_id, mf.Sales, mf.Discount, mf.Order_Quantity, mf.Product_Base_Margin,
od.Order_Date, od.Order_Priority,
pd.Product_Category, pd.Product_Sub_Category,
sd.Ship_id, sd.Ship_Mode, sd.Ship_Date
FROM market_fact mf
INNER JOIN cust_dimen cd ON mf.Cust_id = cd.Cust_id
INNER JOIN orders_dimen od ON od.Ord_id = mf.Ord_id
INNER JOIN prod_dimen pd ON pd.Prod_id = mf.Prod_id
INNER JOIN shipping_dimen sd ON sd.Ship_id = mf.Ship_id
) A;


select * from combined_table



--///////////////////////


--2. Find the top 3 customers who have the maximum count of orders.

SELECT	TOP(3)cust_id, COUNT (Ord_id) count_of_orders
FROM	combined_table
GROUP BY Cust_id
ORDER BY count_of_orders desc



--/////////////////////////////////



--3.Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.

ALTER TABLE combined_table ADD DaysTakenForDelivery INT

UPDATE combined_table 
SET DaysTakenForDelivery = DATEDIFF(DAY, Order_date, Ship_date)


select * from combined_table


--////////////////////////////////////


--4. Find the customer whose order took the maximum time to get delivered.
--Use "MAX" or "TOP"
SELECT	Cust_id, Customer_Name, Order_Date, Ship_Date, DaysTakenForDelivery
FROM	combined_table
WHERE	DaysTakenForDelivery =(
								SELECT	MAX(DaysTakenForDelivery)
								FROM combined_table
								)



SELECT top 1 Customer_Name,Cust_id,DaysTakenForDelivery
FROM combined_table
order by DaysTakenForDelivery desc



--////////////////////////////////



--5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
--You can use such date functions and subqueries


SELECT MONTH(order_date) [MONTH], COUNT(DISTINCT cust_id) MONTHLY_NUM_OF_CUST
FROM	Combined_table A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	combined_table B
WHERE	YEAR(Order_Date) = 2011
AND		MONTH (Order_Date) = 1
AND		A.Cust_id = B.Cust_id
)
AND	YEAR (Order_Date) = 2011
GROUP BY
MONTH(order_date)

--////////////////////////////////////////////


--6. write a query to return for each user the time elapsed between the first purchasing and the third purchasing, 
--in ascending order by Customer ID
--Use "MIN" with Window Functions



SELECT DISTINCT 
		cust_id,
		order_date,
		dense_number,
		FIRST_ORDER_DATE,
		DATEDIFF(day, FIRST_ORDER_DATE, order_date) DAYS_ELAPSED
FROM	
		(
		SELECT	Cust_id, ord_id, order_DATE,
				MIN (Order_Date) OVER (PARTITION BY cust_id) FIRST_ORDER_DATE,
				DENSE_RANK () OVER (PARTITION BY cust_id ORDER BY Order_date) dense_number
		FROM	combined_table
		) A
WHERE	dense_number = 3

--//////////////////////////////////////

--7. Write a query that returns customers who purchased both product 11 and product 14, 
--as well as the ratio of these products to the total number of products purchased by the customer.
--Use CASE Expression, CTE, CAST AND such Aggregate Functions



SELECT *
FROM combined_table

WITH T1 AS
(
SELECT	Cust_id,
		SUM (CASE WHEN Prod_id = 'Prod_11' THEN Order_Quantity ELSE 0 END) P11,
		SUM (CASE WHEN Prod_id = 'Prod_14' THEN Order_Quantity ELSE 0 END) P14,
		SUM (Order_Quantity) TOTAL_PROD
FROM	combined_table
GROUP BY Cust_id
HAVING
		SUM (CASE WHEN Prod_id = 'Prod_11' THEN Order_Quantity ELSE 0 END) >= 1 AND
		SUM (CASE WHEN Prod_id = 'Prod_14' THEN Order_Quantity ELSE 0 E
		ND) >= 1
)
SELECT	Cust_id, P11, P14, TOTAL_PROD,
		CAST (1.0*P11/TOTAL_PROD AS NUMERIC (3,2)) AS RATIO_P11,
		CAST (1.0*P14/TOTAL_PROD AS NUMERIC (3,2)) AS RATIO_P14
FROM T1



--/////////////////



--CUSTOMER SEGMENTATION



--1. Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
--Use such date functions. Don't forget to call up columns you might need later.


SELECT Cust_id, YEAR(Order_Date) ORD_YEAR, MONTH(Order_Date) ORD_MONTH
FROM	combined_table

ORDER BY 1,2,3


--//////////////////////////////////


--2. Create a view that keeps the number of monthly visits by users. (Separately for all months from the business beginning)
--Don't forget to call up columns you might need later.



CREATE VIEW CNT_CUSTOMER_LOGS AS
SELECT DISTINCT Cust_id, YEAR(Order_Date) ORD_YEAR, MONTH(Order_Date) ORD_MONTH, COUNT (*) OVER (PARTITION BY cust_id) CNT_LOG
FROM	combined_table




--//////////////////////////////////


--3. For each visit of customers, create the next month of the visit as a separate column.
--You can number the months with "DENSE_RANK" function.
--then create a new column for each month showing the next month using the numbering you have made. (use "LEAD" function.)
--Don't forget to call up columns you might need later.




SELECT * FROM CNT_CUSTOMER_LOGS


--/////////////////////////////////



--4. Calculate the monthly time gap between two consecutive visits by each customer.
--Don't forget to call up columns you might need later.


CREATE VIEW VISITS AS 
SELECT *, LEAD(CURRENT_MONTH, 1) OVER (PARTITION BY cust_id ORDER BY CURRENT_MONTH) NEXT_VISIT_MONTH
FROM
(
SELECT *, DENSE_RANK() OVER (ORDER BY ORD_YEAR, ORD_MONTH) CURRENT_MONTH
FROM	CNT_CUSTOMER_LOGS 
) A

SELECT * FROM VISITS



CREATE VIEW TIME_GAPS AS
SELECT *, NEXT_VISIT_MONTH - CURRENT_MONTH TIME_GAPS
FROM VISITS




SELECT * FROM TIME_GAPS

--/////////////////////////////////////////


--5.Categorise customers using time gaps. Choose the most fitted labeling model for you.
--  For example: 
--	Labeled as churn if the customer hasn't made another purchase in the months since they made their first purchase.
--	Labeled as regular if the customer has made a purchase every month.
--  Etc.


WITH T1 AS
(
SELECT cust_id, AVG(TIME_GAPS) AVG_TIME_GAP
FROM TIME_GAPS
GROUP BY cust_id
) 
SELECT cust_id,
		CASE WHEN AVG_TIME_GAP IS NULL THEN 'CHURN'
				WHEN AVG_TIME_GAP = 1 THEN 'REGULAR'
				WHEN AVG_TIME_GAP > 1 THEN 'IRREGULAR'
				ELSE 'UNKNOWN'
		END AS CUST_SEGMENT
FROM	T1




--/////////////////////////////////////




--MONTH-WISE RETENTION RATE


--Find month-by-month customer retention rate  since the start of the business.


--1. Find the number of customers retained month-wise. (You can use time gaps)
--Use Time Gaps



CREATE VIEW CNT_RETAINED_CUST AS
SELECT *, COUNT(cust_id) OVER (PARTITION BY NEXT_VISIT_MONTH) CNT_RETAINED_CUST
FROM TIME_GAPS
WHERE TIME_GAPS = 1


SELECT * FROM CNT_RETAINED_CUST



CREATE VIEW CNT_TOTAL_CUST AS
SELECT *, COUNT (cust_id) OVER (PARTITION BY CURRENT_MONTH) CNT_TOTAL_CUST
FROM TIME_GAPS
WHERE CURRENT_MONTH > 1



SELECT * FROM CNT_TOTAL_CUST WHERE TIME_GAPS = 1



--//////////////////////


--2. Calculate the month-wise retention rate.

--Basic formula: o	Month-Wise Retention Rate = 1.0 * Number of Customers Retained in The Current Month / Total Number of Customers in the Current Month

--It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
--You can also use CTE or Subquery if you want.

--You should pay attention to the join type and join columns between your views or tables.







WITH T1 AS
(
SELECT	DISTINCT A.Cust_id, A.NEXT_VISIT_MONTH, A.CNT_RETAINED_CUST, B.CNT_TOTAL_CUST
FROM	CNT_RETAINED_CUST A, CNT_TOTAL_CUST B
WHERE	B.CURRENT_MONTH = A. NEXT_VISIT_MONTH
AND		B.TIME_GAPS = 1
) 
SELECT DISTINCT NEXT_VISIT_MONTH, CAST (1.0* CNT_RETAINED_CUST/CNT_TOTAL_CUST AS NUMERIC (3,2)) AS  MONTHLY_WISE_RETENTION_RATE
FROM T1
ORDER BY 1


---///////////////////////////////////
--Good luck!