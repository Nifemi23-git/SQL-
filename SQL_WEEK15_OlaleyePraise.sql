-- Using Subqueries to Extract Data
Select EmployeeID,JobTitle, Salary
From EmployeeSalary
Where EmployeeID in (
         Select EmployeeID
         From EmployeeDemographics
         Where Age > 35)

Select EmployeeID,JobTitle, Salary
From EmployeeSalary
Where EmployeeID in (
         Select EmployeeID
         From EmployeeDemographics
         Where Gender = 'Male')

--Ranking Data
SELECT EmployeeId, JobTitle, Salary, ROW_NUMBER() OVER (Order by Salary DESC) AS SalaryRank
FROM EmployeeSalary

--Ranking in Situations where 2 numbers have the same number 
SELECT EmployeeId, JobTitle, Salary, RANK() OVER (Order by Salary DESC) AS SalaryRank
FROM EmployeeSalary

SELECT EmployeeId, JobTitle, Salary, DENSE_RANK() OVER (Order by Salary DESC) AS SalaryRank
FROM EmployeeSalary

---USING PARTITION BY
SELECT EmployeeId, JobTitle, Salary, SUM(Salary) OVER (PARTITION BY JobTitle) AS TotalPerJobTitle
FROM EmployeeSalary

SELECT EmployeeId, JobTitle, Salary, RANK () OVER (PARTITION BY JobTitle Order by Salary DESC) AS SalaryRank
FROM EmployeeSalary

--Using CTE 
WITH EmployeeSalarySummary AS (
SELECT EmployeeId, JobTitle, Salary
FROM EmployeeSalary
WHERE Salary > 40000
)
SELECT * 
FROM EmployeeSalarySummary


--Creating Index
CREATE INDEX IDX_Employeesummary ON EmployeeDemographics(FirstName, LastName, Gender)
Create INDEX IDX_EmployeeSal ON EmployeeSalary (Salary)

--Viewing Index Usage 
SELECT FirstName, LastName, Gender
FROM EmployeeDemographics
JOIN [SQL TUTORIAL].dbo.EmployeeSalary on EmployeeDemographics.EmployeeID= EmployeeSalary.EmployeeID
WHERE Salary > '40000'


CREATE TABLE #pent_Employee (
EmployeeID int,
Gender Varchar (20),
Salary Int
)

SELECT *
FROM #pent_Employee

INSERT INTO #pent_Employee VALUES 
('1001', 'Male', '45000'),
('1002', 'Female', '50000'),
('1003', 'Male', '38000'),
('1004', 'Female', '56000'),
('1005', 'Female', '52000')

CREATE TABLE #pent_Employee2 (
EmployeeID int,
JobTitle Varchar (100),
Salary Int
)

SELECT *
FROM #pent_Employee2

INSERT INTO #pent_Employee VALUES (
'1001', 'HR', '45000'
)

UPDATE #pent_Employee
SET EmployeeID = '1006'
WHERE Gender = 'HR' AND Salary = '45000'

UPDATE #pent_Employee
SET Gender = 'Male'
WHERE EmployeeID = '1006' AND Salary = '45000'


INSERT INTO #pent_Employee2 VALUES (
'1001', 'HR', '45000'
)

INSERT INTO #pent_Employee2
SELECT *
FROM [SQL TUTORIAL]..EmployeeSalary

SELECT *
FROM #pent_Employee2

UPDATE #pent_Employee2
SET JobTitle = 'Accountant'
WHERE EmployeeID = '1010' AND Salary = '47000'

UPDATE #pent_Employee2
SET EmployeeID = '1011'
WHERE JobTitle= 'Salesman' AND Salary = '43000'