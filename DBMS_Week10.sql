create database DBMS_Week10;

use DBMS_Week10;

CREATE TABLE SALESMAN (
    S_ID INT PRIMARY KEY,
    NAME VARCHAR(20),
    CITY VARCHAR(20),
    Earning FLOAT
);

CREATE TABLE CUSTOMER (
    C_ID INT PRIMARY KEY,
    CUST_NAME VARCHAR(20),
    CITY VARCHAR(20),
    GRADE INT,
    S_ID INT,
    FOREIGN KEY (S_ID)
        REFERENCES SALESMAN (S_ID)
);

CREATE TABLE ORDERS (
    ORD_NO INT PRIMARY KEY,
    PURCHASE_AMT INT,
    ORD_DATE VARCHAR(20),
    C_ID INT,
    S_ID INT,
    FOREIGN KEY (S_ID)
        REFERENCES SALESMAN (S_ID),
    FOREIGN KEY (C_ID)
        REFERENCES CUSTOMER (C_ID)
);

INSERT INTO SALESMAN VALUES (1, 'Amit','Delhi',25000), 
(2, 'Ankit','Pune',15000), 
(3, 'Chandra','Ahmedabad',10000), 
(4, 'Monica','Delhi',35000),
(5, 'Rohini','Bhopal',25000);

INSERT INTO CUSTOMER VALUES(10, 'Manish','Ahmedabad', 100, 1), 
(11, 'Nishanth','Chennai', 300, 1), 
(12, 'Guru','Delhi', 400, 2),
(13, 'Sonia','Delhi', 200, 2),
(14, 'Sakshi','Lucknow', 400, 3);

INSERT INTO ORDERS VALUES (1, 5000, '04-MAY-17', 10, 1),
(2, 450, '20-JAN-17', 10, 2),
(3,1000,'24-FEB-17',13,2),
(4,3500,'13-APR-17',14,3),
(5, 550, '09-MAR-17', 12, 2);

SELECT 
    *
FROM
    SALESMAN;
SELECT 
    *
FROM
    customer;
SELECT 
    *
FROM
    orders;

-- Subquery using clauses 
SELECT 
    GRADE, COUNT(DISTINCT (C_ID))
FROM
    CUSTOMER
GROUP BY GRADE
HAVING GRADE > (SELECT 
        AVG(GRADE)
    FROM
        CUSTOMER
    WHERE
        CITY = 'Delhi');

SELECT 
    S_ID, NAME
FROM
    SALESMAN A
WHERE
    1 < (SELECT 
            COUNT(*)
        FROM
            CUSTOMER
        WHERE
            S_ID = A.S_ID);

SELECT 
    SALESMAN.S_ID, NAME, CUST_NAME, Earning
FROM
    SALESMAN,
    CUSTOMER
WHERE
    SALESMAN.CITY = CUSTOMER.CITY 
UNION SELECT 
    S_ID, NAME, 'NO MATCH', Earning
FROM
    SALESMAN
WHERE
    NOT CITY = ANY (SELECT 
            CITY
        FROM
            CUSTOMER)
ORDER BY 2 DESC;

CREATE TABLE employee (
    id INT,
    name VARCHAR(255),
    department VARCHAR(255),
    salary FLOAT
);
insert into employee values(1, 'Aman','IT', 12000.0),(2, 'Bhuvan','HR', 15000.0),(3, 'Chandan','Admin', 18000.0);

-- Using case statement
SELECT 
    name,
    department,
    CASE
        WHEN department = 'Admin' THEN 'Complete the system configuration'
        WHEN department = 'HR' THEN 'Complete the Recruitment process'
        WHEN department = 'IT' THEN 'Complete the Development of new updates'
        ELSE 'department undefined'
    END AS Work
FROM
    employee;
 
 -- Pagination
SELECT 
    *
FROM
    employee
ORDER BY salary DESC
LIMIT 2;
SELECT 
    *
FROM
    employee
LIMIT 2 , 2;
-- or
SELECT 
    *
FROM
    employee
LIMIT 2 OFFSET 2;


-- JDBC
drop table if exists books;
CREATE TABLE books (
    id INT,
    title VARCHAR(50),
    author VARCHAR(50),
    price FLOAT,
    qty INT,
    PRIMARY KEY (id)
);
INSERT INTO books VALUES (1001, 'Java for dummies', 'Ashwani', 10080, 1),
(1002, 'more java for dummies', 'Jovan', 10000, 3),
(1003,'more java for more dummies','Aaron',10003,5),
(1004,'a cup of java','Prajwal',14000,7),
(1005, 'a tea spoon of java', 'Meet', 10002, 2);
SELECT 
    *
FROM
    books;

