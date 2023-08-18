							--SQL Tutorial---

    SQL SELECT

-- We’ll use the employees table in the sample database for demonstration purposes.

SQL SELECT statement examples

1) SQL SELECT – selecting data from all columns example

		SELECT * FROM employees;

2) SQL SELECT – selecting data from specific columns
       SELECT 
			employee_id, 
			first_name, 
			last_name, 
			hire_date
	   FROM
			employees;

3) SQL SELECT – performing a simple calculation

		SELECT 
		first_name, 
		last_name, 
		salary, 
		salary * 1.05
		FROM
		employees;

-- Summary

--Use the SQL SELECT statment to select data from a table.
--To select data from a table, specify the table name in the FROM clause and a list of column in the SELECT clause.
--The SELECT * is the shorthand of the SELECT all columns in a table.


