 
					---SQL Tutorial » SQL Logical Operators--

SQL Logical Operators

--The following table illustrates the SQL logical operators:

--Operator	Meaning

		ALL	Return true if all comparisons are true

		AND	Return true if both expressions are true

		ANY	Return true if any one of the comparisons is true.

		BETWEEN	Return true if the operand is within a range

		EXISTS	Return true if a subquery contains any rows

		IN	Return true if the operand is equal to one of the value in a list

		LIKE	Return true if the operand matches a pattern

		NOT	Reverse the result of any other Boolean operator.

		OR	Return true if either expression is true

		SOME	Return true if some of the expressions are true


	-- AND--
	-- The AND operator returns true if both expressions evaluate to true.

		SELECT 
			first_name, last_name, salary
		FROM 
			employees
		WHERE 
			salary > 5000 and salary < 7000
		ORDER BY
			salary

	-- OR--
	--the OR operator returns true if a least one expression evaluates to true.

		SELECT 
			first_name, last_name, salary
		FROM
			employees
		WHERE
			salary = 7000 OR salary = 8000
		ORDER BY salary;

  --IS NULL--

-- The IS NULL operator compares a value with a null value and returns true if the compared 
-- value is null; otherwise, it returns false.

		SELECT 
			first_name, last_name, phone_number
		FROM
			employees
		WHERE
			phone_number IS NULL
		ORDER BY first_name , last_name;

	--BETWEEN-
/*The BETWEEN operator searches for values that are within a set of values,
given the minimum value and maximum value. Note that the minimum and maximum values
are included as part of the conditional set.*/

		SELECT 
			first_name, last_name, salary 
		FROM 
			employees
		WHERE 
			salary BETWEEN 9000 and 12000
		ORDER BY salary;

	-- IN-- 

	/* The IN operator compares a value to a list of specified values.
The IN operator returns true if the compared value matches at least one
value in the list; otherwise, it returns false.*/
  
     SELECT 
	       first_name, last_name, department_id
	 FROM 
		   emplooyes
	 WHERE
		   department_id IN (8,9)
	ORDER BY department_id

	--LIKE--
--The LIKE operator compares a value to similar values using a wildcard operator.
--SQL provides two wildcards used in conjunction with the LIKE operator:

The percent sign ( %) represents zero, one, or multiple characters.
The underscore sign ( _) represents a single character.

--The following statement finds all employees whose first name starts with the string jo:

	SELECT 
		employee_id, first_name, last_name
	FROM
		employees
	WHERE
		first_name LIKE 'jo%'
	ORDER BY first_name;

--The following example finds all employees with the first names whose the second character is  h:

	SELECT 
		employee_id, first_name, last_name
	FROM
		employees
	WHERE
		first_name LIKE '_h%'
	ORDER BY first_name;


	--ALL--

--The ALL operator compares a value to all values in another value set. 
--The ALL operator must be preceded by a comparison operator and followed by a subquery.

	SELECT 
		first_name, last_name, salary
	FROM
		employees
	WHERE
		salary >= ALL (SELECT 
					salary
				FROM
					employees
				WHERE
					department_id = 8)
	ORDER BY salary DESC;
	
--ANY- 
--The ANY operator compares a value to any value in a set according to the condition as shown below:
--Similar to the ALL operator, the ANY operator must be preceded by a comparison operator and followed by a subquery.

		SELECT 
			first_name, last_name, salary
		FROM
			employees
		WHERE
			salary > ANY(SELECT 
					AVG(salary)
				FROM
					employees
				GROUP BY department_id)
		ORDER BY first_name , last_name; 


  --EXISTS--
--The EXISTS operator tests if a subquery contains any rows:
EXISTS (subquery)
-- If the subquery returns one or more rows, the result of the EXISTS is true; otherwise, the result is false.

For example, the following statement finds all employees who have dependents:

		SELECT 
			first_name, last_name
		FROM employees e
		WHERE
			EXISTS(SELECT 
					1
					FROM
						dependents d
					WHERE
					 d.employes_id = Ecommerge.emplyee_id) ;