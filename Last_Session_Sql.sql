/* ---------------------------------- Case Study ----------------------------------------------
1. What are the top selling products and categories from Northwind by month and year? 
2. Which countries have the highest shipping in terms of sales?
3. Who are the top 3 Customers and their Contact Titles per country based on purchases
4. Create the reporting hiererchy of Employees
5. Employee and Manager performance in terms of sales
*/

use Northwind; 

-- 1. What are the top selling products and categories from Northwind by month and year? 

-- Bare min columns required -  Month , Year, Sales data, Products, Categories

-- Tables Required - Product, Order Details, Orders, Category

select * from orders; -- Order_Date
select * from b; -- Unitprice & Quantity
select * from products; -- Product Name
select * from categories; -- CategoryName


-- What is the joning condition / column/ Common Column ? 

-- Orders and order details is related thru Order ID.. 



-- 1. What are the top selling products and categories from Northwind by month and year? 

create table arun_sandbox.Order_Category_Product
select 
A.*, b.UnitPrice, b.Quantity, c.ProductName,D.CategoryName, Year(OrderDate) as Yr, Month(OrderDate) Mnth
from Orders A 
left join `order details` b on A.orderID = b.OrderID
left join Products C on C.ProductID = b.ProductID
left join categories D on D.CategoryID = C.CategoryID;

-- 1. What are the top selling products and categories from Northwind by month and year? 

Select Yr,Mnth, Categoryname,productname, Sum(quantity*UnitPrice) as Sales
from arun_sandbox.Order_Category_Product
group by Yr,Mnth, Categoryname,productname
order by Categoryname,productname;

/* ---------------------------------- Case Study ----------------------------------------------
2. Which countries have the highest shipping in terms of sales?
3. Who are the top 3 Customers and their Contact Titles per country based on purchases
4. Create the reporting hiererchy of Employees
5. Employee and Manager performance in terms of sales
*/


-- 2. Which countries have the highest shipping in terms of sales? 
-- 2.1 Which countries have the highest shipping in terms of sales? 


select * from arun_sandbox.Order_Category_Product;

Select Yr,Mnth, Shipcity,shipcountry, Sum(quantity*UnitPrice) as Sales
from arun_sandbox.Order_Category_Product
group by Yr,Mnth, Shipcity,shipcountry
order by Shipcity,shipcountry;


/* ---------------------------------- Case Study ----------------------------------------------
3. Who are the top 3 Customers and their Contact Titles per country based on purchases
4. Create the reporting hiererchy of Employees
5. Employee and Manager performance in terms of sales
*/

-- 3. Who are the top 3 Customers and their Contact Titles per country based on purchases

-- Columm - Sales (unitprice & Quantity), Customer_name, Customertitle
-- Tables - Orders, Order details, Customer
-- Join condition - 

-- 3. Who are the top 3 Customers and their Contact Titles per country based on purchases

create table arun_sandbox.Order_Customer_Table
select A.*, b.UnitPrice, b.Quantity,
C.CompanyName,C.ContactName,C.ContactTitle,C.Country
from Orders A 
left join `order details` b on A.orderID = b.OrderID
left join customers C on C.CustomerID = A.CustomerID ;

select * from (
select 
Country, ContactTitle, Contactname, Sum(unitprice*Quantity) as sales, 
row_number() over ( partition by country order by Sum(unitprice*Quantity) desc) as Rnk
from arun_sandbox.Order_Customer_Table
-- where Rnk <= 3 --- Order of execution 
-- Having Rnk <= 3 -- We cannot use alias 
group by Country, ContactTitle, Contactname
Order by Country
) Temp
where Rnk <=3
order by Country asc;

select * from arun_sandbox.Order_Customer_Table;

/* ---------------------------------- Case Study ----------------------------------------------

4. Create the reporting hiererchy of Employees
5. Employee and Manager performance in terms of sales
*/

-- 4. Create the reporting hiererchy of Employees

create table arun_sandbox.Employee_Hierarchy
select 
A.EmployeeID, A.FirstName,
b.employeeID as Mgr_ID, b.Firstname as Mgr_Name
 from employees A
 left join employees B on B.EmployeeID = A.ReportsTo
 
 /* ---------------------------------- Case Study ----------------------------------------------

5. Employee and Manager performance in terms of sales
*/

select * from arun_sandbox.order_employee_manager;
drop table  arun_sandbox.order_employee_manager;

create table arun_sandbox.order_employee_manager
select A.*, b.UnitPrice, b.Quantity,
C.firstname as Mgr_Name, C.Mgr_Name
from northwind.Orders A 
left join Northwind.`order details` b on A.orderID = b.OrderID
left join arun_sandbox.Employee_Hierarchy C on A.employeeid = C.employeeid;

Select Year(OrderDate) YR,Month(OrderDate) Mnth,Mgr_Name, Sum(quantity*UnitPrice) as Sales
from arun_sandbox.order_employee_manager
group by Year(OrderDate) ,Month(OrderDate) 


--- 

create table arun_sandbox.Order_Category_Product
select 
A.*, b.UnitPrice, b.Quantity, c.ProductName,D.CategoryName, Year(OrderDate) as Yr, Month(OrderDate) Mnth
from Orders A 
left join `order details` b on A.orderID = b.OrderID
left join Products C on C.ProductID = b.ProductID
left join categories D on D.CategoryID = C.CategoryID;

-- 1. What are the top selling products and categories from Northwind by month and year? 

Select Yr,Mnth, Categoryname,productname, Sum(quantity*UnitPrice) as Sales
from arun_sandbox.Order_Category_Product
group by Yr,Mnth, Categoryname,productname
order by Categoryname,productname;

 -- What are the top selling products and categories from Northwind by month and year? 
 
 -- Writing Question 1 without Intermidiate table
 
 select
 Year(A.Orderdate) Yr, Month(A.OrderDate)Mnth,
Sum(b.quantity*b.UnitPrice) as Sales,
c.Productname,
d.categoryname
from Orders A 
left join `order details` b on A.orderID = b.OrderID
left join Products C on C.ProductID = b.ProductID
left join categories D on D.CategoryID = C.CategoryID
Group by Yr,Mnth,c.Productname, d.categoryname
 
 
 
 






















