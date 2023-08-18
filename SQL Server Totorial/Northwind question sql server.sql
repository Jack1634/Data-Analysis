USE Northwind

--1. Select the FirstName and LastName columns from the Employees table.

	SELECT LastName, Firstname from Employees; 

--2. Create a report showing Northwind’s orders sorted by Freight from most expensive to cheapest.

	SELECT OrderId, OrderDate, ShippedDate, CustomerID, 
	Freight  FROM Orders ORDER BY Freight DESC;

/*3. Create a report showing the first and last name of all employees whose last names start with a letter in the last half of the alphabet. Sort by LastName in descending order.*/

	SELECT FirstName, LastName
	from Employees
	where LastName like '[n-z]%'
	order by LastName desc;

--4. Create a report showing the first and last name of all sales representatives who are from Seattle or Redmond.

	SELECT FirstName, LastName from Employees 
	where Title = 'Sales Representative' and 
	(City = 'Seattle' or City = 'Rendmond');

--5. Create a report that shows the order ID, freight cost, freight cost with this tax for all orders of $500 or more.

	SELECT OrderId, Freight, 
	CASE WHEN Freight > 500 THEN 0.1*Freight ELSE 0 END as FreightWithTax
	from Orders 
	WHERE Freight >= 500
	order by FreightWithTax desc;

--6. Find the Companies (the CompanyName) that placed orders in 1997.
	SELECT  distinct(c.CompanyName) from Customers c
	join Orders o on c.CustomerID = o.CustomerID
	where o.OrderDate >= '1997-01-01' and o.OrderDate <= '1997-12-31';

/*7.Create a report showing the Order ID, the name of the company that placed the order,
 and the first and last name of the associated employee. Only show orders placed 
 after January 1, 1998 that shipped after they were required. Sort by Company Name.*/

 SELECT o.OrderID, c.CompanyName, e.FirstName, e.LastName, o.OrderDate, o.ShippedDate
    FROM Employees e 
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE o.OrderDate >= '1998-01-01 00:00:00' AND o.ShippedDate > o.RequiredDate
    ORDER BY c.CompanyName;

--8.Write a query to get Product list (ID, name, unit price) where current products cost less than $20.

	SELECT ProductID, ProductName, UnitPrice 
	FROM Products WHERE UnitPrice < 20 and Discontinued = 0
	Order By UnitPrice DESC;

--9. Write a query to get Product list (name, unit price) of above average price.

	SELECT ProductName, UnitPrice from Products
	where UnitPrice > (SELECT avg(UnitPrice) from Products)
	order by UnitPrice desc;



 