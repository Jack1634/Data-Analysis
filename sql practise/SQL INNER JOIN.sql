

						--Home » SQL Tutorial » SQL INNER JOIN

The process of linking tables is called joining. SQL provides many kinds of joins such as inner join, 
left join, right join, full outer join, etc. This tutorial focuses on the inner join.

Suppose, you have two tables: A and B.

Table A has four rows: (1,2,3,4) and table B has four rows: (3,4,5,6)

When table A joins with table B using the inner join, you have the result set (3,4) that is the 
intersection of table A and table B.

For each row in table A, the inner join clause finds the matching rows in table B. If a row is matched,
it is included in the final result set.

Suppose the columns in the A and B tables are a and b. The following statement illustrates the inner join clause:

		SELECT a
		FROM A
		INNER JOIN B ON b = a;

For example, the following statement illustrates how to join 3 tables: A, B, and C:

		SELECT
		  A.n
		FROM A
		INNER JOIN B ON B.n = A.n
		INNER JOIN C ON C.n = A.n;

 SQL INNER JOIN examples

--To get the information of the department id 1,2, and 3, you use the following statement.

		SELECT 
			first_name,
			last_name,
			employees.department_id,
			departments.department_id,
			department_name
		FROM
			employees
				INNER JOIN
			departments ON departments.department_id = employees.department_id
		WHERE
			employees.department_id IN (1 , 2, 3);

--SQL INNER JOIN 3 tables example

	SELECT
		employees.first_name,
		employees.last_name,
		jobs.job_title,
		departments.department_name
	FROM employees
	INNER JOIN jobs 
	ON jobs.job_id = employees.job_id
	INNER JOIN  departments 
	ON employees.department_id = departments.departments_id
	WHERE 
	employees.department_id IN (1,2,3)


