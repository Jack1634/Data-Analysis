
					-- SQL Tutorial » SQL Comparison Operators--

-- SQL Comparison Operators

	Operator	Meaning

	=	Equal
	<>	Not equal to
	>	Greater than
	>=	Greater than or equal to
	<	Less than
	<=	Less than or equal to

--Equal to operator(=)

	SELECT employee_id, first_name, last_name
	FROM employees
	WHERE last_name = 'Himoro'

-- To compare null values, you use the IS NULL operator instead:
    
	SELECT employee_id, first_name, last_name
	FROM employees
	WHERE pnhone_number = IS NULL

--Not equal to operator (<>)

   SELECT 
		employee_id, first_name, last_name
   FROM 
        employees
   WHERE 
        department_id <> 8
   ORDER BY firts_name, last_name

   You can use the AND operator to combine multiple expressions that use the not equal to (<>)
   operator. For example, the following statement finds all employees whose department id 
   is not eight and ten.

	SELECT 
		employee_id, first_name, last_name, department_id
	FROM
		employees
	WHERE
		department_id <> 8
			AND department_id <> 10
	ORDER BY first_name , last_name; 

-- Greater than operator (>)

	SELECT 
		employee_id, first_name, last_name, salary
	FROM
		employees
	WHERE
		salary > 10000
	ORDER BY salary DESC;

--You can combine expressions that use various comparison operators using the AND or OR operator.
--For example, the following statement finds employees in department 8 and have the salary greater 
--than 10,000:

SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary > 10000 AND department_id = 8
ORDER BY salary DESC;

--Less than operator (<)

	SELECT 
		employee_id, first_name, last_name, salary
	FROM
		employees
	WHERE
		salary < 10000
	ORDER BY salary DESC;

--Greater than or equal operator (>=)

	SELECT 
		employee_id, first_name, last_name, salary
	FROM
		employees
	WHERE
		salary >= 9000
	ORDER BY salary;

-- Less than or equal to operator(<=)

	SELECT 
		employee_id, first_name, last_name, salary
	FROM
		employees
	WHERE
		salary <=9000
	ORDER BY salary;