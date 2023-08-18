						--SQL Tutorial » SQL OR--

SQL OR


The SQL OR is a logical operator that combines two boolean expressions.
The SQL OR operator returns either true or false depending on the results of expressions.

-- SQL OR operator examples

	SELECT
		first_name,
		last_name,
		hire_date
	FROM
		employees
	WHERE
		CAST(strftime('%Y',hire_date) AS INTEGER) = 1997 OR 
		CAST(strftime('%Y',hire_date) AS INTEGER) = 1998
	ORDER BY
		first_name,
		last_name;

--- To find all employees who joined the company  in 1997 or 1997 and worked in the department id 3, 
-- you use both AND and OR operators as follows:

	SELECT
		first_name,
		last_name,
		hire_date
	FROM
		employees
	WHERE
		dept_id = 3 and 

		(CAST(strftime('%Y',hire_date) AS INTEGER) = 1997 OR 
		CAST(strftime('%Y',hire_date) AS INTEGER) = 1998)
	ORDER BY
		first_name,
		last_name;

--For example, the following query finds all employees who joined the company in 1990 or 1999 or 2000.

	SELECT
		first_name,
		last_name,
		hire_date
	FROM
		employees
	WHERE
		CAST(strftime('%Y',hire_date) AS INTEGER) = 1990  OR 
		CAST(strftime('%Y',hire_date) AS INTEGER) = 1999  OR
		CAST(strftime('%Y',hire_date) AS INTEGER) = 2000  OR

	ORDER BY
		first_name,
		last_name;

-- You can replace the OR operators by the IN operator as follows:

	SELECT
		first_name,
		last_name,
		hire_date
	FROM
		employees
	WHERE
		CAST(strftime('%Y',hire_date) AS INTEGER) IN (2000,1999,1990)
		
	ORDER BY
		first_name,
		last_name;

