					
					--SQL Tutorial » SQL IN--

Introduction to SQL IN Operator

The IN is a logical operator in SQL. The IN operator returns true if a value
is in a set of values or false otherwise.

-- SQL IN examples

	SELECT
		employee_id,
		first_name,
		last_name,
		job_id
	FROM
		employees
	WHERE
		job_id IN (8, 9, 10)
	ORDER BY
		job_id;

-- The following example uses the NOT IN operator to find employees whose job’s id is neither 7, 8, nor 9:

		SELECT
			employee_id,
			first_name,
			last_name,
			job_id
		FROM
			employees
		WHERE
			job_id NOT IN (7,8, 9)
		ORDER BY
			job_id;

2) Using SQL IN opeator with a subquery example

		SELECT 
			department_id
		FROM
			departments
		WHERE
			department_name = 'Marketing' OR 
			department_name = 'Sales'

And you can pass the id list to the IN operator to find employees who work in 
the Marketing and Sales departments like this:

		SELECT
			employee_id,
			first_name,
			last_name,
			department_id
		FROM
			employees
		WHERE
			department_id IN (2, 8);

--To combine two above queries into a single query, you can use the first query in place of the list inside parentheses followed the IN operator:
		
		SELECT 
			employee_id, first_name, last_name, salary
		FROM
			employees
		WHERE
			department_id IN (SELECT 
								department_id
							FROM
								departments
							WHERE
								department_name = 'Marketing'
								OR department_name = 'Sales')