						 --SQL Tutorial » SQL Alias

--SQL Alias

SQL alias allows you to assign a table or a column a temporary name during the execution of a query. 
SQL has two types of aliases: table and column aliases.

--SQL column aliases

The following example shows how to use the column aliases:

		SELECT
			inv_no AS invoice_no,
			amount,
			due_date AS 'Due date',
			cust_no 'Customer No'
		FROM
			invoices;

--Aliases for expressions

		SELECT 
			first_name, 
			last_name, 
			salary * 1.1 AS new_salary
		FROM
			employees;


--Common mistakes of column aliases

		SELECT 
			first_name, 
			last_name, 
			salary * 1.1 AS new_salary
		FROM
			employees
		WHERE new_salary > 5000

Error: 
     Unknown column 'new_salary' in 'where clause'
why ?
In this SELECT statement, the database evaluates the clauses in the following order:

  FROM > WHERE > SELECT

/*The database evaluates the WHERE clause before the SELECT clause.
Therefore, at the time it evaluates the WHERE clause, the database 
doesn’t have the information of the new_salary column alias. So it issued an error.*/

However, the following query works correctly:

	SELECT 
		first_name, 
		last_name, 
		salary * 1.1 AS new_salary
	FROM
		employees
	ORDER BY new_salary;

In this example, the database evaluates the clauses of the query in the following order:

FROM > SELECT > ORDER BY

--SQL table aliases

To assign an alias to a table, you use the following syntax:

table_name AS table_alias

SELECT 
    e.first_name, 
    e.last_name
FROM
    employees AS e;