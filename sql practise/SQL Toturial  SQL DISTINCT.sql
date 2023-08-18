								
								--SQL Tutorial  SQL DISTINCT

SQL DISTINCT

--Introduction to SQL DISTINCT operator

---To remove duplicate rows from a result set, you use the DISTINCT operator in the SELECT clause as follows:

	SELECT DISTINCT 
			column1, column2, ...
	FROM 
			table1;

-- SQL DISTINCT examples

--We will use the employees table in the sample database to demonstrate how the DISTINCT operator works.

1) Using SQL DISTINCT operator on one column example

	SELECT
		DISTINCT salary 
	FROM 
		employees 
	ORDER  BY salary DESC ; 

2) Using SQL DISTINCT operator on multiple columns example

	SELECT DISTINCT
		job_id,
		salary
	FROM
		employees
	ORDER By
		job_id,
		salry DESC;

									--SQL DISTINCT and NULL--

-- Typically, the DISTINCT operator treats all NULL the same. 
-- Therefore, the DISTINCT operator keeps only one NULL in the result set.

   SELECT DISTINCT phone_number
   FROM employees
   ORDER By phone number

--Summary
--Use DISTINCT operator in the SELECT clause to remove duplicate rows from the result set.