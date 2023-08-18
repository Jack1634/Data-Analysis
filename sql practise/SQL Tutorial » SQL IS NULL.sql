								----Home » SQL Tutorial » SQL IS NULL

--What is NULL

   * NULL is special in SQL. NULL indicates that the data is unknown, inapplicable, or even does not exist. 
In other words, NULL represents the missing data in the database.
For example, if employees do not have phone numbers, you can store their phone numbers as empty strings.
However, if you don’t know their phone numbers when you save the employee records, you need to use the NULL for the unknown phone numbers.

The NULL is special because any comparisons with a NULL can never result in true or false, but in a third logical result, unknown.

--The following statement returns NULL:

SELECT NULL = 5

--The NULL value is not even equal to itself, as shown in the following statement:

SELECT NULL = NULL

--You cannot use the comparison operator equal to (=) to compare a value to a NULL value.
--For example, the following statement will NOT RETURN THE CORRECT RESULT:

		SELECT
			employee_id,
			first_name,
			last_name,
			phone_number
		FROM
			employees
		WHERE
			phone_number = NULL;

--The IS NULL and IS NOT NULL operators

To determine whether an expression or column is NULL or not, you use the IS NULL operator

If the result of the expression is NULL, IS NULL operator returns true; otherwise, it returns false.

To check if an expression or column is not NULL, you use the IS NOT operator.

--SQL IS NULL and IS NOT NULL examples

--To find all employees who do not have the phone numbers, you use the IS NULL operator as follows:

		SELECT
			employee_id,
			first_name,
			last_name,
			phone_number
		FROM
			employees
		WHERE
			phone_number = ISNULL;

--To find all employees who have phone numbers, you use IS NOT NULL as shown in the following statement:

		SELECT
			employee_id,
			first_name,
			last_name,
			phone_number
		FROM
			employees
		WHERE
			phone_number = IS NOT NULL;