						--SQL Tutorial » SQL CROSS JOIN

SQL CROSS JOIN

--Introduction to SQL CROSS JOIN clause

A cross join is a join operation that produces the Cartesian product of two or more tables.

In Math, a Cartesian product is a mathematical operation that returns a product set of multiple sets.

For example, with two sets A {x,y,z} and B {1,2,3}, the Cartesian product of A x B is the set of all
ordered pairs (x,1), (x,2), (x,3), (y,1) (y,2), (y,3), (z,1), (z,2), (z,3).

Similarly, in SQL, a Cartesian product of two tables A and B is a result set in which each row in the
first table (A) is paired with each row in the second table (B). Suppose the A table has n rows and 
the B table has m rows, the result of the cross join of the A and B tables have n x m rows.


-- SQL CROSS JOIN example
 
 We will create two new tables  for the demonstration of the cross join:

 sales_organization table stores the sale organizations.

 sales_channel table stores the sales channels.

	 CREATE TABLE sales_organization (
		sales_org_id INT PRIMARY KEY,
		sales_org VARCHAR (255)
	);

	CREATE TABLE sales_channel (
	channel_id INT PRIMARY KEY,
	channel VARCHAR (255)
	);

	INSERT INTO sales_organization (sales_org_id, sales_org)
	VALUES
	(1, 'Domestic'),
	(2, 'Export');

	INSERT INTO sales_channel (channel_id, channel)
	VALUES
	(1, 'Wholesale'),
	(2, 'Retail'),
	(3, 'eCommerce'),
	(4, 'TV Shopping');

--To find the all possible sales channels that a sales organization can have, you use the CROSS JOIN 
--to join the sales_organization table with the sales_channel table as follows:

		SELECT 
			sales_org,
			channel
		FROM
			sales_organization
		CROSS JOIN sales_channel;

--The result set includes all possible rows in the sales_organization and sales_channel tables.

--The following query is equivalent to the statement that uses the CROSS JOIN clause above:

		SELECT
			sales_org,
			channel
		FROM
			sales_organization,
			sales_channel;