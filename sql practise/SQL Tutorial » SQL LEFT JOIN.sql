
							 --SQL LEFT JOIN

SQL LEFT JOIN


The left join, however, returns all rows from the left table whether or not there is a matching 
row in the right table.

Suppose we have two tables A and B. The table A has four rows 1, 2, 3 and 4. The table B also has 
four rows 3, 4, 5, 6.

When we join table A with table B, all the rows in table A (the left table) are included in the result 
set whether there is a matching row in the table B or not.

In SQL, we use the following syntax to join table A with table B.

		SELECT
			A.n
		FROM
			A
		LEFT JOIN B ON B.n = A.n;

--SQL LEFT JOIN examples

Let’s take a look at the countries and locations tables.

Now, we use the LEFT JOIN clause to join the countries table with the locations
table as the following query:

		SELECT 
			countries.country_name,
			locations.street_address,
			locations.city
		FROM countries
		LEFT JOIN locations
		on countries.country_id = locations.country_id
		WHERE countries.country_id IN ('US','UK','CN')


--For example, to find the country that does not have any locations in the locations table, you use the following query:

		SELECT
			country_name
		FROM
			countries c
		LEFT JOIN locations l ON l.country_id = c.country_id
		WHERE
			l.location_id IS NULL
		ORDER BY
			country_name;

--SQL LEFT JOIN 3 tables example

		SELECT
			r.region_name,
			c.country_name,
			l.street_address,
			l.city
		FROM
			regions r
		LEFT JOIN countries c ON c.region_id = r.region_id
		LEFT JOIN locations l ON l.country_id = c.country_id
		WHERE
			c.country_id IN ('US', 'UK', 'CN');


