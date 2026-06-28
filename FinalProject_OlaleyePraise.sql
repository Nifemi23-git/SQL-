SELECT TOP (1000) [id]
      ,[first_name]
      ,[last_name]
      ,[birthdate]
      ,[gender]
      ,[race]
      ,[department]
      ,[jobtitle]
      ,[location]
      ,[hire_date]
      ,[termdate]
      ,[location_city]
      ,[location_state]
  FROM [Final Project Database].[dbo].[Hr_Table]

  --Count the Number of Rows 
  Select Count (*) AS No_Of_Rows 
  From [Final Project Database].[dbo].[Hr_Table]

  --Check Duplicate Employee Id 
  Select id, Count (*) AS id_Count
  From [Final Project Database].[dbo].[Hr_Table]
  Group by id 
  Having Count (*) > 1
   --- It did not return any row, therefore no Duplicate Employee Id 

   --Check for missing values 
Select 
Sum (Case When id IS NULL OR LTRIM(RTRIM (id))= ' ' THEN 1 ELSE 0 END ) AS missing_id,
Sum (Case When first_name IS NULL OR LTRIM(RTRIM (first_name))= ' ' THEN 1 ELSE 0 END ) AS missing_firstname,
Sum (Case When last_name IS NULL OR LTRIM(RTRIM (last_name))= ' ' THEN 1 ELSE 0 END ) AS missing_lastname,
Sum (Case When birthdate IS NULL OR LTRIM(RTRIM (birthdate))= ' ' THEN 1 ELSE 0 END ) AS missing_birthdate,
Sum (Case When hire_date IS NULL OR LTRIM(RTRIM (hire_date))= ' ' THEN 1 ELSE 0 END ) AS missing_hiredate,
Sum (Case When termdate IS NULL OR LTRIM(RTRIM (termdate))= ' ' THEN 1 ELSE 0 END ) AS missing_termdate,
Sum (Case When gender IS NULL OR LTRIM(RTRIM (gender))= ' ' THEN 1 ELSE 0 END ) AS missing_gender,
Sum (Case When race IS NULL OR LTRIM(RTRIM (race))= ' ' THEN 1 ELSE 0 END ) AS missing_race,
Sum (Case When department IS NULL OR LTRIM(RTRIM (department))= ' ' THEN 1 ELSE 0 END ) AS missing_department,
Sum (Case When jobtitle IS NULL OR LTRIM(RTRIM (jobtitle))= ' ' THEN 1 ELSE 0 END ) AS missing_jobtitle,
Sum (Case When location IS NULL OR LTRIM(RTRIM (location))= ' ' THEN 1 ELSE 0 END ) AS missing_location,
Sum (Case When location_city IS NULL OR LTRIM(RTRIM (location_city))= ' ' THEN 1 ELSE 0 END ) AS missing_locationcity,
Sum (Case When location_state IS NULL OR LTRIM(RTRIM (location_state))= ' ' THEN 1 ELSE 0 END ) AS missing_locationstate
From [Final Project Database].[dbo].[Hr_Table]

--Trimming the columns and Replacing blanks with Null
Select 
NULLIF( LTRIM(RTRIM (first_name)), ' ') AS First_Name,
NULLIF( LTRIM(RTRIM (last_name)), ' ') AS Last_Name,
NULLIF( LTRIM(RTRIM (gender)), ' ') AS Gender,
NULLIF( LTRIM(RTRIM (race)), ' ') AS Race,
NULLIF(LTRIM(RTRIM (department)), ' ') AS Department,
NULLIF( LTRIM(RTRIM (jobtitle)), ' ') AS Jobtitle,
NULLIF( LTRIM(RTRIM (location)), ' ') AS Location,
NULLIF( LTRIM(RTRIM (location_city)), ' ') AS Location_City,
NULLIF( LTRIM(RTRIM (location_state)), ' ') AS Location_State
 FROM [Final Project Database].[dbo].[Hr_Table]

 --Count null after replace
 Select
 (Case When id IS NULl THEN 1 ELSE 0 END) AS missing_id,
(Case When first_name IS NULL THEN 1 ELSE 0 END)  AS missing_firstname,
(Case When last_name IS NULL THEN 1 ELSE 0 END)  AS missing_lastname,
(Case When birthdate IS NULL THEN 1 ELSE 0 END) AS missing_birthdate,
(Case When hire_date IS NULL THEN 1 ELSE 0 END) AS missing_hiredate,
(Case When termdate IS NULL THEN 1 ELSE 0 END) AS missing_termdate,
(Case When gender IS NULL THEN 1 ELSE 0 END) AS missing_gender,
(Case When race IS NULL THEN 1 ELSE 0 END) AS missing_race,
(Case When department IS NULL THEN 1 ELSE 0 END) AS missing_department,
(Case When jobtitle IS NULL THEN 1 ELSE 0 END) AS missing_jobtitle,
(Case When location IS NULL THEN 1 ELSE 0 END ) AS missing_location,
(Case When location_city IS NULL THEN 1 ELSE 0 END ) AS missing_locationcity,
(Case When location_state IS NULL THEN 1 ELSE 0 END ) AS missing_locationstate
From [Final Project Database].[dbo].[Hr_Table]

 --Checking Categories 
 --Gender
 SELECT gender, COUNT (*) AS Employee_Gender
 FROM [Final Project Database].[dbo].[Hr_Table]
 Group By Gender
 Order by Employee_Gender desc

 --Department
  SELECT Department, COUNT (*) AS Employee_Department
 FROM [Final Project Database].[dbo].[Hr_Table]
 Group By Department
 Order by Employee_Department desc

  --Race
  SELECT Race, COUNT (*) AS Employee_Race
 FROM [Final Project Database].[dbo].[Hr_Table]
 Group By Race
 Order by Employee_Race desc

  --JobTitle
  SELECT jobtitle, COUNT (*) AS Employee_JobTitle
 FROM [Final Project Database].[dbo].[Hr_Table]
 Group By jobtitle
 Order by Employee_JobTitle desc

 --Location 
  SELECT location, COUNT (*) AS Employee_Location
 FROM [Final Project Database].[dbo].[Hr_Table]
 Group By location
 Order by Employee_Location desc

   --Location City
  SELECT location_city, COUNT (*) AS Employee_LocationCity
 FROM [Final Project Database].[dbo].[Hr_Table]
 Group By location_city
 Order by Employee_LocationCity desc

 --Location State
  SELECT location_state, COUNT (*) AS Employee_LocationState
 FROM [Final Project Database].[dbo].[Hr_Table]
 Group By location_state
 Order by Employee_LocationState desc


 --Changing Date Format
 --BirthDate
 SELECT 
 COALESCE ( 
 TRY_CONVERT (date, birthdate, 101),
 TRY_CONVERT (date, birthdate, 10)
 ) AS Birth_Date
 FROM [Final Project Database].[dbo].[Hr_Table]

 --Hire_Date
  SELECT 
 COALESCE ( 
 TRY_CONVERT (date, hire_date, 101),
 TRY_CONVERT (date, hire_date, 10)
 ) AS Hire_Date
 FROM [Final Project Database].[dbo].[Hr_Table]

 --TermDate
--Remove utc attached to the termdate
SELECT 
 TRY_CONVERT (datetime2(0),
REPLACE (termdate, 'UTC', ' '), 120) AS Term_Date
FROM [Final Project Database].[dbo].[Hr_Table]

--Convert Remaining Value to datetime2
--Creating A new Column for the converted value
ALTER TABLE [dbo].[Hr_Table]
ADD term_datetime datetime2(0) NULL;
--Updating the New Column
Update [dbo].[Hr_Table]
SET term_datetime =
TRY_CONVERT (datetime2(0),
Replace (NULLIF(LTRIM(RTRIM(termdate)), ' '),' UTC', ' '), 120)

--Cecking if conversion worked

SELECT TOP 20
termdate, term_datetime
FROM [dbo].[Hr_Table]
WHERE termdate IS NOT NULL
AND LTRIM(RTRIM(termdate)) <> ' ';

--Checking for failed conversion
SELECT termdate
FROM [dbo].[Hr_Table]
WHERE termdate IS NOT NULL
AND LTRIM(RTRIM(termdate)) <> ' '
AND term_datetime IS NULL;
--This Returned 0 rows therefore the conversion worked successfully--

--Handling Active and Terminated Employee
DECLARE @Today date = '20260618';
SELECT
CASE WHEN term_datetime IS NOT NULL AND CONVERT (date, term_datetime) <= @Today
THEN CONVERT (date, term_datetime ) 
ELSE NULL
END AS Terminated_Date
FROM [Final Project Database].[dbo].[Hr_Table]
--this means if the employye has a termination datetime and that date is less than or equal to the reporting date, then keep it as Terminated_Date. Otherwise return NULL--

--Creating Employement Status
DECLARE @Today date = '20260618';
SELECT 
CASE WHEN term_datetime IS NOT NULL AND CONVERT (date, term_datetime)<= @Today
THEN 'Terminated'
ELSE 'Active'
END AS Employment_Status
FROM [dbo].[Hr_Table]
--This means if the employeee has a termination date that has already happened, mark them as Terminated. Otherwise, Mark them as Active--

--Creating Future termination date
DECLARE @Today date = '20260618';
SELECT 
CASE WHEN term_datetime IS NOT NULL AND CONVERT (date, term_datetime)> @Today
THEN CONVERT (date, term_datetime)
ELSE NULL 
END AS Future_Termination_Date
FROM [dbo].[Hr_Table]

--Creating Full Name
SELECT
NULLIF (LTRIM(RTRIM (CONCAT(first_name, ' ', last_name))), ' ') AS Full_Name
 FROM [dbo].[Hr_Table]

 --Calculate Age
 DECLARE @Today date = '20260618';
 SELECT 
 DATEDIFF (YEAR, birthdate, @Today)
 - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, birthdate, @Today), birthdate)> @Today
 THEN 1 ELSE 0
 END AS Age
  FROM [dbo].[Hr_Table]

  --Create New Column for Age 
  ALTER TABLE [dbo].[Hr_Table]
ADD Age Int

--Delete New Column for Age 
ALTER TABLE [dbo].[Hr_Table]
DROP COLUMN Age


---Creating Cleaned Table 
IF OBJECT_ID('dbo.hr_employee_clean', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.hr_employee_clean;
END;

DECLARE @as_of_date date = '20260627';

;WITH standardized AS (
    SELECT
        NULLIF(LTRIM(RTRIM(id)), '') AS employee_id,
        NULLIF(LTRIM(RTRIM(first_name)), '') AS first_name,
        NULLIF(LTRIM(RTRIM(last_name)), '') AS last_name,
        NULLIF(LTRIM(RTRIM(birthdate)), '') AS birthdate_raw,
        NULLIF(LTRIM(RTRIM(gender)), '') AS gender,
        NULLIF(LTRIM(RTRIM(race)), '') AS race,
        NULLIF(LTRIM(RTRIM(department)), '') AS department,
        NULLIF(LTRIM(RTRIM(jobtitle)), '') AS job_title,
        NULLIF(LTRIM(RTRIM(location)), '') AS work_location,
        NULLIF(LTRIM(RTRIM(hire_date)), '') AS hire_date_raw,
        NULLIF(LTRIM(RTRIM(termdate)), '') AS termdate_raw,
        NULLIF(LTRIM(RTRIM(location_city)), '') AS location_city,
        NULLIF(LTRIM(RTRIM(location_state)), '') AS location_state
    FROM [dbo].[Hr_Table]
),
parsed AS (
    SELECT
        employee_id,
        first_name,
        last_name,

        COALESCE(
            TRY_CONVERT(date, birthdate_raw, 101),
            TRY_CONVERT(date, birthdate_raw, 10)
        ) AS birth_date,

        gender,
        race,
        department,
        job_title,
        work_location,

        COALESCE(
            TRY_CONVERT(date, hire_date_raw, 101),
            TRY_CONVERT(date, hire_date_raw, 10)
        ) AS hire_date,

        TRY_CONVERT(
            datetime2(0),
            REPLACE(termdate_raw, ' UTC', ''),
            120
        ) AS original_term_datetime,

        location_city,
        location_state
    FROM standardized
),
status_calc AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        birth_date,
        gender,
        race,
        department,
        job_title,
        work_location,
        hire_date,
        original_term_datetime,

        CASE
            WHEN original_term_datetime IS NOT NULL
                 AND CONVERT(date, original_term_datetime) <= @as_of_date
            THEN CONVERT(date, original_term_datetime)
            ELSE NULL
        END AS term_date,

        CASE
            WHEN original_term_datetime IS NOT NULL
                 AND CONVERT(date, original_term_datetime) <= @as_of_date
            THEN 'Terminated'
            ELSE 'Active'
        END AS employment_status,

        CASE
            WHEN original_term_datetime IS NOT NULL
                 AND CONVERT(date, original_term_datetime) > @as_of_date
            THEN CONVERT(date, original_term_datetime)
            ELSE NULL
        END AS future_planned_term_date,

        location_city,
        location_state
    FROM parsed
)
SELECT
    employee_id,
    first_name,
    last_name,
    NULLIF(LTRIM(RTRIM(CONCAT(first_name, ' ', last_name))), '') AS full_name,
    birth_date,

    CASE
        WHEN birth_date IS NULL THEN NULL
        ELSE
            DATEDIFF(YEAR, birth_date, @as_of_date)
            - CASE
                WHEN DATEADD(YEAR, DATEDIFF(YEAR, birth_date, @as_of_date), birth_date) > @as_of_date
                THEN 1
                ELSE 0
              END
    END AS age,

    gender,
    race,
    department,
    job_title,
    work_location,
    hire_date,
    original_term_datetime,
    term_date,
    employment_status,
    future_planned_term_date,

    CASE
        WHEN hire_date IS NULL THEN NULL
        ELSE
            CAST(
                DATEDIFF(
                    DAY,
                    hire_date,
                    COALESCE(term_date, @as_of_date)
                ) / 365.25
                AS decimal(6,2)
            )
    END AS tenure_years,

    location_city,
    location_state
INTO dbo.hr_employee_clean
FROM status_calc;

/*=========================================================
  ADD PRIMARY KEY AND INDEXES
=========================================================*/

ALTER TABLE dbo.hr_employee_clean
ALTER COLUMN employee_id varchar(20) NOT NULL;

ALTER TABLE dbo.hr_employee_clean
ADD CONSTRAINT PK_hr_employee_clean PRIMARY KEY (employee_id);

CREATE INDEX IX_hr_employee_clean_hire_date
ON dbo.hr_employee_clean (hire_date);

CREATE INDEX IX_hr_employee_clean_term_date
ON dbo.hr_employee_clean (term_date);

CREATE INDEX IX_hr_employee_clean_status
ON dbo.hr_employee_clean (employment_status);

ALTER TABLE dbo.hr_employee_clean
ALTER COLUMN department Varchar (100) null;

ALTER TABLE dbo.hr_employee_clean
ALTER COLUMN job_title Varchar (150) null;

ALTER TABLE dbo.hr_employee_clean
ALTER COLUMN work_location Varchar (50) null;

ALTER TABLE dbo.hr_employee_clean
ALTER COLUMN  location_state Varchar (100) null;

ALTER TABLE dbo.hr_employee_clean
ALTER COLUMN  location_city Varchar (100) null;

CREATE INDEX IX_hr_employee_clean_department
ON dbo.hr_employee_clean (department);

CREATE INDEX IX_hr_employee_clean_job_title
ON dbo.hr_employee_clean (job_title);

CREATE INDEX IX_hr_employee_clean_location
ON dbo.hr_employee_clean (work_location, location_state, location_city);


/*=========================================================
   VALIDATE THE CLEANED TABLE
=========================================================*/

-- 1. Raw rows should match clean rows.
SELECT
    (SELECT COUNT(*) FROM [dbo].[Hr_Table]) AS raw_rows,
    (SELECT COUNT(*) FROM dbo.hr_employee_clean) AS clean_rows;

-- 2. Check failed date conversions.
SELECT
    SUM(CASE WHEN birth_date IS NULL THEN 1 ELSE 0 END) AS null_birth_date,
    SUM(CASE WHEN hire_date IS NULL THEN 1 ELSE 0 END) AS null_hire_date
FROM dbo.hr_employee_clean;

-- 3. Check raw termdate values that failed to convert.
SELECT
    COUNT(*) AS failed_termdate_conversions
FROM [dbo].[Hr_Table]
WHERE termdate IS NOT NULL
  AND LTRIM(RTRIM(termdate)) <> ''
  AND TRY_CONVERT(datetime2(0), REPLACE(LTRIM(RTRIM(termdate)), ' UTC', ''), 120) IS NULL;

-- 4. Check duplicate employee IDs in clean table.
SELECT employee_id, COUNT(*) AS duplicate_count
FROM dbo.hr_employee_clean
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- 5. Check employees hired before their birth date.
SELECT COUNT(*) AS hire_before_birth_count
FROM dbo.hr_employee_clean
WHERE hire_date < birth_date;

-- 6. Check employees hired before age 18.
SELECT COUNT(*) AS hired_before_age_18_count
FROM dbo.hr_employee_clean
WHERE hire_date < DATEADD(YEAR, 18, birth_date);

-- 7. Check terminations before hire date.
SELECT COUNT(*) AS term_before_hire_count
FROM dbo.hr_employee_clean
WHERE term_date IS NOT NULL
  AND term_date < hire_date;

-- 8. Check employment status counts.
SELECT
    employment_status,
    COUNT(*) AS employees
FROM dbo.hr_employee_clean
GROUP BY employment_status
ORDER BY employees DESC;

-- 9. Check future planned terminations.
SELECT COUNT(*) AS future_planned_terms
FROM dbo.hr_employee_clean
WHERE future_planned_term_date IS NOT NULL;

/*=========================================================
  BASIC HR ANALYSIS QUERIES
=========================================================*/

-- 1. Active employees by department.
SELECT
    department,
    COUNT(*) AS active_headcount
FROM dbo.hr_employee_clean
WHERE employment_status = 'Active'
GROUP BY department
ORDER BY active_headcount DESC;

-- 2. Employees by gender.
SELECT
    gender,
    COUNT(*) AS employees
FROM dbo.hr_employee_clean
GROUP BY gender
ORDER BY employees DESC;

-- 3. Active employees by gender.
SELECT
    gender,
    COUNT(*) AS active_employees
FROM dbo.hr_employee_clean
WHERE employment_status = 'Active'
GROUP BY gender
ORDER BY active_employees DESC;

-- 4. Employees by race.
SELECT
    race,
    COUNT(*) AS employees
FROM dbo.hr_employee_clean
GROUP BY race
ORDER BY employees DESC;

-- 5. Employees by work location.
SELECT
    work_location,
    COUNT(*) AS employees
FROM dbo.hr_employee_clean
GROUP BY work_location
ORDER BY employees DESC;

-- 6. Employees by state.
SELECT
    location_state,
    COUNT(*) AS employees
FROM dbo.hr_employee_clean
GROUP BY location_state
ORDER BY employees DESC;

-- 7. Actual terminations by year.
SELECT
    YEAR(term_date) AS termination_year,
    COUNT(*) AS terminations
FROM dbo.hr_employee_clean
WHERE term_date IS NOT NULL
GROUP BY YEAR(term_date)
ORDER BY termination_year;

-- 8. Average tenure by department.
SELECT
    department,
    CAST(AVG(tenure_years) AS decimal(6,2)) AS average_tenure_years
FROM dbo.hr_employee_clean
GROUP BY department
ORDER BY average_tenure_years DESC;

-- 9. Average age by department.
SELECT
    department,
    CAST(AVG(CAST(age AS decimal(6,2))) AS decimal(6,2)) AS average_age
FROM dbo.hr_employee_clean
WHERE age IS NOT NULL
GROUP BY department
ORDER BY average_age DESC;

/*=========================================================
   STRUCTURE THE DATA INTO A STAR SCHEMA
=========================================================*/

-- Drop fact table first because it depends on dimension tables.
IF OBJECT_ID('dbo.fact_employment', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.fact_employment;
END;

IF OBJECT_ID('dbo.dim_location', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_location;
END;

IF OBJECT_ID('dbo.dim_job', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_job;
END;

IF OBJECT_ID('dbo.dim_department', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_department;
END;

IF OBJECT_ID('dbo.dim_employee', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_employee;
END;

/*-----------------------------
  Employee dimension
-----------------------------*/
CREATE TABLE dbo.dim_employee (
    employee_key int IDENTITY(1,1) NOT NULL,
    employee_id varchar(20) NOT NULL,
    first_name varchar(100) NULL,
    last_name varchar(100) NULL,
    full_name varchar(210) NULL,
    birth_date date NULL,
    age int NULL,
    gender varchar(30) NULL,
    race varchar(100) NULL,
    CONSTRAINT PK_dim_employee PRIMARY KEY (employee_key),
    CONSTRAINT UQ_dim_employee_employee_id UNIQUE (employee_id)
);

INSERT INTO dbo.dim_employee (
    employee_id,
    first_name,
    last_name,
    full_name,
    birth_date,
    age,
    gender,
    race
)
SELECT
    employee_id,
    first_name,
    last_name,
    full_name,
    birth_date,
    age,
    gender,
    race
FROM dbo.hr_employee_clean;

/*-----------------------------
  Department dimension
-----------------------------*/
CREATE TABLE dbo.dim_department (
    department_key int IDENTITY(1,1) NOT NULL,
    department_name varchar(100) NOT NULL,
    CONSTRAINT PK_dim_department PRIMARY KEY (department_key),
    CONSTRAINT UQ_dim_department_department_name UNIQUE (department_name)
);

INSERT INTO dbo.dim_department (department_name)
SELECT DISTINCT department
FROM dbo.hr_employee_clean
WHERE department IS NOT NULL;

/*-----------------------------
   Job dimension
-----------------------------*/
CREATE TABLE dbo.dim_job (
    job_key int IDENTITY(1,1) NOT NULL,
    job_title varchar(150) NOT NULL,
    CONSTRAINT PK_dim_job PRIMARY KEY (job_key),
    CONSTRAINT UQ_dim_job_job_title UNIQUE (job_title)
);

INSERT INTO dbo.dim_job (job_title)
SELECT DISTINCT job_title
FROM dbo.hr_employee_clean
WHERE job_title IS NOT NULL;

/*-----------------------------
   Location dimension
-----------------------------*/
CREATE TABLE dbo.dim_location (
    location_key int IDENTITY(1,1) NOT NULL,
    work_location varchar(50) NULL,
    city varchar(100) NULL,
    state varchar(100) NULL,
    CONSTRAINT PK_dim_location PRIMARY KEY (location_key),
    CONSTRAINT UQ_dim_location UNIQUE (work_location, city, state)
);

INSERT INTO dbo.dim_location (
    work_location,
    city,
    state
)
SELECT DISTINCT
    work_location,
    location_city,
    location_state
FROM dbo.hr_employee_clean;

/*-----------------------------
   Employment fact table
-----------------------------*/
CREATE TABLE dbo.fact_employment (
    employment_key int IDENTITY(1,1) NOT NULL,
    employee_key int NOT NULL,
    department_key int NULL,
    job_key int NULL,
    location_key int NULL,
    hire_date date NULL,
    term_date date NULL,
    employment_status varchar(20) NULL,
    tenure_years decimal(6,2) NULL,
    future_planned_term_date date NULL,
    CONSTRAINT PK_fact_employment PRIMARY KEY (employment_key),
    CONSTRAINT FK_fact_employment_employee
        FOREIGN KEY (employee_key) REFERENCES dbo.dim_employee(employee_key),
    CONSTRAINT FK_fact_employment_department
        FOREIGN KEY (department_key) REFERENCES dbo.dim_department(department_key),
    CONSTRAINT FK_fact_employment_job
        FOREIGN KEY (job_key) REFERENCES dbo.dim_job(job_key),
    CONSTRAINT FK_fact_employment_location
        FOREIGN KEY (location_key) REFERENCES dbo.dim_location(location_key)
);

INSERT INTO dbo.fact_employment (
    employee_key,
    department_key,
    job_key,
    location_key,
    hire_date,
    term_date,
    employment_status,
    tenure_years,
    future_planned_term_date
)
SELECT
    e.employee_key,
    d.department_key,
    j.job_key,
    l.location_key,
    c.hire_date,
    c.term_date,
    c.employment_status,
    c.tenure_years,
    c.future_planned_term_date
FROM dbo.hr_employee_clean AS c
INNER JOIN dbo.dim_employee AS e
    ON c.employee_id = e.employee_id
LEFT JOIN dbo.dim_department AS d
    ON c.department = d.department_name
LEFT JOIN dbo.dim_job AS j
    ON c.job_title = j.job_title
LEFT JOIN dbo.dim_location AS l
    ON c.work_location = l.work_location
   AND c.location_city = l.city
   AND c.location_state = l.state;

   -- Add indexes to the fact table foreign keys.
CREATE INDEX IX_fact_employment_employee_key
ON dbo.fact_employment (employee_key);

CREATE INDEX IX_fact_employment_department_key
ON dbo.fact_employment (department_key);

CREATE INDEX IX_fact_employment_job_key
ON dbo.fact_employment (job_key);

CREATE INDEX IX_fact_employment_location_key
ON dbo.fact_employment (location_key);

CREATE INDEX IX_fact_employment_status
ON dbo.fact_employment (employment_status);

/*=========================================================
  TEST THE STAR SCHEMA
=========================================================*/

-- 1. Make sure fact table row count matches clean table row count.
SELECT
    (SELECT COUNT(*) FROM dbo.hr_employee_clean) AS clean_table_rows,
    (SELECT COUNT(*) FROM dbo.fact_employment) AS fact_table_rows;

-- 2. Active headcount by department using star schema.
SELECT
    d.department_name,
    COUNT(*) AS active_headcount
FROM dbo.fact_employment AS f
INNER JOIN dbo.dim_department AS d
    ON f.department_key = d.department_key
WHERE f.employment_status = 'Active'
GROUP BY d.department_name
ORDER BY active_headcount DESC;

-- 3. Average tenure by department using star schema.
SELECT
    d.department_name,
    CAST(AVG(f.tenure_years) AS decimal(6,2)) AS average_tenure_years
FROM dbo.fact_employment AS f
INNER JOIN dbo.dim_department AS d
    ON f.department_key = d.department_key
GROUP BY d.department_name
ORDER BY average_tenure_years DESC;

-- 4. Active employees by gender using star schema.
SELECT
    e.gender,
    COUNT(*) AS active_employees
FROM dbo.fact_employment AS f
INNER JOIN dbo.dim_employee AS e
    ON f.employee_key = e.employee_key
WHERE f.employment_status = 'Active'
GROUP BY e.gender
ORDER BY active_employees DESC;

-- 5. Actual terminations by year using star schema.
SELECT
    YEAR(f.term_date) AS termination_year,
    COUNT(*) AS terminations
FROM dbo.fact_employment AS f
WHERE f.term_date IS NOT NULL
GROUP BY YEAR(f.term_date)
ORDER BY termination_year;
