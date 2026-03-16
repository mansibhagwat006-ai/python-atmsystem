create database assessment;
use assessment;

create table Country(
country_id int primary key,
country_name varchar (40),
country_name_eng varchar(40),
country_code varchar(15));

INSERT INTO country VALUES
(1, 'Deutschland', 'Germany', 'DEU'),
(2, 'Srbija', 'Serbia', 'SRB'),
(3, 'Hrvatska', 'Croatia', 'HRV'),
(4, 'United States of America', 'United States of America', 'USA'),
(5, 'Polska', 'Poland', 'POL'),
(6, 'España', 'Spain', 'ESP'),
(7, 'Rossiya', 'Russia', 'RUS');



create table City(
city_id int primary key,
city_name varchar (15),
lat decimal (10,6),
longitude  decimal (15,7),
country_id INT,
FOREIGN KEY (country_id) REFERENCES country(country_id));


INSERT INTO city VALUES
(1, 'Berlin', 52.520008, 13.404954, 1),
(2, 'Belgrade', 44.787197, 20.457273, 2),
(3, 'Zagreb', 45.815399, 15.966568, 3),
(4, 'New York', 40.730610, -73.935242, 4),
(5, 'Los Angeles', 34.052235, -118.243683, 4),
(6, 'Warsaw', 52.237049, 21.017532, 5);



create table Customer(
customer_id int primary key,
customer_name varchar (25),
city_id int,
customer_address varchar (25),
next_call_date date,
ts_inserted datetime,
FOREIGN KEY (city_id) REFERENCES city(city_id));







-- Task : 1 (join multiple tables using left join)
-- List all Countries and customers related to these countries.
-- For each country displaying its name in English, the name of the city customer is located in as
-- well as the name of the customer.
-- Return even countries without related cities and customers


select co.country_name_eng, ci.city_name, cu.customer_name
from country co
left join city ci
on co.country_id = ci.country_id
left join customer cu
on ci.city_id = cu.city_id;




-- Task : 2 (join multiple tables using both left and inner join)
-- Return the list of all countries that have pairs(exclude countries which are not referenced by any
-- city). For such pairs return all customers.
-- Return even pairs of not having a single customer

select co.country_name, cu.customer_name
from country co
join city ci
on co.country_id = ci.country_id
left join customer cu
on ci.city_id = cu.city_id;

