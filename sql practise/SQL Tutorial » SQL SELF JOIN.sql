							-- SQL SELF JOIN--

-- SQL Self Joýn

Sometimes, it is useful to join a table to itself. This type of join is known as the self-join.

We join a table to itself to evaluate the rows with other rows in the same table. To perform the 
self-join, we use either an inner join or left join clause.

--Because the same table appears twice in a single query, we have to use the table aliases.
--The following statement illustrates how to join a table to itself.

		SELECT
			column1,
			column2,
			column3,
				...
		FROM
			table1 A
		INNER JOIN table1 B ON B.column1 = A.column2;

SQL self-join examples

		SELECT 
			e.first_name ||' '|| e.last_name as employee,
			m.first_name ||' '|| m.last_name as maneger
		FROM 
		    employees e
				INNER JOIN 
			employees m ON e.employees_id = e.maneger_id
		ORDER BY maneger ;
			 