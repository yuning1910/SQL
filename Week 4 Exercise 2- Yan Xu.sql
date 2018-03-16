--Week 4 Exercise 2 Problem 1: How many customers who made at least one order in this period?
select count(distinct CustomerID)
from Sales.SalesOrderHeader
where SubTotal > 0;

--Week 4 Exercise 2 Problem 2:What is the total net sales (before tax and freight) in this period?
select sum(SubTotal)
from Sales.SalesOrderHeader;

--Week 4 Exercise 2 Problem 3: What is the average shipping cost for online orders? 
---(Hint: online orders have OnlineOrderFlag=1)
select avg(Freight)
from Sales.SalesOrderHeader
where OnlineOrderFlag = 1;

-- Week 4 Exercise 2 Problem 4: Show the number of orders placed by each customer and 
-- sort the result by the number of orders in descending order
select distinct CustomerID, count(SalesOrderID) as "Number of Orders"
from Sales.SalesOrderHeader
group by CustomerID
order by count(SalesOrderID) desc;

-- Week 4 Exercise 2 Problem 5: Show the earliest order date, the most recent order date, 
-- and the total amount for each customer. Sort the result by CustomerID in ascending order
select CustomerID, min(OrderDate) as Earliest, max(OrderDate) as "Most Recent", sum(TotalDue) as "Total Amount"
from Sales.SalesOrderHeader
group by CustomerID
order by CustomerID;

-- Week 4 Exercise 2 Problem 6: Show the number of orders, total sales amount, 
-- and average order amount by order type (online vs. store)
select OnlineOrderFlag, count(SalesOrderID) as "Number of Orders", sum(TotalDue) as "Total Amount", sum(TotalDue)/count(SalesOrderID) as "Average Order Amount"
from Sales.SalesOrderHeader
group by OnlineOrderFlag

-- Week 4 Exercise 2 Problem 7: Show the net sales (before tax and freight) by territory 
-- and sales person. Orders without associated sales person should not be included. Sort the results by
-- territoryid and salespersonid in ascending orders
select TerritoryID, SalesPersonID, sum(SubTotal) as "Net Sales" 
from Sales.SalesOrderHeader
where SalesPersonID is not null
group by TerritoryID, SalesPersonID
order by TerritoryID, SalesPersonID;

-- Week 4 Exercise 2 Problem 8: Are there any customers who have both online and offline orders?
select CustomerID, count(SalesOrderID) as "Order Count"
from Sales.SalesOrderHeader
where OnlineOrderFlag = 1 and OnlineOrderFlag = 0
group by CustomerID;

-- Week 4 Exercise 2 Problem 9:What is the average tax rate by territory? 
-- Did the company charge a higher tax rate for online orders?
select TerritoryID, avg(TaxAmt/SubTotal) as "Average Tax Rate"
from Sales.SalesOrderHeader
group by TerritoryID; 

select OnlineOrderFlag, avg(TaxAmt/SubTotal) as "Average Tax Rate"
from Sales.SalesOrderHeader
group by OnlineOrderFlag;

-- Week 4 Exercise 2 Problem 10: Show the top 10 busiest order days 
-- (i.e., the days having the largest number of orders) during this period?
select top 10 OrderDate, count(SalesOrderID) as "Number of Orders"
from Sales.SalesOrderHeader
group by OrderDate
order by count(SalesOrderID) desc;
