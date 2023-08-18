					--SQL Tutorial SQL FETCH--

SQL FETCH

Introduction to SQL FETCH clause

/*
	To limit the number of rows returned by a query, you use the LIMIT clause. The LIMIT clause is widely supported by many database systems such as MySQL, H2, and HSQLDB. However, the LIMIT clause is not in SQL standard.

SQL:2008 introduced the OFFSET FETCH clause which has a similar function to the LIMIT clause. The OFFSET FETCH clause allows you to skip N first rows in a result set before starting to return any rows.

The following shows the syntax of the SQL FETCH clause:

	OFFSET offset_rows { ROW | ROWS }
	FETCH { FIRST | NEXT } [ fetch_rows ] { ROW | ROWS } ONLY

*/
 
   In this syntax:

--The ROW and ROWS, FIRST and NEXT are the synonyms.
--Therefore, you can use them interchangeably.
--The offset_rows is an integer number which must be zero or positive.
--In case the offset_rows is greater than the number of rows in the result set, no rows will be returned.
--The fetch_rows is also an integer number that determines the number of rows to be returned.
--The value of fetch_rows is equal to or greater than one.

	SQL FETCH examples

--The following statement returns the first employee who has the highest salary:

	SELECT 
		employee_id, 
		first_name, 
		last_name, 
		salary
	FROM employees
	ORDER BY 
		salary DESC
	OFFSET 0 ROWS
	FETCH NEXT 1 ROWS ONLY;

-- The following statement sorts the employees by salary, skips the first five employees with the highest salary, 
-- and fetches the next five ones.

	SELECT 
		employee_id, 
		first_name, 
		last_name, 
		salary
	FROM employees
	ORDER BY 
		salary DESC
	OFFSET 5 ROWS
	FETCH NEXT 5 ROWS ONLY;

--Summary

-- Use the SQL FETCH clause to limit the number of rows returned by a query.

-- The SQL FETCH clause skips N rows in a result set before starting to return any rows.