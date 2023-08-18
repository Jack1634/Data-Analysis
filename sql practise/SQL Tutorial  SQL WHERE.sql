							
							      -- SQL Tutorial SQL WHERE--

-- Introduction to SQL WHERE clause

To select specific rows from a table, you use a WHERE clause in the SELECT statement. 
The following illustrates the syntax of the WHERE clause in the SELECT statement:

	SELECT 
		column1, column2, ...
	FROM
		table_name
	WHERE
		condition;

-- SQL WHERE examples

SQL WHERE clause with numeric comparison examples
/*
The following query finds employees who have salaries greater than 14,000 
and sorts the result set based on the salary in descending order.
*/

		SELECT
			employee_id,
			first_name,
			last_name,
			salary
		FROM
			employees
		WHERE
			salary > 14000
		ORDER BY
			salary DESC;

-- The following query finds all employees who work in the department id 5.
		
		SELECT
			employee_id,
			first_name,
			last_name,
			salary
		FROM
			employees
		WHERE
			department_id = 5
		ORDER BY
			first_name ;
			
-- SQL WHERE clause with characters example

		SELECT 
			employee_id,
			first_name,
			last_name,
		FROM
			employees
		WHERE
			last_name='Chen';

-- SQL WHERE clause with dates examples

		SELECT
			employee_id,
			first_name,
			last_name,
			hire_date
		FROM
			employeees
		WHERE
		    hire_date >= '1999-01-01'
		ORDER BY
			hire_date DESC;

-- If you want to find the employees who joined the company in 1999, you have several ways:

	Use the YEAR function to get the year data from the hire_date column and use the equal to (=) operator to form the expression.
	Use two expressions with the AND operator.
	Use the BETWEEN operator.
	The following statement illustrates the first way:

	SELECT
		employee_id,
		first_name,
		last_name,
	FROM
		employees
	WHERE
		YEAR(hire_date) = 1999
	ORDER BY 
		hire_date DESC;

