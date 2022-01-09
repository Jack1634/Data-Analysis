								-- SQL Tutorial » SQL BETWEEN--

--SQL BETWEEN

Introduction to SQL BETWEEN operator
The BETWEEN operator is one of the logical operators in SQL. The BETWEEN operator checks if a 
value is within a range of values.

	The BETWEEN operator returns true if the expression is greater than or equal to ( >=) the low value
and less than or equal to ( <=) the high value.

	Technically, the BETWEEN is the equivalent to the following expression that uses the greater than
or equal to (>=) and less than or equal to (<=) operators:

--NOT BETWEEN

	The NOT BETWEEN returns true if the expression is less than low or greater than (>) high;
otherwise, it returns false.

	Like the BETWEEN operator, you can rewrite the NOT BETWEEN operator using the less than (<) 
and greater than (>) operators with the OR operator as follows:


--SQL BETWEEN operator examples

1) Using the SQL BETWEEN opeator with numbers example ;

	SELECT
		first_name,
		last_name,
		salary
	FROM 
	    employees
	WHERE 
		 salary between 2500 and 2900
	ORDER BY
		salary DESC;

The following query returns the same result set as the above query. 
However, it uses comparison operators greater than or equal to (>=) and less than or equal to (<=) instead:

	SELECT 
		employee_id, 
		first_name, 
		last_name, 
		salary
	FROM
		employees
	WHERE
		salary >= 2500 AND salary <= 2900
	ORDER BY 
		salary;

2) Using SQL NOT BETWEEN example

	SELECT
		first_name,
		last_name,
		salary
	FROM 
	    employees
	WHERE 
		 salary not between 2500 and 2900
	ORDER BY
		salary DESC;

3) Using SQL BETWEEN operator with a date ranges

The following example uses the BETWEEN operator to find all employees who joined the company 
between January 1, 1999, and December 31, 2000:

	SELECT
		first_name,
		last_name,
		hire_date
	FROM 
	    employees
	WHERE 
		 hire_date  between '1999-01-01' and '2000-12-31'
	ORDER BY
		hire_date DESC;

-- The following example uses the NOT BETWEEN operator to find employees who have not joined the company 
-- from January 1, 1989 to December 31, 1999:

	SELECT
		first_name,
		last_name,
		hire_date
	FROM 
	    employees
	WHERE 
		 hire_date  not between '1989-01-01' and '1999-12-31'
	ORDER BY
		hire_date DESC;

4) Using SQL BETWEEN operator with a function example


		SELECT 
			employee_id, 
			first_name, 
			last_name, 
			hire_date as joined_year
		FROM
			employees
		WHERE 
			CAST(strftime('%Y',hire_date) AS INTEGER) BETWEEN 1990 and 1993  