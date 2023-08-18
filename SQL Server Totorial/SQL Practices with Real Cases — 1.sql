use [AdventureWorks2012]

-- to show table name in database

SELECT * FROM [AdventureWorks2012].INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE='BASE TABLE'

-- to shwow column name in table 

exec sp_columns Address


/*CASE 1:

Are there how many products in each stock places?

Are there how many product in the warehouse for a Product ID?

What is percentage of the product in the stock places for Product ID?*/

-- Step 1: View the table

SELECT * FROM [Production].[ProductInventory] ppi;

-- Step 2: Select the columns you need

/*When writing query, using abbreviation is useful method to have readable quey.
I used here “ppi” for Production.ProductInventory. Then, you need to write “ppi.”
and the column’s name you want to see in the query. I want to view ProductID, 
LocationID, Shelf, Bin and Quantity columns.*/

SELECT ppi.ProductID, ppi.LocationID, ppi.Shelf, ppi.Bin, ppi.Quantity
FROM Production.ProductInventory ppi ;

-- Step 3 : Calculate the product quantities for each ProductID

/*SUM(Calculated Column) OVER (PARTITION BY [To be grouped column]) AS ‘Description’
is a useful formula to calculate columns according to grouping conditions. In this 
example, total quantities of each ProductID are calculated and written. 
This information will be used in the next step.*/



