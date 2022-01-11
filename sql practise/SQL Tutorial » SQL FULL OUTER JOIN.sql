									--SQL FULL OUTER JOIN

--Introduction to SQL FULL OUTER JOIN clause

In theory, a full outer join  is  the  combination  of  a left join and a right join.
The full outer join includes all rows from the joined tables whether or not the other
table has the matching row.

If the rows in the joined tables do not match, the result set of the full outer join contains
NULL values for every column of the table that lacks a matching row. For the matching rows, a 
single row that has the columns populated from the joined table is included in the result set.

The following statement illustrates the syntax of the full outer join of two tables:

	SELECT column_list
	FROM A
	FULL OUTER JOIN B ON B.n = A.n;

--SQL FULL OUTER JOIN examples

First, create two new tables: baskets and fruits for the demonstration. 
Each basket stores zero or more fruits and each fruit can be stored in zero or one basket.
--firstly : 		
			CREATE TABLE fruits (
			fruit_id INTEGER PRIMARY KEY,
			fruit_name VARCHAR (255) NOT NULL,
			basket_id INTEGER
			);

			CREATE TABLE basket (
			basket_id INTEGER PRIMARY KEY,
			basket_name VARCHAR (255) NOT NULL);

--secondly :
			INSERT IN TO baskets(basket_ýd, basket_name)
			VALUES
					(1,'A')
					(2,'B')
					(3,'C')
					
			INSERT IN TO fruits(fruit_id,
						 fruit_name,
						 basket_id)
			VALUES 
					(1, 'Apple', 1),
					(2, 'Orange',1),
					(3, 'Banana' 2),
					(4, 'Strawberry',NULL);

Third, the following query returns each fruit that is in a basket and each basket that has a fruit,
but also returns each fruit that is not in any basket and each basket that does not have any fruit.

		SELECT 
			  basket_name,
			  fruit_name
		FROM
			  fruits
		FULL OUTER JOIN baskets ON fruits baskets.baskets_id = fruits.fruits_id

--For example, to find the empty basket, which does not store any fruit, you use the following statement:
		
		SELECT 
			  basket_name,
			  fruit_name
		FROM
			  fruits
		FULL OUTER JOIN baskets ON fruits baskets.baskets_id = fruits.fruits_id
		WHERE fruit_name = IS NULL;

--Similarly, if you want to see which fruit is not in any basket, you use the following statement:

		SELECT
			basket_name,
			fruit_name
		FROM
			fruits
		FULL OUTER JOIN baskets ON baskets.basket_id = fruits.basket_id
		WHERE
			basket_name IS NULL;

