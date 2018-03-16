-- Week 4 Exercise 3 Problem 1: Show the total number of items in each order, sorted by SalesOrderID
select distinct SalesOrderID, sum(OrderQty) as "Number of Items"
from Sales.SalesOrderDetail
group by SalesOrderID;

-- Week 4 Exercise 3 Problem 2: Show the number of different products in each order, sorted by SalesOrderID
select distinct SalesOrderID, count(OrderQty) as "Number of Products"
from Sales.SalesOrderDetail
group by SalesOrderID;

-- Week 4 Exercise 3 Problem 3: Show the average price of various products paid by 
-- each individual customer (not store customer)
select S2.CustomerID, S1.ProductID, avg(S1.UnitPrice) as "Average Price"
from Sales.SalesOrderDetail S1, Sales.SalesOrderHeader S2
where S1.SalesOrderID = S2.SalesOrderID
group by S1.ProductID, S2.CustomerID
order by S2.CustomerID,S1.ProductID;

-- Week 4 Exercise 3 Problem 4: Show the total net sales (before tax and freight), Sales Quota, 
-- and Commissions by sales person
select SalesPersonID, sum(SubTotal) as "Total Sales", SalesQuota, sum(CommissionPct *SubTotal) as "Commission"
from Sales.SalesOrderHeader, Sales.SalesPerson
where SalesPersonID = BusinessEntityID and SalesPersonID is not null
group by SalesPersonID, SalesQuota;

-- Week 4 Exercise 3 Problem 5: Find the highest single store sales for each saleperson
-- [Hint: Each salesperson is responsible for multiple stores.Find the highest sales
-- amount among the stores managed by each salesperson. You may need to use a temporary
-- table to find the solution.]

select StoreID, sum(SubTotal) as "StoreSales", SalesPersonID
into #Temp
from Sales.Customer, Sales.SalesOrderHeader
where Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID and StoreID is not null
group by StoreID, SalesPersonID;

select SalesPersonID, max(StoreSales) as "Max Store Sales"
from #Temp
group by SalesPersonID;

