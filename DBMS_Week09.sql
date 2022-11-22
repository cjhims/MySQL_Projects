-- creating database
create database if not exists DBMS_Week09;
use DBMS_Week09;

-- creating table
CREATE TABLE employee (
    id INT,
    name VARCHAR(255),
    department VARCHAR(255),
    salary FLOAT
);

desc employee;
insert into employee values(1, 'Aman','IT', 12000.0),
(2, 'Bhuvan','HR', 15000.0),
(3, 'Chandan','Admin', 18000.0),
(4, 'Ramesh','Admin', 17000.0),
(5, 'Jojin','IT', 13500.0),
(6, 'Samuel','Admin', 18000.0);
SELECT 
    *
FROM
    employee;
SELECT 
    id, name
FROM
    employee
WHERE
    department = 'IT';

/*aggregate functions*/
SELECT 
    SUM(salary), AVG(salary), MAX(salary), MIN(salary)
FROM
    employee;

/*Order By Clause*/
SELECT 
    *
FROM
    employee
ORDER BY department;
SELECT 
    *
FROM
    employee
ORDER BY department ASC;
SELECT 
    *
FROM
    employee
WHERE
    salary > 15000
ORDER BY department;

-- Special operators
SELECT 
    name
FROM
    employee
WHERE
    name NOT LIKE '%a%';

-- creating table restaurant
CREATE TABLE restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);
insert into restaurant values (1, 'Punjabi Rasoi');
insert into restaurant values (2, 'Udupi Grand');
insert into restaurant values (3, 'BBQ nation');
SELECT 
    *
FROM
    restaurant;

-- creating table dishes with foreign key
CREATE TABLE dishes (
    dishid INT PRIMARY KEY,
    dishName VARCHAR(255),
    price FLOAT,
    restaurantId INT,
    FOREIGN KEY (restaurantId)
        REFERENCES restaurant (id)
);
insert into dishes values(1,'Dal Makhni', 120.00, 1);
insert into dishes values(2,'Sarso Saag', 100.00, 1);
insert into dishes values(3,'Tandoori Roti', 12.00, 1);
insert into dishes values(4, 'Masala Dosa' , 40.00, 2);
insert into dishes values (5, ' Rava Idly', 50.00 , 2);
insert into dishes values ( 6, 'Vada', 30.00, 2);
insert into dishes values ( 7, 'pizza', 150.00, 3);
insert into dishes values ( 8, 'burger', 80.00, 3);
insert into dishes values (9, 'Momos', 50.00,3);

-- Joins
SELECT 
    d.dishName, d.price, r.name
FROM
    dishes d
        LEFT JOIN
    restaurant r ON d.restaurantId = r.id;
SELECT 
    d.dishName, d.price, r.name
FROM
    dishes d
        RIGHT JOIN
    restaurant r ON d.restaurantId = r.id;
SELECT 
    d.dishName, d.price, r.name
FROM
    dishes d
        INNER JOIN
    restaurant r ON d.restaurantId = r.id;

SELECT 
    COUNT(DISTINCT (price))
FROM
    dishes;

SELECT DISTINCT
    (r.name)
FROM
    restaurant r,
    dishes d
WHERE
    r.id = d.restaurantId AND d.price < 20;

SELECT 
    r.name
FROM
    restaurant r,
    dishes d
WHERE
    r.id = d.restaurantId
GROUP BY restaurantId
HAVING COUNT(restaurantId) > 2;

UPDATE dishes 
SET 
    price = price * 1.10
WHERE
    price <= 50;

-- Stored Procedure
-- creating table
CREATE TABLE test100 (
    id INT
);
-- creating procedure
/*The first and last DELIMITER commands are not a part of the stored procedure.
 The first DELIMITER command changes the default delimiter to // and the last 
 DELIMITER command changes the delimiter back to the default one which is semicolon (;).*/
DELIMITER //
CREATE PROCEDURE GetAllDishes()
BEGIN
	SELECT *  FROM dishes;
END //
DELIMITER ;
-- executing procedure GetAllDishes()
call GetAllDishes();

-- Views
-- creating view
CREATE OR REPLACE VIEW restaurant_view AS
    SELECT 
        d.dishName, d.price, r.name
    FROM
        dishes d
            LEFT JOIN
        restaurant r ON d.restaurantId = r.id;
-- accessing view
SELECT 
    *
FROM
    restaurant_view;
