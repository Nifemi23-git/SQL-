/*
Group By, Order By
*/


SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 DESC


SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY Gender ASC

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC

SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Age]
      ,[Gender]
  FROM [SQL TUTORIAL].[dbo].[EmployeeDemographics]

  SELECT TOP (1000) [EmployeeID]
      ,[JobTitle]
      ,[Salary]
  FROM [SQL TUTORIAL].[dbo].[EmployeeSalary]

  SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael')

SELECT TOP 5 *
FROM EmployeeDemographics

SELECT DISTINCT(Gender) 
FROM EmployeeDemographics

SELECT COUNT(LastName) as  LastNameCount
FROM EmployeeDemographics