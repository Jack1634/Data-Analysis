
			---Home » SQL Tutorial » SQL AND-----

SQL AND

The AND operator is a logical operator that combines two Boolean expressions in the WHERE clause of 
the SELECT, UPDATE, or DELETE statement. 

The AND operator returns true if both expressions evaluate to true. If one of the two expressions is 
false, then the AND operator returns false even one of the expressions is NULL.

	SELECT
		 first_name,
		 last_name,
		 job_id,
		 salary
	FROM
		employees
	WHERE
		Job_id = 9
	AND salary > 5000

To find all the employees who joined the company between 1997 and 1998, you use the AND operator 
as follows:

	SELECT
		 first_name,
		 last_name,
		 job_id,
		 salary
	FROM
		employees
	WHERE
		hire_date between 1997 and 1998
