USE Northwind

SELECT * FROM Customers
WHERE Country = 'Germany'


SELECT  top 10 * FROM Northwind.dbo.Customers
ORDER by CompanyName

SELECT TOP 10 * FROM Pubs.dbo.Authors
ORDER BY City

-- to find columns in a table
SELECT column_name FROM information_schema.columns

-- to find tables in a database
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' -- to find tables in a database 


/*If the database table contains columns which are named like reserved words, e.g. Date, you need
to enclose the column name in brackets, like this:*/

-- descending order
SELECT TOP 10 [Date] FROM dbo.MyLogTable
ORDER BY [Date] DESC

/*The same applies if the column name contains spaces in its name (which is not recommended).
An alternative syntax is to use double quotes instead of square brackets, e.g.:*/

-- descending order
SELECT top 10 "Date" from dbo.MyLogTable
order by "Date" desc

/*is equivalent but not so commonly used. Notice the difference between double quotes and single
quotes: Single quotes are used for strings, i.e.*/

-- descending order
SELECT top 10 "Date" from dbo.MyLogTable
where UserId='johndoe'
order by "Date" desc
--is a valid syntax. Notice that T-SQL has a N prefix for NChar and NVarchar data types, e.g.

SELECT top 10 * from Northwind.dbo.Customers
where  CompanyName like  N'AL%'
ORDER BY CompanyName