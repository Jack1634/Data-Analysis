--Preview the table
SELECT * FROM dbo.Groceries_dataset;

--Check for Null values in Column 1
SELECT Member_Number FROM dbo.Groceries_dataset WHERE Member_Number IS NULL;

--Check for Null values in Column 2
SELECT [Date] FROM dbo.Groceries_dataset WHERE [Date] IS NULL;

--Check for Null values in Column 3
SELECT itemDescription FROM dbo.Groceries_dataset WHERE itemDescription IS NULL;

--Create a new column in the table new_purchase_date
ALTER TABLE dbo.Groceries_dataset ADD new_purchase_date DATE;

--Create a new column for the purchase date cast as a DATE data type
--103 specifies YYYY-MM-DD
UPDATE dbo.Groceries_dataset SET new_purchase_date = CONVERT(DATE, [Date], 103);

--Count distinct member numbers.
SELECT COUNT( DISTINCT member_number) FROM dbo.Groceries_dataset;

--Count distinct items
SELECT COUNT( DISTINCT itemDescription) FROM dbo.Groceries_dataset;

--Find earliest and latest dates in dataset
SELECT MAX (new_purchase_date) FROM dbo.Groceries_dataset;
SELECT MIN (new_purchase_date) FROM dbo.Groceries_dataset;

--Find the most popular items sold
SELECT itemDescription, COUNT(itemDescription) FROM dbo.Groceries_dataset 
GROUP BY itemDescription ORDER BY COUNT(itemDescription) DESC;

--Create a new column in the table for YEAR, MONTH, DAY, and DAY OF THE WEEK
ALTER TABLE dbo.Groceries_dataset ADD purchase_year INT;
ALTER TABLE dbo.Groceries_dataset ADD purchase_month INT;
ALTER TABLE dbo.Groceries_dataset ADD purchase_day INT;
ALTER TABLE dbo.Groceries_dataset ADD purchase_dow nvarchar(255);

--Update new columns with date related data
UPDATE dbo.Groceries_dataset SET purchase_year = YEAR(new_purchase_date);
UPDATE dbo.Groceries_dataset SET purchase_month = MONTH(new_purchase_date);
UPDATE dbo.Groceries_dataset SET purchase_day = DAY(new_purchase_date);
UPDATE dbo.Groceries_dataset SET purchase_dow = DATENAME(weekday, new_purchase_date);

--Most popular products for 2014
SELECT itemDescription, count(itemDescription) FROM dbo.Groceries_dataset 
WHERE purchase_year=2014 GROUP BY itemDescription ORDER BY count(itemDescription) DESC;

--Most popular products for 2015
SELECT itemDescription, count(itemDescription) FROM dbo.Groceries_dataset 
WHERE purchase_year=2015 GROUP BY itemDescription ORDER BY count(itemDescription) DESC;

--Sales by Year
SELECT purchase_year, count(itemDescription)FROM dbo.Groceries_dataset 
 GROUP BY purchase_year ORDER BY count(itemDescription) DESC;

 --Practice writing GROUP BY and ORDER BY statements in different ways to compare outputs
SELECT itemDescription, count(itemDescription), purchase_month FROM dbo.Groceries_dataset 
 GROUP BY itemDescription, purchase_month ORDER BY count(itemDescription) DESC;

 --Sales By Month
 SELECT count(itemDescription), purchase_month FROM dbo.Groceries_dataset 
 GROUP BY purchase_month ORDER BY count(itemDescription) DESC;

   --Sales By Month for all years
 SELECT purchase_month, count(itemDescription) FROM dbo.Groceries_dataset 
 GROUP BY purchase_month ORDER BY count(itemDescription) DESC;

   --Sales By Month for 2014
 SELECT purchase_month, count(itemDescription) FROM dbo.Groceries_dataset WHERE purchase_year=2014
 GROUP BY purchase_month ORDER BY count(itemDescription) DESC;

   --Sales By Month for 2015
 SELECT purchase_month, count(itemDescription) FROM dbo.Groceries_dataset WHERE purchase_year=2015
 GROUP BY purchase_month ORDER BY count(itemDescription) DESC;

 --Sales By purchase day for 2014
      SELECT purchase_day, count(itemDescription) FROM dbo.Groceries_dataset WHERE purchase_year=2014
 GROUP BY purchase_day ORDER BY count(itemDescription) DESC;

  --Sales By purchase day for 2015
   SELECT purchase_day, count(itemDescription) FROM dbo.Groceries_dataset WHERE purchase_year=2015
 GROUP BY purchase_day ORDER BY count(itemDescription) DESC;

 --Sales By purchase day of the week for 2014
    SELECT purchase_dow, count(itemDescription) FROM dbo.Groceries_dataset WHERE purchase_year=2014
 GROUP BY purchase_dow ORDER BY count(itemDescription) DESC;

--Sales By purchase day of the week for 2015
   SELECT purchase_dow, count(itemDescription) FROM dbo.Groceries_dataset WHERE purchase_year=2015
 GROUP BY purchase_dow ORDER BY count(itemDescription) DESC;

 