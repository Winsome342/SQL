use sakila


-- write a query to get cust name , address and city name 

-- Tables required Customer, adrress and city

-- columns required -- Customer name, address and city name

Select 
A.first_name,a.last_name, B.address, c.city
from Customer A 
left join address B On a.address_Id = B.address_ID
Left Join City C On B.city_id = c.city_ID

select * from address;
select * from city;
Select * from Customer;



-- hierarchy table of employess

use northwind;

select A.EmployeeID, A.FirstName, a.ReportsTo, 
b.firstName as mgrname 
from employees A
left join employees B on a.reportsto = b.employeeid



