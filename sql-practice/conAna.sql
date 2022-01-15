--use fran

--drop table emp;
--drop table rol;

create table emp (
    id int  NOT NULL IDENTITY(1, 1),
    name varchar(30)  NOT NULL,
    age int  NOT NULL,
    CONSTRAINT emp_pk PRIMARY KEY  (id)
);

--select * from emp;


create table rol (
    id int  NOT NULL IDENTITY(1, 1),
	name varchar(30)  NOT NULL,
	description varchar(200)  NOT NULL,
	emp_id int NOT NULL,
	CONSTRAINT rol_pk PRIMARY KEY  (id)
);


--select * from rol;


-- foreign keys
-- Reference: city_country (table: city)
--ALTER TABLE city ADD CONSTRAINT city_country
--    FOREIGN KEY (country_id)
--    REFERENCES country (id);

alter table rol add constraint emp_rol
	foreign key (emp_id)
	references rol (id);


INSERT INTO emp (name,age) VALUES ('fran', '32');
INSERT INTO emp (name,age) VALUES ('ana', '33');
INSERT INTO emp (name,age) VALUES ('chiqui', '2');
INSERT INTO emp (name,age) VALUES ('negra', '3');

INSERT INTO rol (name,description,emp_id) VALUES ('it', 'inf techs', '1');
INSERT INTO rol (name,description,emp_id) VALUES ('manag', 'manager stuff', '2');
INSERT INTO rol (name,description,emp_id) VALUES ('ceo', 'boss', '3');
INSERT INTO rol (name,description,emp_id) VALUES ('rec', 'absurding', '4');
INSERT INTO rol (name,description,emp_id) VALUES ('adm', 'admin', '2');
INSERT INTO rol (name,description,emp_id) VALUES ('cto', 'chief tech', '1');
INSERT INTO rol (name,description,emp_id) VALUES ('it', 'chiqui', '3');
INSERT INTO rol (name,description,emp_id) VALUES ('adm', 'negra', '4');



select * from emp;

select * from rol;

select * from emp join rol on emp.id = rol.emp_id;

select rol.id, rol.name, rol.description, emp.name, emp.age from rol join emp on emp.id = rol.emp_id where emp.name like '%f%';

select rol.id, rol.name, rol.description, emp.name, emp.age 
from rol join emp 
on emp.id = rol.emp_id 
where emp.age > 10;

select name, count(*) as count from rol group by name; 
