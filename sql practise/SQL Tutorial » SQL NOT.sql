							
							--SQL Tutorial » SQL NOT

Introduction to the SQL NOT operator

--You have learned how to use various logical operators such as AND, OR, LIKE, BETWEEN, IN, and EXISTS.
--These operators help you to form flexible conditions in the WHERE clause.

To negate the result of any Boolean expression, you use the NOT operator. 
The following illustrates how to use the NOT operator:

NOT [Boolean_expression]

							--SQL NOT operator examples


--The following statement retrieves all employees who work in the department id 5 :

		SELECT
			first_name,
			last_name,
			department_id,
			salary

		FROM
			employees
		WHERE
			department_id = 5
		ORDER BY 
			salary;

--To get the employees who work in the department id 5 and with a salary not greater than 5000.

		SELECT
			first_name,
			last_name,
			department_id,
			salary
		FROM
			employees
		WHERE
			department_id = 5 and not salary > 5000
		ORDER BY 
			salary;

--SQL NOT with IN operator example

--To negate the IN operator, you use the NOT operator. 
--For example, the following statement gets all the employees who are not working in the departments 1, 2, or 3.

			SELECT
				 first_name,
				 last_name,
				 department_id,
				 salary
			FROM
				employees
			WHERE
				department_id NOT IN (1,2,3)
			ORDER BY
				first_name

--SQL NOT LIKE operator example
--You can negate the LIKE operator by using the NOT LIKE. For example, 
--the following statement retrieves all the employees whose first names do not start with the letter D.

			SELECT 
				first_name
				last_name
			FROM
				employees
			WHERE first_name NOT LIKE '%D'
			ORDER BY
				first_name

--SQL NOT BETWEEN example

--The following example shows you how to use the NOT to negate the BETWEEN 
-- operator to get employees whose salaries are not between 5,000 and 1,000.

			SELECT
				 first_name,
				 last_name
				 salary
			FROM
				 employees
			WHERE SALARY NOT BETWEEN 1000 AND 5000
			ORDER BY salary;

-- SQL NOT EXISTS example

--The following query uses the NOT EXISTS operator to get the employees who do not have any dependents.

			SELECT 
				first_name,
				last_name,
				employee_id,
			FROM
				employees e
			WHERE
			    NOT EXIST ( SELECT
								employee_id
						    FROM
								dependents d
						    WHERE 
							    d.employee_id = e.employee_id) ;
									       
									       

												
