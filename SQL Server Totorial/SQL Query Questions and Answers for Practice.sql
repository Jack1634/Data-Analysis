USE ORG;

--DROP TABLE IF EXISTS Title,Bonus,Worker;

	CREATE TABLE Worker (
		WORKER_ID INT NOT NULL PRIMARY KEY,
		FIRST_NAME CHAR(250),
		LAST_NAME CHAR(25),
		SALARY INT NOT NULL,
		JOINING_DATE DATETIME,
		DEPARTMENT CHAR(250)
	);

	INSERT INTO Worker (WORKER_ID,FIRST_NAME, 
						LAST_NAME, 
						SALARY, 
						JOINING_DATE,
						DEPARTMENT) VALUES
			(001,'Monika', 'Arora', 100000,   '10/02/14' , 'HR'),
			(002,'Niharika', 'Verma', 80000,  '11/06/14' , 'Admin'),
			(003,'Vishal', 'Singhal', 300000, '12/02/14' , 'HR'),
			(004,'Amitabh', 'Singh', 500000,  '11/02/14' , 'Admin'),
			(005,'Vivek', 'Bhati', 500000,    '11/06/14' , 'Admin'),
			(006,'Vipul', 'Diwan', 200000,    '11/06/14' , 'Account'),
			(007,'Satish', 'Kumar', 75000,    '9/01/14' , 'Account'),
			(008,'Geetika', 'Chauhan', 90000, '11/04/14' , 'Admin');

	select * from Worker;

	CREATE TABLE Bonus (
		WORKER_REF_ID INT,
		BONUS_AMOUNT INT,
		BONUS_DATE DATETIME,
		FOREIGN KEY (WORKER_REF_ID)
			REFERENCES Worker(WORKER_ID)
			ON DELETE CASCADE
	);

	INSERT INTO Bonus 
		(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
			(001, 5000, '12-02-14'),
			(002, 3000, '11-06-14'),
			(003, 4000, '10-02-14'),
			(001, 4500, '09-02-14'),
			(002, 3500, '11-06-14');


	CREATE TABLE Title (
		WORKER_REF_ID INT,
		WORKER_TITLE CHAR(25),
		AFFECTED_FROM DATETIME,
		FOREIGN KEY (WORKER_REF_ID)
			REFERENCES Worker(WORKER_ID)
			ON DELETE CASCADE
	);  

	INSERT INTO Title 
		(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
	(001, 'Manager', '11/02/2016'),
	(002, 'Executive', '11-06-2016'),
	(008, 'Executive', '11-06-2016'),
	(005, 'Manager', '11-06-2016'),
	(004, 'Asst. Manager', '11-06-2016'),
	(007, 'Executive', '11-06-2016'),
	(006, 'Lead', '11-06-2016'),
	(003, 'Lead', '11-06-2016');


	select * from title;

--Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.

	SELECT FIRST_NAME FROM Worker AS WORKER_NAME;


 --Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
 
 	SELECT UPPER(FIRST_NAME) FROM Worker;

 -- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
 
 	SELECT DISTINCT DEPARTMENT FROM Worker;

 --Q-4. Write an SQL query to print the first three characters of FIRST_NAME from Worker table.

 	SELECT SUBSTRING(FIRST_NAME, 1, 3) FROM Worker;

--Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.

	SELECT CHARINDEX('a', FIRST_NAME) FROM Worker WHERE FIRST_NAME = 'Amitabh';

--Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.

	SELECT RTRIM(FIRST_NAME) FROM Worker;

--Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.

	SELECT LTRIM(DEPARTMENT) FROM Worker ;

--Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.

	SELECT LEN(DEPARTMENT) FROM Worker GROUP BY DEPARTMENT;

	SELECT DISTINCT LEN(DEPARTMENT) FROM Worker;

--Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.

	SELECT REPLACE(FIRST_NAME, 'a', 'A') FROM Worker;

--Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.

	SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS CPMPLETE_NAME FROM Worker;

--Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.

	SELECT * FROM Worker ORDER BY FIRST_NAME ASC;

--Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

	SELECT * FROM Worker ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;

--Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.

	SELECT * FROM Worker WHERE FIRST_NAME IN ('Vipul', 'Satish');

	SELECT * FROM Worker Where FIRST_NAME LIKE 'Vipul%' OR FIRST_NAME LIKE 'Satish%';

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.

	SELECT * FROM Worker WHERE FIRST_NAME NOT IN ('Vipul', 'Satish');

	SELECT * FROM Worker Where FIRST_NAME NOT LIKE 'Vipul%' AND FIRST_NAME NOT LIKE 'Satish%';

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

	SELECT * FROM Worker WHERE DEPARTMENT = 'Admin';

	SELECT * FROM Worker Where DEPARTMENT IN ('Admin');

	SELECT * FROM Worker Where DEPARTMENT LIKE 'Admin%';

--Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.

	SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a%';

--Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

	SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a';

--Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.

	SELECT * FROM Worker WHERE FIRST_NAME LIKE '%h' AND LEN(FIRST_NAME) = 6;

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.

	SELECT * FROM Worker  WHERE SALARY BETWEEN 100000 AND 500000;

--Q-20. Write an SQL query to print details of the Workers who have joined in NOW’2014.

	Select * from Worker where year(JOINING_DATE) = 2014 and MONTH(JOINING_DATE) = 11;

--Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
	SELECT COUNT(*) FROM Worker WHERE DEPARTMENT = 'Admin';

--Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.

--SOLUTION-1
	SELECT FIRST_NAME, LAST_NAME, SALARY FROM Worker WHERE SALARY BETWEEN 50000 AND 100000;

--SOLUTION-2
	SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) As Worker_Name, Salary
	FROM worker 
	WHERE WORKER_ID IN 
	(SELECT WORKER_ID FROM worker 
	WHERE Salary BETWEEN 50000 AND 100000);

--Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.

SELECT DEPARTMENT, COUNT(*) AS NO_OF_WORKERS FROM Worker GROUP BY DEPARTMENT ORDER BY COUNT(*) DESC;

--Q-24. Write an SQL query to print details of the Workers who are also Managers.

--SOLUTİON-1
	SELECT W.FIRST_NAME, W.LAST_NAME, W.SALARY, T.WORKER_TITLE FROM 
	Worker W, Title T WHERE W.WORKER_ID = T.WORKER_REF_ID AND T.WORKER_TITLE = 'Manager';

--SOLUTİON-2
	SELECT DISTINCT W.FIRST_NAME, W.LAST_NAME, W.SALARY, T.WORKER_TITLE FROM 
	Worker W INNER JOIN Title T ON W.WORKER_ID = T.WORKER_REF_ID WHERE T.WORKER_TITLE = 'Manager';

-- Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.

	SELECT WORKER_TITLE, AFFECTED_FROM, COUNT(*)
	FROM Title
	GROUP BY WORKER_TITLE, AFFECTED_FROM
	HAVING COUNT(*) > 1;

--Q-26. Write an SQL query to show only odd rows from a table.

	SELECT WORKER_ID FROM Worker WHERE WORKER_ID%2 = 1;

--Q-27. Write an SQL query to show only even rows from a table.

	SELECT WORKER_ID FROM Worker WHERE WORKER_ID%2 = 0;

--Q-28. Write an SQL query to clone a new table from another table.

	SELECT * INTO Worker_Copy FROM Worker;

--Q-29. Write an SQL query to fetch intersecting records of two tables.
      
	SELECT * FROM Worker WHERE WORKER_ID IN (SELECT WORKER_ID FROM Worker_Copy);

	(SELECT * FROM Worker) INTERSECT (SELECT * FROM Worker_Copy);

--Q-30. Write an SQL query to show records from one table that another table does not have.

	SELECT * FROM Worker MINUS SELECT * FROM Title;

--Q-31. Write an SQL query to show the current date and time.

	SELECT GETDATE();

	SELECT CURRENT_TIMESTAMP;

--Q-32. Write an SQL query to show the top n (say 10) records of a table.

	SELECT TOP 10 * FROM Worker ORDER BY WORKER_ID;

--Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.

	SELECT TOP 1 SALARY
	FROM (
	SELECT DISTINCT TOP 5 SALARY
	FROM Worker 
	ORDER BY Salary DESC ) AS T;


--Q-34. Write an SQL query to determine the 5th highest salary without using TOP or limit method.

--SOLUTİON-1
	SELECT TOP 5 SALARY FROM Worker ORDER BY SALARY DESC ;

--SOLUTİON-2
	SELECT Salary
	FROM Worker W1
	WHERE 4 = (
	SELECT COUNT( DISTINCT ( W2.Salary ) )
	FROM Worker W2
	WHERE W2.Salary >= W1.Salary
	);

 --Q-35. Write an SQL query to fetch the list of employees with the same salary.

	SELECT * FROM Worker WHERE SALARY IN 
	(SELECT SALARY FROM Worker GROUP BY SALARY HAVING COUNT(*) > 1);

--Q-36. Write an SQL query to show the second highest salary from a table.
    -- SOLUTİON-1
	SELECT TOP 2 SALARY FROM Worker ORDER BY SALARY DESC; -- TWO MAX SALARY

    -- SOLUTİON-2
	SELECT MAX(SALARY) FROM Worker
	WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM Worker); -- SECOND MAX SALARY

--Q-37. Write an SQL query to show one row twice in results from a table.

	SELECT FIRST_NAME, DEPARTMENT FROM WORKER W WHERE W.DEPARTMENT = 'HR'
	UNION ALL
	SELECT FIRST_NAME, DEPARTMENT FROM WORKER W WHERE W.DEPARTMENT = 'HR';

--Q-38. Write an SQL query to fetch intersecting records of two tables.


	SELECT * FROM Worker WHERE WORKER_ID IN (SELECT WORKER_ID FROM Worker_Copy);


	(SELECT * FROM WORKER)
	INTERSECT
	(SELECT * FROM WORKER_COPY);

--Q-39. Write an SQL query to fetch the first 50% records from a table.

	SELECT * FROM Worker WHERE WORKER_ID <= (SELECT COUNT(*) FROM Worker)/2;

--Q-40. Write an SQL query to fetch the departments that have less than five people in it.

	SELECT DEPARTMENT FROM Worker GROUP BY DEPARTMENT HAVING COUNT(*) < 5;

	SELECT DEPARTMENT, COUNT(WORKER_ID) as 'Number of Workers' FROM 
	Worker GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) < 5;

 --Q-41. Write an SQL query to show all departments along with the number of people in there.

	SELECT DEPARTMENT, COUNT(WORKER_ID) as 'Number of Workers' FROM Worker
	GROUP BY DEPARTMENT;

 --Q-42. Write an SQL query to show the last record from a table.

	SELECT TOP 1 * FROM Worker ORDER BY WORKER_ID DESC;

	Select * from Worker where WORKER_ID = (SELECT MAX(WORKER_ID) from Worker);

 --Q-43. Write an SQL query to fetch the first row of a table.

	SELECT TOP 1 * FROM Worker ORDER BY WORKER_ID ASC;

	Select * from Worker where WORKER_ID = (SELECT min(WORKER_ID) from Worker);

--Q-44. Write an SQL query to fetch the last five records from a table.

	SELECT TOP 5 * FROM Worker ORDER BY WORKER_ID DESC;

--Q-45. Write an SQL query to print the name of employees having the highest salary in each department.

	SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary from(SELECT max(Salary) as TotalSalary,DEPARTMENT 
	from Worker group by DEPARTMENT) as TempNew 
	Inner Join Worker t on TempNew.DEPARTMENT=t.DEPARTMENT 
	and TempNew.TotalSalary=t.Salary;

 --Q-46. Write an SQL query to fetch three max salaries from a table.

--SOLUTİON-1
 	SELECT DISTINCT TOP 3 SALARY FROM Worker ORDER BY Salary DESC;

--SOLUTİON-2
	SELECT distinct Salary from worker a 
	WHERE 3 >= (SELECT count(distinct Salary) from worker b 
	WHERE a.Salary <= b.Salary) order by a.Salary desc;

 --Q-47. Write an SQL query to fetch three min salaries from a table.
 --SOLUTİON-1
	SELECT DISTINCT TOP 3 SALARY FROM Worker ORDER BY Salary ASC;
 ---SOLUTİON-2
	SELECT distinct Salary from worker a 
	WHERE 3 >= (SELECT count(distinct Salary) from worker b 
	WHERE a.Salary >= b.Salary) order by a.Salary desc;

 --Q-48. Write an SQL query to fetch nth max salaries from a table.

	SELECT distinct Salary from worker a 
	WHERE 2 >= (SELECT count(distinct Salary) from worker b 
	WHERE a.Salary <= b.Salary) order by a.Salary desc;

 --Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.

	SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SLARY  FROM Worker
	GROUP BY DEPARTMENT ORDER BY SUM(SALARY) DESC;

 --Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.

 	SELECT FIRST_NAME, SALARY FROM Worker WHERE SALARY = (SELECT MAX(SALARY) FROM Worker);


 