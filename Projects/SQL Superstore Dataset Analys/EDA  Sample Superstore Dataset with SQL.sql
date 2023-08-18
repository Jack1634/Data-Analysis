-- EDA on Sample Superstore Dataset using SQL--

-- Row Count Of data

SELECT  COUNT(*) AS ROW_COUNT FROM SampleSuperstore

-- Column Count Of Data

SELECT  COUNT(*) AS COLUMN_COUNT FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME ='SampleSuperstore'


-- Check Dataset Ýnformation

SELECT  *  FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME ='SampleSuperstore'

-- Check Dataset Columns Name

SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME ='SampleSuperstore'

-- Check Dataset Column Name with  Data type  

SELECT  COLUMN_NAME, DATA_TYPE  FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME ='SampleSuperstore'

-- Checking Null Values

SELECT COUNT(State) AS NOT_NULL, COUNT(*) - COUNT(State) AS NULLS
FROM SampleSuperstore

 --WE HAVEN'T NULL VALUES

 -- LETS ANALYS OUR DATA

 -- 1.Which shipping mode does customer choose based on the products category and sum of the quantity?


   SELECT   [Ship Mode], Category , SUM(Quantity) AS SUM_QUANTÝTY FROM SampleSuperstore
   GROUP BY [Ship Mode], Category
   ORDER BY SUM(Quantity) DESC; 


 -- 2.Maximum number of Sales from which State?


   SELECT TOP 5 State, MAX(Sales) AS MAX_SALE FROM SampleSuperstore
   GROUP BY State
   ORDER BY MAX(Sales) DESC;



 -- 3.From which State we got maximum profit? 

	SELECT TOP 1 State, MAX(Profit) AS MAX_PROFÝT FROM SampleSuperstore
    GROUP BY State
    ORDER BY MAX(Profit) DESC;



 -- 4.Which Products are selling the most?
 
    SELECT TOP 5 Category, [Sub-Category],MAX(sales)  maximum_sales,  MAX(Profit) AS MAX_PROFÝT FROM SampleSuperstore
    GROUP BY Category,[Sub-Category]
    ORDER BY MAX(Profit) DESC;



 -- 5.Which Products are purchased in more quantity?


    SELECT TOP 5 Category,[Sub-Category],  SUM(Quantity) AS MAX_Quantity FROM SampleSuperstore
    GROUP BY Category ,[Sub-Category]
    ORDER BY SUM(Quantity) DESC;


 -- 6.By selling which products we got the maximum profit? 

    SELECT TOP 5 Category,[Sub-Category],  MAX(Profit) AS MAX_PROFÝT FROM SampleSuperstore
    GROUP BY Category ,[Sub-Category]
    ORDER BY MAX(Profit) DESC;

