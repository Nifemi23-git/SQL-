Create TABLE StudentData
(StudentID int, 
FirstName Varchar (50),
LastName Varchar (50),
Gender varchar (50),
Age int,
EnrollmentDate Date
)

Create Table Enrollment
(EnrollmentID int,
StudentID int,
CourseCode Varchar (50),
Allowance Int,
EnrollmentDate Date, 
)

INSERT INTO [SQL TUTORIAL].DBO.StudentData VALUES
(1, 'John', 'Smith', 'Male', 20,  '2024-01-15' ),
(2, 'Emma', 'Johnson', 'Female', 22,  '2024-01-15'),
(3, 'Liam', 'Williams', 'Male', 21, '2024-01-16'),
(4, 'Olivia', 'Brown', 'Female', 23, '2024-01-16'),
(5, 'Noah', 'Jones', 'Male', 22, '2024-01-17'),
(6, 'Ava', 'Garcia', 'Female', 24, '2024-01-17'),
(7, 'Mason', 'Miller', 'Male', 22, '2024-01-18'),
(8, 'Isabella', 'Davis', 'Female', 20, '2024-01-18'),
(9, 'Ethan', 'Rodriguez', 'Male', 18, '2024-01-19'),
(10, 'Sophia', 'Martinez', 'Female', 26, '2024-01-19')



INSERT INTO [SQL TUTORIAL].DBO.Enrollment VALUES
(101, 1, 'CS101', 20000,'2024-01-20'),
(102, 1, 'CS102', 30000, '2024-01-20'),
(103, 2, 'CS101', 50000, '2024-01-21'),
(104, 2, 'BA201', 35000, '2024-01-21'),
(105, 3, 'CS101', 27000, '2024-01-22'),
(106, 3, 'ENG101', 25000, '2024-01-22'),
(107, 4, 'ME101', 18000, '2024-01-23'),
(108, 4, 'PHY101', 45000, '2024-01-23'),
(109, 5, 'CS102', 33000, '2024-01-24'),
(110, 6, 'DS101', 29000, '2024-01-25'),
(111, 6, 'STAT101', 28000, '2024-01-25'),
(112, 7, 'ME101', 32000, '2024-01-26'),
(113, 7, 'CE101', 34000, '2024-01-26'),
(114, 8, 'PSY101', 33000, '2024-01-27'),
(115, 8, 'SOC101', 250000, '2024-01-27'),
(116, 9, 'BA201',  22000, '2024-01-28'),
(117, 9, 'ECON101', 40000, '2024-01-28'),
(118, 10, 'DS101', 45000, '2024-01-29'),
(119, 10, 'CS101', 49000, '2024-01-29')


select *
from [SQL TUTORIAL].dbo.StudentData

Select *
from [SQL TUTORIAL].dbo.Enrollment

   select StudentData.StudentID, FirstName, LastName, Gender
  from [SQL TUTORIAL].dbo.StudentData
Inner Join [SQL TUTORIAL].dbo.Enrollment
    On StudentData.StudentID= Enrollment.StudentID

    select * 
  from [SQL TUTORIAL].dbo.StudentData
  Left Outer Join [SQL TUTORIAL].dbo.Enrollment
    On StudentData.StudentID= Enrollment.StudentID

     select  DISTINCT * 
  from [SQL TUTORIAL].dbo.StudentData
  Full Outer Join [SQL TUTORIAL].dbo.Enrollment
    On StudentData.StudentID= Enrollment.StudentID


    select StudentID, EnrollmentDate
from [SQL TUTORIAL].dbo.StudentData
Union
select StudentID, EnrollmentDate
from [SQL TUTORIAL].dbo.Enrollment

select StudentId, FirstName
from [SQL TUTORIAL].dbo.StudentData
union
select studentId, CourseCode
from [SQL TUTORIAL].dbo.Enrollment
order by FirstName

select FirstName, LastName, Age,
case
  when age > 25 Then 'LateEducation'
  when age between 21 and 24 then 'Young'
  else 'Teen'
  end as AgeCategory
  from [SQL TUTORIAL].dbo.StudentData
  where age is not null
  order by age 


  select FirstName, LastName, Age, Allowance,
Case
   when Age = 20 then allowance + ( allowance * .10)
   when Age = 24 then allowance + ( allowance * .05)
   when Age = 27 then allowance + ( allowance * .000001)
   else allowance + (allowance * .03)
End as AllowanceAfterRaise
  from [SQL TUTORIAL].dbo.StudentData
  join [SQL TUTORIAL].dbo.Enrollment
  on StudentData.StudentID= Enrollment.StudentID

  delete from [SQL TUTORIAL].dbo.Enrollment
  where EnrollmentID = 112
