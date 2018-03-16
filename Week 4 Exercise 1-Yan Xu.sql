-- Week 4 Exercise 1 Problem 1: List the entire table of Sales.SalesOrderDetail
select *
from Sales.SalesOrderDetail;

-- Week 4 Exercise 1 Problem 2: List SalesOrderID, ProductID, UnitPrice, and LineTotal 
-- from the Sales.SalesOrderDetail table. Rename SalesOrderID as "Sales Order", 
-- ProductID as "Product", UnitPrice as "Price", LineTotal as "Total Amount"

select SalesOrderID as "Sales Order", ProductID as Product, UnitPrice as Price, LineTotal as "Total Amouont"
from Sales.SalesOrderDetail;

-- Week 4 Exercise 1 Problem 3: Find orders with products in the Department 700 
-- (i.e., ProductID between 700 and 799)
select *
from Sales.SalesOrderDetail
where ProductID >= 700 AND ProductID <799;

-- Week 4 Exercise 1 Problem 4: Find all items sold at a discount
select *
from Sales.SalesOrderDetail
where UnitPriceDiscount >0;

-- Week 4 Exercise 1 Problem 5: Find all items without a CarrierTrackingNumber
select *
from Sales.SalesOrderDetail
where CarrierTrackingNumber is NULL;

-- Week 4 Exercise 1 Problem 6: Find orders with products 773 and 824 
-- that were not sold at a discount
select *
from Sales.SalesOrderDetail
where ProductID IN (773,824) AND UnitPriceDiscount = 0;

-- Week 4 Exercise 1 Problem 7: Check if the LineTotal values are all calculated correctly.
-- Note that LineTotal = OrderQty * UnitPrice * (1-UnitPriceDiscount)
select *
from Sales.SalesOrderDetail
where (LineTotal - OrderQty*UnitPrice*(1-UnitPriceDiscount)) > 0.01;

-- Week 4 Exercise 1 Problem 8: Find a distinct list of products and prices 
-- sorted by ProductID first in ascending order and then by Price in descending order
select distinct ProductID, UnitPrice
from Sales.SalesOrderDetail
order by ProductID, UnitPrice desc;

-- Week 4 Exercise 1 Problem 9: Find all items that were modifed in 2008 and 
-- sort the results by ModifiedDate in ascending order
select *
from Sales.SalesOrderDetail
where ModifiedDate between '2008-01-01 00:00:00.000' and '2008-12-31 00:00:00.000'
order by ModifiedDate;

-- Week 4 Exercise 1 Problem 10: Find all items that have a CarrierTrackingNumber
-- starting with "3373"
select *
from Sales.SalesOrderDetail
where CarrierTrackingNumber like '3373%';