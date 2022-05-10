-- INSERT / SELECT / UPDATE / DELETE: the basics of Data Manipulation Language
-- Data Manipulation Language (DML) is a set of SQL statements (INSERT , UPDATE, DELETE) that perform data manipulation.

-- delete :
-- Create a table HelloWorld

CREATE TABLE HelloWorld
(
    Id int IDENTITY,
    Description varchar(1000) 
);

-- DML Operations INSERT  a row in the table
INSERT INTO HelloWorld (Description) VALUES ('Hello World');

-- -- DML Operation SELECT, displaying the table 

SELECT * FROM HelloWorld;

--Select  a specific column from table 
SELECT Description FROM HelloWorld;

-- Disply number of records in the table
SELECT COUNT(*) FROM HelloWorld;

-- DML (Data Manipulation Language) Opreation UPDATE  , updating a spesific row in the table 
UPDATE HelloWorld SET Description = 'Hello World' Where ID =1;

-- Selecting rows from the table ( see how the Description  has changed  after the update?)
SELECT * FROM HelloWorld;

-- DML (Data Manipulation Language) Opreation DELETE  , deleting a spesific row in the table
DELETE FROM HelloWorld WHERE ID = 1;

-- DML (Data Manipulation Language) Opreation INSERT  , inserting a spesific row in the table
INSERT INTO HelloWorld (Id, Description) VALUES (2, 'Hello World');

-- Selecting  the table .See table content after the DELETE and INSERT
SELECT * FROM HelloWorld;



USE Northwind;
GO
SELECT TOP 10 * FROM Customers
ORDER BY CompanyName;