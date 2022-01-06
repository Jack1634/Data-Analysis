												--SQL ORDER BY--

SQL ORDER BY

--The following shows the syntax of the ORDER BY clause;

SELECT 
    select_list
FROM
    table_name
ORDER BY 
    sort_expression [ASC | DESC];

-- The ORDER BY clause also allows you to sort the result set by multiple expressions. 
-- In this case, you need to use a comma to separate two sort expressions:

	SELECT 
		select_list
	FROM
		table_name
	ORDER BY 
		sort_expression_1 [ASC | DESC],
		sort_expression_2 [ASC | DESC];

-- SQL ORDER BY clause examples
-- We’ll use the employees table in the sample database for the demonstration.

1) Using SQL ORDER BY clause to sort values in one column example

	SELECT
	      empoyee_id,
		  first_name,
		  last_name,
		  hire_date,
		  salary
	FROM
		  employees

    ORDER BY 
	      first_name;

2) Using SQL ORDER BY  clause to sort values in multiple columns example
 
   SELECT
	      empoyee_id,
		  first_name,
		  last_name,
		  hire_date,
		  salary
	FROM
		  employees

    ORDER BY 
	      first_name,
		  last_name DESC;

3) Using SQL ORDER BY clause to sort values in a numeric column example

	SELECT
		employee_id,
		first_name,
		last_name,
		hire_date,
		salary
	FROM
		employees
	ORDER BY
		salary DESC;

4) Using SQL ORDER BY to sort by dates example
	
	SELECT
		employee_id,
		first_name,
		last_name,
		hire_date,
		salary
	FROM
		employees
	ORDER BY
		hire_date;

---Summary
--Use the ORDER BY clause to sort rows returned by the SELECT clause.
--Use the ASC option to sort rows in ascending order and DESC option to sort rows in descending order.