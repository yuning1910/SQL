--- Week 5 Exercise 2 Problem 1: Find employees whose birthday is today
select BusinessEntityID, BirthDate
from HumanResources.Employee
where BirthDate = GETDATE();

--- Week 5 Exercise 2 Problem 2: Show a list of employees who have worked for 
--- the company for more than 12 years
select BusinessEntityID, JobTitle, HireDate
from HumanResources.Employee
where DATEDIFF(year, HireDate, GetDate()) > 12;

--- Week 5 Exercise 2 Problem 3: Show the employee's NationalIDNumber, JobTitle, 
--- and approximate age when he/she was hired
select NationalIDNumber, JobTitle, DATEDIFF(year, BirthDate, HireDate ) as 'Age'
from HumanResources.Employee;

--- Week 5 Exercise 2 Problem 4: Show the employee's NationalIDNumber, 
--- JobTitle, and the exact age when he/she was hired

select NationalIDNumber, JobTitle, floor(DATEDIFF(HOUR, BirthDate, HireDate )/8766.0) as 'Age'
from HumanResources.Employee;

--- Week 5 Exercise 2 Problem 5: Show the average pay rate rounded to the whole dollar 
--- by organizational level
select E2.OrganizationLevel, round(AVG(E1.Rate), 0, 0) as 'Average Pay Rate'
from HumanResources.EmployeePayHistory E1, HumanResources.Employee E2
where E1.BusinessEntityID = E2.BusinessEntityID
group by E2.OrganizationLevel;

-- Week 5 Exercise 2 Problem 6: Extract the username (ken) from LoginID (adventure-works\ken0) 
-- for all employees
select BusinessEntityID, Left(SUBSTRING(LoginID, 17, 15), len(substring(LogINID, 17, 15))-1) as 'Username'
from HumanResources.Employee
order by BusinessEntityID;

-- Week 5 Exercise 2 Problem 7: Create a new username (ken7284) with 
-- the old username (ken) followed by last four digits of NationalIDNumber (7284)
select BusinessEntityID, Left(SUBSTRING(LoginID, 17, 15), len(substring(LogINID, 17, 15))-1) + Right(NationalIDNumber, 4) as 'Username'
from HumanResources.Employee
order by BusinessEntityID;

-- Week 5 Exercise 2 Problem 8: Create the following string for each department: “Engineering has 6 employees”
select D1.Name + ' ' + 'has' + ' ' + cast(count(E1.BusinessEntityID) as varchar(4)) + ' ' + 'employees'
from HumanResources.Department D1, HumanResources.EmployeeDepartmentHistory E1
where D1.DepartmentID = E1.DepartmentID and E1.EndDate is null
group by D1.Name;

-- Week 5 Exercise 2 Problem 9. Google and learn about the SQL function "Case...When...End".
-- Use this function to show the number of female, male, and total number of current employees
SELECT 
    COUNT(CASE WHEN gender = 'F' then 1 ELSE NULL END) as "Female",
    COUNT(CASE WHEN gender = 'M' then 1 ELSE NULL END) as "Male",
	COUNT(BusinessEntityID) as 'Total'
From HumanResources.Employee;

-- Week 5 Exercise 2 Problem 10. Google and learn about the SQL functions Datepart and Datename. 
-- Use this function to show the number of employees hired by day of the week
SELECT DATENAME(dw, Hiredate) as 'Weekday', count(BusinessEntityID) as 'Number of Hires'
From HumanResources.Employee
Group by DATENAME(dw, Hiredate);