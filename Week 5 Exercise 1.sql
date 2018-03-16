--- Week 5 Exercise 1 Problem 1. Show a list of male employees who switched jobs during this period
select HumanResources.Employee.BusinessEntityID
from HumanResources.Employee join HumanResources.EmployeeDepartmentHistory
  on HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
where HumanResources.EmployeeDepartmentHistory.EndDate is not null 
  and HumanResources.Employee.Gender = 'M ';

--- Week 5 Exercise 1 Problem 2. Show the current number of employees for those 
--- departments that have at least one employee
select distinct e1.DepartmentID, d1.Name, count(e1.BusinessEntityID) as 'Number of Employees'
from HumanResources.EmployeeDepartmentHistory e1 join HumanResources.Department d1 
  on e1.DepartmentID = d1.DepartmentID
where e1.EndDate is null
group by e1.DepartmentID, d1.Name
having count(e1.BusinessEntityID) > 1
order by e1.DepartmentID;

--- Week 5 Exercise 1 Problem 3. Show the current number of married or 
--- female employees in each group (groupname)
select distinct D1.GroupName, count(distinct E1.BusinessEntityID) as 'Number of Employees'
from HumanResources.Department D1 join HumanResources.EmployeeDepartmentHistory E1 
  on D1.DepartmentID = E1.DepartmentID join HumanResources.Employee E2 
  on E1.BusinessEntityID = E2.BusinessEntityID
where (E2.Gender = 'F' or E2.MaritalStatus = 'M') and E1.EndDate is null
group by D1.GroupName;
    
--- Week 5 Exercise 1 Problem 4. Show all employees and the department to 
--- which they currently belong.
select E1.BusinessEntityID, D1.Name
from HumanResources.Department D1 join HumanResources.EmployeeDepartmentHistory E1
  on D1.DepartmentID = E1.DepartmentID
where E1.EndDate is null
order by E1.BusinessEntityID;

--- Week 5 Exercise 1 Problem 5. Show the employees who were in the engineering department
--- as of Jan. 1, 2005
select E1.BusinessEntityID
from HumanResources.Department D1 join HumanResources.EmployeeDepartmentHistory E1
  on D1.DepartmentID = E1.DepartmentID
where (E1.EndDate is null and E1.StartDate <'2005-01-01') and D1.Name = 'Engineering'
order by E1.BusinessEntityID;

--- Week 5 Exercise 1 Problem 6. Find the most recent pay rate for employee No. 4
select BusinessEntityID, Rate
from HumanResources.EmployeePayHistory
where RateChangeDate = (select max(RatechangeDate)
        from HumanResources.EmployeePayHistory
        where BusinessEntityID = 4);

--- Week 5 Exercise 1 Problem 7. List all employees’ NationalIDNumber, JobTitle, 
----and HireDate for those who have ever worked in Department 7 
---  (Use a sub-query instead of Join)
select distinct E1.NationalIDNumber,E1.JobTitle, E1.HireDate
from HumanResources.EmployeeDepartmentHistory D1, HumanResources.Employee E1
where E1.BusinessEntityID  in ( select BusinessEntityID
                              from HumanResources.EmployeeDepartmentHistory
							  where DepartmentID = 7);

--- Week 5 Exercise 1 Problem 8. Find a list of employees whose highest pay rate is above 
----the average pay rate of all employees 

select BusinessEntityID, max(Rate) as 'MaxRate'
from HumanResources.EmployeePayHistory
group by BusinessEntityID
having max(Rate) > (select avg(E1.Rate)
                     from HumanResources.EmployeePayHistory E1)

--- Week 5 Exercise 1 Problem 9. Find the most current pay rate 
----and change date for all employees
select distinct E1.BusinessEntityID, E1.RateChangeDate, E1.Rate
from HumanResources.EmployeePayHistory E1
where E1.RateChangeDate in (select max(RateChangeDate)
                             from HumanResources.EmployeePayHistory
							 group by BusinessEntityID)
order by E1.BusinessEntityID desc;

--- Week 5 Exercise 1 Problem 10: Show the pay rate and the difference between the pay rate and 
--- the average rate of the company for all employees

select BusinessEntityID, Rate, (Rate - (select avg(E1.Rate) from HumanResources.EmployeePayHistory E1)) as 'Difference'
from HumanResources.EmployeePayHistory
group by BusinessEntityID, Rate;
