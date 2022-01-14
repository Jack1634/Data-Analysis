								
								--SQL LIKE

--Introduction to SQL LIKE operator
--The LIKE operator is one of the SQL logical operators. The LIKE operator returns true if a value matches a pattern or false otherwise.

expression LIKE pattern

In this syntax, the LIKE operator tests whether an expression matches the pattern. The SQL standard provides you with two wildcard characters to make a pattern:

 % percent wildcard matches zero, one, or more characters

 _ underscore wildcard matches a single character.

The following show an example of using the % and _ wildcard characters:

	Expression	Meaning

	LIKE 'Kim%'	match a string that starts with Kim

	LIKE '%er'	match a string that ends with er

	LIKE '%ch%'	match a string that contains ch

	LIKE 'Le_'	match a string that starts with Le and is followed by one character e.g., Les, Len…

	LIKE '_uy'	match a string that ends with uy and is preceded by one character e.g., guy

	LIKE '%are_'	match a string that contains are and ends with one character

	LIKE '_are%'	match a string that contains are, starts with one character, and ends with any number of characters

												--- NOT LIKE---

The NOT LIKE operator returns true if the expression doesn’t match the pattern or false otherwise.

												--Escape character

To match a string that contains a wildcard for example 10%, you need to instruct the LIKE operator to treat the % in 10% as a regular character.

To do that, you need to explicitly specify an escape character after the ESCAPE clause:

For example:

value LIKE '%10!%%' ESCAPE '!'

--SQL LIKE operator examples

--The following example uses the LIKE operator to find all employees whose first names start with Da :

		SELECT
			first_name,
			last_name
		FROM
			employees
	    WHERE first_name LIKE 'DA%';

--The following example use the LIKE operator to find all employees whose first names end with er:

		SELECT
			first_name,
			last_name
		FROM
			employees
	    WHERE first_name LIKE '%er';

--The following example uses the LIKE operator to find employees whose last names contain the word an:

		SELECT
			first_name,
			last_name
		FROM
			employees
	    WHERE last_name LIKE '%an%';

--The following statement retrieves employees whose first names start with Jo and are followed by at most 2 characters:

			SELECT 
				 first_name,
				 last_name
			FROM
				 employees
			WHERE
				first_name LIKE 'jo__'

--The following statement uses the LIKE operator with the % and _ wildcard to find employees whose first names start with 
--any number of characters and are followed by at most one character:

			SELECT 
				 first_name,
				 last_name
			FROM
				 employees
			WHERE
				first_name LIKE '%are_'

										--SQL NOT LIKE operator example

--The following example uses the NOT LIKE operator to find all employees whose first names start with
--the letter S but not start with Sh:

			SELECT 
				  first_name,
				  last_name
			FROM
				employees
			WHERE
				first_name NOT LIKE  'Sh%'
			    and first_name LIKE  'S%'
			ORDER BY
				first_name

--Summary

--The LIKE operator returns true if a value matches a pattern or false otherwse.

--Use the NOT operator to negate the LIKE opeator.

--Use the % wildcard to match one or more characters

--Use the _ wildcard to match a single character.
