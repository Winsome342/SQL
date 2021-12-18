/* Merge Data from multiple tables

•	Merge data from multiple tables with JOIN – Inner, Full, Left and Right
•	Combine rows with UNION & Union all
•	Return data from multiple tables with IN
•	Selecting data using SUBQUERIES
•	Create SQL tables to store data
 
 How to write case statement in SQL 

*/


-- Join 
use sakila;

select * from customer;
select * from address;

select C.first_name, C.Last_Name, 
D.address, D.district, d.city_id, D.postal_code, D.Phone
from customer C
left join address D ON C.address_ID = D.Address_ID;


-- How to perform a full join


select C.first_name, C.Last_Name, 
D.address, D.district, d.city_id, D.postal_code, D.Phone
from customer C
Left join address D ON C.address_ID = D.Address_ID

Union

select C.first_name, C.Last_Name, 
D.address, D.district, d.city_id, D.postal_code, D.Phone
from customer C
Right join address D ON C.address_ID = D.Address_ID;

-- Union  -- Combine data from 2 or more select statement and removes duplicates
-- Union all -- Combine data from 2 or more select statement


-- write a query to get customer name, customer adress & city 
-- customer
-- address
-- city

select * from customer;
Select * from address;
select * from city;


select C.first_name, C.Last_Name, 
D.address,E.City
from customer C
Left join address D ON C.address_ID = D.Address_ID
Left Join City E ON D.City_Id = E.City_ID;


-- sub queries

-- write a query to get rental information for Jennifer

select * from rental;

select * from customer where first_name = 'Jennifer';

select * from rental where customer_id = 6;

select * from Rental where customer_ID in (

select customer_ID from customer where first_name = 'Jennifer'

);

-- Write a query to get top 3 films based on Rental amount

select * from (

SELECT title, rating, (rental_duration*rental_rate) AS rental_amount ,
ROW_NUMBER() OVER (PARTITION BY rating ORDER BY (rental_duration*rental_rate) desc) as Rnk
FROM film ) Temp 

Where rnk%2 <> 0 

-- Create Data base and Create Table 

show databases ;

create database Test_Db;
drop database test_db; 

create database arun_sandbox;


Create table arun_Sandbox.Film_top_Rank_Odd
select * from (
SELECT title, rating, (rental_duration*rental_rate) AS rental_amount ,
ROW_NUMBER() OVER (PARTITION BY rating ORDER BY (rental_duration*rental_rate) desc) as Rnk
FROM film ) Temp 
Where rnk%2 <> 0 

select * from arun_Sandbox.Film_top_Rank_Odd;


select * from arun_sandbox.actor_nov_v1;

-- How to write Case Statement in SQL 

-- case statement is same as If - Then - Else statement 

-- If marks > 60 then "Good" else "bad"

-- Case 
-- When Condtion 1 Then Result 1
-- Whend condition 2 Then Result 2
--
--
-- When Condition N then Result N
-- END

use sakila;

select * from film;

select distinct rating from Film; 

/* 
G - General Audience
PG - Parental Guidance
PG -13 Parental Guidcane below 13 years
NC - 17 - Adults only above 17 yeart
R - Restricted
*/

select distinct Rating, Category from (

select Title, Rating, 
Case
When rating = 'G' Then 'General'
When rating in ('PG', 'PG-13','R') Then 'Guided'
Else 'Adults'
End as Category
from Film
) Cases;

use sakila;
SELECT first_name 
FROM actor
where first_name = 'Grace'

use arun_sandbox;

Create table Employee (
First_Name varchar(25),
salary int(30)
);

select * from Employee;

Insert into Employee (First_name, Salary) values
('Grace','10000'),
('    Grace    ','20000');


select * from Employee
where first_name = 'Grace'

select * from Employee
where trim(first_name) = 'Grace'
















