-- CREATE DATABASE database_name;
-- Table: city
CREATE TABLE city (
    id int  NOT NULL IDENTITY(1, 1),
    city_name char(128)  NOT NULL,
    lat decimal(9,6)  NOT NULL,
    long decimal(9,6)  NOT NULL,
    country_id int  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY  (id)
);

select * from city;

-- Table: country
CREATE TABLE country (
    id int  NOT NULL IDENTITY(1, 1),
    country_name char(128)  NOT NULL,
    country_name_eng char(128)  NOT NULL,
    country_code char(8)  NOT NULL,
    CONSTRAINT country_ak_1 UNIQUE (country_name),
    CONSTRAINT country_ak_2 UNIQUE (country_name_eng),
    CONSTRAINT country_ak_3 UNIQUE (country_code),
    CONSTRAINT country_pk PRIMARY KEY  (id)
);


-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country
    FOREIGN KEY (country_id)
    REFERENCES country (id);

-- check cols
select * from city;
select * from country;

 -- INSERT INTO table_name (column_list) VALUES (column_values);
-- INSERT INTO table_name VALUES (column_values);

INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Deutschland', 'Germany', 'DEU');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Srbija', 'Serbia', 'SRB');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Hrvatska', 'Croatia', 'HRV');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('United Stated of America', 'United Stated of America', 'USA');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Polska', 'Poland', 'POL');

INSERT INTO city (city_name, lat, long, country_id) VALUES ('Berlin', 52.520008, 13.404954, 1);
INSERT INTO city (city_name, lat, long, country_id) VALUES ('Belgrade', 44.787197, 20.457273, 2);
INSERT INTO city (city_name, lat, long, country_id) VALUES ('Zagreb', 45.815399, 15.966568, 3);
INSERT INTO city (city_name, lat, long, country_id) VALUES ('New York', 40.73061, -73.935242, 4);
INSERT INTO city (city_name, lat, long, country_id) VALUES ('Los Angeles', 34.052235, -118.243683, 4);
INSERT INTO city (city_name, lat, long, country_id) VALUES ('Warsaw', 52.237049, 21.017532, 5);


-- check cols
select * from city;
select len(country_name) as len, country_name from country order by 1 desc;

SELECT *
FROM city
WHERE lat BETWEEN 40 AND 45 order by lat;


-- FKs prevent us from inserting wrong or unrelated data, here country_id = 6 does not exist
INSERT INTO city (city_name, lat, long, country_id) VALUES ('Wien', 48.2084885, 16.3720798, 6);

--SELECT 1;
--SELECT 1+2;
--SELECT 1+2 AS result;
--SELECT 1+2 AS first_result, 2*3 AS second_result;
--SELECT (CASE WHEN 1+2 > 2*3 THEN 'greater' ELSE 'smaller' END) AS comparison;

--SELECT [TOP X] attributes & values
--FROM first_table
--INNER / LEFT / RIGHT JOIN second_table ON condition(s)
--... other joins if needed
--WHERE condition(s)
--GROUP BY set of attributes
--HAVING condition(s) for group by
--ORDER BY list attributes and order;

SELECT city.id AS city_id, city.city_name, country.id AS country_id, country.country_name, country.country_name_eng, country.country_code
FROM city
INNER JOIN country ON city.country_id = country.id
WHERE country.id IN (1,4,5);

select * from  city as cty 
join country as ctr on cty.country_id = ctr.id
WHERE cty.id IN (1,4,5);

-- adding more data
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('España', 'Spain', 'ESP');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Rossiya', 'Russia', 'RUS');


-- check cols
select * from city;
select * from country;

SELECT *
FROM country, city
WHERE city.country_id = country.id;
    
SELECT *
FROM country
INNER JOIN city ON city.country_id = country.id;


-- the use for LEFT JOIN mainly lies on searching if there are Rows without relations
SELECT *
FROM country
LEFT JOIN city ON city.country_id = country.id;

--drop table customer;
--drop table employee;
--drop table call;
--drop table call_outcome;


-- tables
-- Table: call
CREATE TABLE call (
    id int  NOT NULL IDENTITY(1, 1),
    employee_id int  NOT NULL,
    customer_id int  NOT NULL,
    start_time datetime  NOT NULL,
    end_time datetime  NULL,
    call_outcome_id int  NULL,
    CONSTRAINT call_ak_1 UNIQUE (employee_id, start_time),
    CONSTRAINT call_pk PRIMARY KEY  (id)
);

-- Table: call_outcome
CREATE TABLE call_outcome (
    id int  NOT NULL IDENTITY(1, 1),
    outcome_text char(128)  NOT NULL,
    CONSTRAINT call_outcome_ak_1 UNIQUE (outcome_text),
    CONSTRAINT call_outcome_pk PRIMARY KEY  (id)
);
    
-- Table: customer
CREATE TABLE customer (
    id int  NOT NULL IDENTITY(1, 1),
    customer_name varchar(255)  NOT NULL,
    city_id int  NOT NULL,
    customer_address varchar(255)  NOT NULL,
    next_call_date date  NULL,
    ts_inserted datetime  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY  (id)
);
    
-- Table: employee
CREATE TABLE employee (
    id int  NOT NULL IDENTITY(1, 1),
    first_name varchar(255)  NOT NULL,
    last_name varchar(255)  NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY  (id)
);
    
-- foreign keys
-- Reference: call_call_outcome (table: call)
ALTER TABLE call ADD CONSTRAINT call_call_outcome
    FOREIGN KEY (call_outcome_id)
    REFERENCES call_outcome (id);
    
-- Reference: call_customer (table: call)
ALTER TABLE call ADD CONSTRAINT call_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);
 
-- Reference: call_employee (table: call)
ALTER TABLE call ADD CONSTRAINT call_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (id);
 
-- Reference: customer_city (table: customer)
ALTER TABLE customer ADD CONSTRAINT customer_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);
    
-- insert values
INSERT INTO call_outcome (outcome_text) VALUES ('call started');
INSERT INTO call_outcome (outcome_text) VALUES ('finished - successfully');
INSERT INTO call_outcome (outcome_text) VALUES ('finished - unsuccessfully');
    
INSERT INTO employee (first_name, last_name) VALUES ('Thomas (Neo)', 'Anderson');
INSERT INTO employee (first_name, last_name) VALUES ('Agent', 'Smith');
    
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Jewelry Store', 4, 'Long Street 120', '2020/1/21', '2020/1/9 14:1:20');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Bakery', 1, 'Kurfürstendamm 25', '2020/2/21', '2020/1/9 17:52:15');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Café', 1, 'Tauentzienstraße 44', '2020/1/21', '2020/1/10 8:2:49');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Restaurant', 3, 'Ulica lipa 15', '2020/1/21', '2020/1/10 9:20:21');
    
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 4, '2020/1/11 9:0:15', '2020/1/11 9:12:22', 2);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 2, '2020/1/11 9:14:50', '2020/1/11 9:20:1', 2);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 3, '2020/1/11 9:2:20', '2020/1/11 9:18:5', 3);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 1, '2020/1/11 9:24:15', '2020/1/11 9:25:5', 3);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 3, '2020/1/11 9:26:23', '2020/1/11 9:33:45', 2);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 2, '2020/1/11 9:40:31', '2020/1/11 9:42:32', 2);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 4, '2020/1/11 9:41:17', '2020/1/11 9:45:21', 2);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 1, '2020/1/11 9:42:32', '2020/1/11 9:46:53', 3);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 1, '2020/1/11 9:46:0', '2020/1/11 9:48:2', 2);
INSERT INTO call (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 2, '2020/1/11 9:50:12', '2020/1/11 9:55:35', 2);


-- show tables
SELECT
  *
FROM
  INFORMATION_SCHEMA.TABLES;
GO


SELECT * FROM customer INNER JOIN city ON customer.city_id = city.id;
 
SELECT * FROM employee as e LEFT JOIN call as c ON e.id = c.employee_id;
 
SELECT * FROM city LEFT JOIN customer ON customer.city_id = city.id;

-- get time of calls
select *, DATEDIFF ( MINUTE , start_time , end_time ) as time from call;

-- select from Multiple tables
SELECT * FROM employee as e 
LEFT JOIN call as c ON e.id = c.employee_id
LEFT JOIN call_outcome as co ON c.call_outcome_id = co.id;


-- Aggregate Functions

select ctr.country_name, count(cty.country_id) as n_cities from city as cty
join country as ctr
on cty.country_id = ctr.id group by ctr.country_name;

-- AVG latitude of countries
select ctr.country_name, avg(cty.lat) as avg_lat from city as cty
join country as ctr
on cty.country_id = ctr.id group by ctr.country_name having ctr.country_name like '%ka%';

select *, DATEDIFF ( MINUTE , start_time , end_time ) as time from call;

-- select from Multiple tables

use fran

SELECT 
	country.country_name_eng,
	SUM(CASE WHEN call.id IS NOT NULL THEN 1 ELSE 0 END) AS calls,
	AVG(ISNULL(DATEDIFF(SECOND, call.start_time, call.end_time),0)) AS avg_difference
FROM country 
LEFT JOIN city ON city.country_id = country.id
LEFT JOIN customer ON city.id = customer.city_id
LEFT JOIN call ON call.customer_id = customer.id
GROUP BY 
	country.id,
	country.country_name_eng
ORDER BY calls DESC, country.id ASC;


-- gives Nº calls and it's avg time by Country
SELECT 
ctr.country_name,
sum(case when cl.id is not null then 1 else 0 end) as calls,
avg(isnull( datediff(minute, cl.start_time, cl.end_time ),0)) as avg_time
FROM country as ctr  
LEFT JOIN city as cty ON ctr.id = cty.country_id
LEFT JOIN customer as cus ON cty.id = cus.city_id
LEFT JOIN call as cl ON cus.id = cl.customer_id
group by ctr.country_name order by 3 desc;

-- left joins country and city a country has no city it returns 'no-city'
select country.country_name,
isnull(city.city_name, 'no-city') as city
from country
left join city on
country.id = city.country_id;

SELECT 
ctr.country_name,
sum(case when cl.id is not null then 1 else 0 end) as calls,
avg(isnull( datediff(minute, cl.start_time, cl.end_time ),0)) as avg_time
FROM country as ctr  
LEFT JOIN city as cty ON ctr.id = cty.country_id
LEFT JOIN customer as cus ON cty.id = cus.city_id
LEFT JOIN call as cl ON cus.id = cl.customer_id
group by ctr.country_name
having avg(isnull(datediff(minute, cl.start_time, cl.end_time),0)) > 
(select avg(datediff(minute, call.start_time, call.end_time)) from call)
order by avg_time desc;


SELECT * FROM sys.databases;
EXEC sp_databases;
 
-- list of all tables in the selected database
SELECT *
FROM INFORMATION_SCHEMA.TABLES;
    
-- list of all constraints in the selected database
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

-- list all table constraints and it's type == FK
select ist.TABLE_NAME, istc.CONSTRAINT_NAME, istc.CONSTRAINT_TYPE
from information_schema.TABLES as ist
inner join information_schema.TABLE_CONSTRAINTS as istc
on ist.TABLE_NAME = istc.TABLE_NAME
where istc.CONSTRAINT_TYPE like '%foreign%'
order by 1, 3;

-- join tables and constraints data
select 
ist.TABLE_NAME,
sum(case when istc.CONSTRAINT_TYPE = 'PRIMARY KEY' then 1 else 0 end) as PK,
sum(case when istc.CONSTRAINT_TYPE = 'FOREIGN KEY' then 1 else 0 end) as FK,
sum(case when istc.CONSTRAINT_TYPE = 'UNIQUE KEY' then 1 else 0 end) as UN
from information_schema.TABLES as ist
inner join information_schema.TABLE_CONSTRAINTS as istc
on ist.TABLE_NAME = istc.TABLE_NAME
group by ist.TABLE_NAME
order by 1;
