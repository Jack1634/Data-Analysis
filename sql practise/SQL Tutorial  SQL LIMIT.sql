								-- SQL Tutorial SQL LIMIT--

SQL LIMIT

-- Introduction to SQL LIMIT clause

To limit the number of rows returned by a select statement, you use the LIMIT and OFFSET clauses.

		SELECT 
			column_list 
		FROM 
			table1
		ORDER BY column_list
		LIMIT row_count OFFSET offset;

In this syntax:

** The LIMIT row_count determines the number of rows (row_count) returned by the query.
** The OFFSET offset clause skips the offset rows before beginning to return the rows.

SQL LIMIT clause examples ;

		SELECT 
			employee_id, 
			first_name, 
			last_name
		FROM
			employees
		ORDER BY 
			first_name
		LIMIT 5;

-- The following example uses both LIMIT & OFFSET clauses to return five rows starting from the 4th row:

	SELECT 
		employee_id, first_name, last_name
	FROM
		employees
	ORDER BY first_name
	LIMIT 5 OFFSET 3;

---In MySQL, you can use the shorter form of the LIMIT & OFFSET clauses like this:

	SELECT 
		employee_id, 
		first_name, 
		last_name
	FROM
		employees
	ORDER BY 
		first_name
	LIMIT 3 , 5;

-- Using SQL LIMIT to get the top N rows with the highest or lowest value

	SELECT 
		employee_id, 
		first_name, 
		last_name, 
		salary
	FROM
		employees
	ORDER BY 
		salary DESC
	LIMIT 5;

-- Getting the rows with the Nth highest value

	 SELECT 
		employee_id, 
		first_name, 
		last_name, 
		salary
	FROM
		employees
	ORDER BY 
		salary DESC
	LIMIT 1 OFFSET 1;

/*The ORDER BY clause sorts the employees by salary in descending order. And the LIMIT 1 OFFSET 1 clause gets the second row from the result set.

This query works with the assumption that every employee has a different salary. It will fail if there are two employees who have the same highest salary.

Also, if you have two or more employees who have the same 2nd highest salary, the query just returns the first one.

To fix this issue, you can get the second highest salary first using the following statement.*/

	SELECT DISTINCT
		salary
	FROM
		employees
	ORDER BY salary DESC
	LIMIT 1 , 1;

-- If you know subquery, you can combine both queries into a single query as follows:

	SELECT
		  employee_id, firts_name, last_name, salary
	FROM
		 employees
	WHERE 
	     salary =(SELECT DISTINCT
		          salary
			FROM
				employees
			ORDER BY salary DESC
			LIMIT 1, 1 )

--Summary

--Use LIMIT & OFFSET clauses to limit the number of rows returned by a query.
--LIMIT & OFFSET is not SQL standard.