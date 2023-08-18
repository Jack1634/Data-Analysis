
    /*CASE 1: Manager wants to see a table that includes company employees information
 and he wants to analyze these information to make new decisions about company’s future plans.

 * Manager wants to see these informations: FirstName, LastName, JobTitle, BirthDate, HireDate,
  PersonType, MaritalStatus, Gender, PhoneNumberType, PhoneNumber, EmailAddress, AddressType, 
  AdressLine, PostalCode, City, StateProvince, Territory, Country, Continent.

  * These information are in 11 different tables. Then, join structure should be used to connect 
  all tables each other. But, we will use inner join because we need to have common points all of them.*/

  
*** PREPARING RAW DATA DEMANDED BY MANAGER

    SELECT pp.FirstName, pp.LastName, hre.JobTitle, hre.BirthDate, hre.HireDate, pp.PersonType, hre.MaritalStatus, hre.Gender, 
    ppt.[Name] 'Phone Number Type Name', ppp.PhoneNumber, pea.EmailAddress, pat.[Name] 'Address Type Name', 
    pa.AddressLine1, pa.PostalCode, pa.City, pst.[Name] 'State Province Name', sst.[Name] 'Territory Name', 
    pcr.[Name] 'Country Name', sst.[Group] 'Continent'

    FROM HumanResources.Employee hre

    INNER JOIN Person.Person pp ON hre.BusinessEntityID = pp.BusinessEntityID

    INNER JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = hre.BusinessEntityID

    INNER JOIN Person.Address pa ON pa.AddressID = pbea.AddressID

    INNER JOIN Person.AddressType pat ON pat.AddressTypeID =pbea.AddressTypeID

    INNER JOIN Person.EmailAddress pea ON pea.BusinessEntityID = hre.BusinessEntityID

    INNER JOIN Person.PersonPhone ppp ON ppp.BusinessEntityID = hre.BusinessEntityID

    INNER JOIN Person.PhoneNumberType ppt ON ppt.PhoneNumberTypeID = ppp.PhoneNumberTypeID

    INNER JOIN Person.StateProvince pst ON pst.StateProvinceID = pa.StateProvinceID

    INNER JOIN Person.CountryRegion pcr ON pcr.CountryRegionCode = pst.CountryRegionCode

    INNER JOIN Sales.SalesTerritory sst ON sst.TerritoryID = pst.TerritoryID;


************************************************************************************
* CREATE VIEW FOR THE QUERY

CREATE VIEW Business_Entity_Data -- Write your VIEW name after CREATE VIEW
AS 
SELECT
    pp.FirstName, 
    pp.LastName, 
    hre.JobTitle, 
    hre.BirthDate, 
    hre.HireDate, 
    pp.PersonType,
    hre.MaritalStatus,
    hre.Gender, 
    ppt.[Name] 'Phone Number Type Name',
    ppp.PhoneNumber, pea.EmailAddress, 
    pat.[Name] 'Address Type Name',
    pa.AddressLine1, 
    pa.PostalCode, 
    pa.City, pst.[Name] 'State Province Name',
    sst.[Name] 'Territory Name', 
    pcr.[Name] 'Country Name',
    sst.[Group] 'Continent'

FROM HumanResources.Employee hre 

    INNER JOIN Person.Person pp ON hre.BusinessEntityID = pp.BusinessEntityID

    INNER JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = hre.BusinessEntityID

    INNER JOIN Person.Address pa ON pa.AddressID = pbea.AddressID

    INNER JOIN Person.AddressType pat ON pat.AddressTypeID =pbea.AddressTypeID

    INNER JOIN Person.EmailAddress pea ON pea.BusinessEntityID = hre.BusinessEntityID

    INNER JOIN Person.PersonPhone ppp ON ppp.BusinessEntityID = hre.BusinessEntityID

    INNER JOIN Person.PhoneNumberType ppt ON ppt.PhoneNumberTypeID = ppp.PhoneNumberTypeID

    INNER JOIN Person.StateProvince pst ON pst.StateProvinceID = pa.StateProvinceID

    INNER JOIN Person.CountryRegion pcr ON pcr.CountryRegionCode = pst.CountryRegionCode

    INNER JOIN Sales.SalesTerritory sst ON sst.TerritoryID = pst.TerritoryID;

-- VIEW CODE (Results are same with the query top)

SELECT * FROM Business_Entity_Data

*******************************************************************************************

--EXTRA INFORMATION ABOUT VIEW

VIEW DROPPING (Deleting the view) 

DROP VIEW Business_Entity_Data;

VIEW ALTERİNG (Updating the view)

ALTER VIEW Business_Entity_Data  


------------------------------------------------------------------------------------------

DEMANDED ANALYSIS BY MANAGER ABOUT THE EMPLOYEES

/* Top management decided to getting smaller our company
 and we want to fire old employees. Can you share a list
  of employees who are more than 45 and working more than 5 years?*/

* DATEDIFF STATEMENT
DATEDIFF (interval, date1, date2)

DEMANDED QUERY (Please, carefully look at FROM. It includes a table from a query.
This structure is different than the queries located top.)

SELECT * FROM

(SELECT 
        bed.FirstName, 
        bed.LastName, 
        bed.JobTitle, 
        bed.BirthDate,
        bed.HireDate, 
        '2014-12-31' AS "TODAY",

    DATEDIFF(YEAR, bed.BirthDate,'2014-12-31') AS 'EmployeeAge',

    DATEDIFF(YEAR, bed.HireDate, '2014-12-31') AS 'WorkingYears'

FROM Business_Entity_Data bed) AS Possible_Fired_List

    WHERE Possible_Fired_List.EmployeeAge >45

    AND Possible_Fired_List.WorkingYears>5

---------------------------------------------------------------------------

SELECT * FROM

(SELECT 
        bed.FirstName, 
        bed.LastName, 
        bed.JobTitle, 
        bed.BirthDate,
        bed.HireDate, 
        GETDATE() AS "TODAY",

    DATEDIFF(YEAR, bed.BirthDate,GETDATE()) AS 'EmployeeAge',

    DATEDIFF(YEAR, bed.HireDate, GETDATE()) AS 'WorkingYears'

FROM Business_Entity_Data bed) AS Possible_Fired_List

    WHERE Possible_Fired_List.EmployeeAge >45

    AND Possible_Fired_List.WorkingYears>5
