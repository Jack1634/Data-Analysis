
--Understanding the SQL Server CASE statement

--Execute the following script to create the dummy data:

CREATE TABLE Cars
(
    id INT,
    name VARCHAR(50) NOT NULL,
    company VARCHAR(50) NOT NULL,
    power INT NOT NULL,
    color VARCHAR(50) NOT NULL,
    model INT NOT NULL,
    condition VARCHAR(50) NOT NULL
 )
 --Now let’s insert some dummy data into the Cars table. 

 INSERT INTO Cars
 
VALUES
(1, 'Corrolla', 'Toyota', 1800, 'red', 1995, 'X'),
(2, 'City', 'Honda', 1500 , 'black', 2015, 'X'),
(3, 'C200', 'Mercedez', 2000 , 'white', 1992, 'X'),
(4, 'Vitz', 'Toyota', 1300 , 'blue', 2007, 'X'),
(5, 'Baleno', 'Suzuki', 1500 , 'white', 2012, 'X'),
(6, 'C500', 'Mercedez', 5000 , 'grey', 1994, 'X'),
(7, '800', 'BMW', 8000 , 'blue', 2016, 'X'),
(8, 'Mustang', 'Ford', 5000 , 'red', 1997, 'X'),
(9, '208', 'Peugeot', 5400, 'black', 1999, 'X'),
(10, 'Prius', 'Toyota', 3200 , 'red', 2003, 'X')

---Let’s check how our dataset looks, execute the following script:

SELECT * FROM Cars

-- CASE statement examples

--1. The condition column had the value X for all rows. We will use the SQL Server CASE statement
--to set the value of the condition column to “New” if the model column has a value greater than 2000, 
--otherwise the value for the condition column will be set to “Old”.


select name, 
       model,
	   case when model > 2000 then 'New'
	    else 'old' end as conditon
		from cars

-- Multiple conditions in CASE statement

--Let’s write a SQL Server CASE statement which sets the value of the condition column to “New” if the value 
--in the model column is greater than 2010, to ‘Average’ if the value in the model column is greater than 2000, 
--and to ‘Old’ if the value in the model column is greater than 1990.

 -- first Solution 

   SELECT name,
       model,
       CASE WHEN model > 2010 THEN 'New'
      WHEN model > 2000 THEN 'Average'
      WHEN model > 1990 THEN 'Old'
                ELSE 'Old' END AS condition
  FROM Cars

																									
-- Second Solution 

	SELECT name,
		   model,
		   CASE WHEN model > 2010 THEN 'New'
		  WHEN model > 2000 AND model <2010 THEN 'Average'
		  WHEN model > 1990 AND model <2000 THEN 'Old'
				ELSE 'Old' END AS condition
	  FROM Cars

--2. In the following example, we will assign the value of “New White” to the condition column
--where the model is greater than 2010 and the color is white.

SELECT name,
     color,
       model,
       CASE WHEN model > 2010 AND color = 'white' THEN 'New White'
      WHEN model > 2010 THEN 'New'
      WHEN model > 2000 AND model <2010 THEN 'Average'
      WHEN model > 1990 AND model <2000 THEN 'Old'
            ELSE 'Old' END AS condition
  FROM Cars

 

-- Using GROUP BY with SQL Server CASE statement

SELECT 
       CASE WHEN model > 2000 THEN 'New'
            ELSE 'Old' END AS condition,
      COUNT(1) AS count
  FROM Cars
  GROUP BY CASE WHEN model > 2000 THEN 'New'
            ELSE 'Old' END


--we can GROUP BY more than two values.

SELECT 
       CASE WHEN model > 2010 THEN 'New'
      WHEN model > 2000 THEN 'Average'
      WHEN model > 1990 THEN 'Old'
            ELSE 'Old' END AS condition,
      COUNT(1) AS count
  FROM Cars
  GROUP BY CASE WHEN model > 2010 THEN 'New'
      WHEN model > 2000 THEN 'Average'
      WHEN model > 1990 THEN 'Old'
            ELSE 'Old' END