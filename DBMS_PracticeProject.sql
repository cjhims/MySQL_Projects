CREATE database IF NOT EXISTS TravelOnTheGo;
use TravelOnTheGo;
CREATE TABLE PASSENGER (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Passenger_name VARCHAR(50),
    Category VARCHAR(10) CHECK (Category IN ('AC' , 'NON-AC')),
    Gender VARCHAR(10) CHECK (Gender IN ('M' , 'F')),
    Boarding_City VARCHAR(30),
    Destination_City VARCHAR(30),
    Distance INT,
    Bus_Type VARCHAR(20) CHECK (Bus_Type IN ('Sleeper' , 'Sitting'))
);
CREATE TABLE PRICE (
    Bus_Type VARCHAR(20) CHECK (Bus_Type IN ('Sleeper' , 'Sitting')),
    Distance INT,
    Price INT
);
Insert into PASSENGER(Passenger_name, Category,Gender, Boarding_City,Destination_City,Distance,Bus_Type) 
values('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Anmol', 'NON-AC', 'M', 'Mumbai', 'Hyderabad', '700', 'Sitting');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Pallavi', 'AC', 'F', 'Panaji', 'Bangaluru', '600', 'Sleeper');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', '1500', 'Sleeper');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Udit', 'NON-AC', 'M', 'Trivandrum', 'Panaji', '1000', 'Sleeper');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', '500', 'Sitting');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Hemant', 'NON-AC', 'M', 'Panaji', 'Mumbai', '700', 'Sleeper');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Manish', 'NON-AC', 'M', 'Hyderabad', 'Bengaluru', '500', 'Sitting');
INSERT INTO Passenger (`Passenger_name`, `Category`, `Gender`, `Boarding_City`, `Destination_City`, `Distance`, `Bus_Type`) VALUES ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', '700', 'Sitting');

Insert into price values('Sleeper',350,770),
('Sleeper',500,1100),
('Sleeper',600,1320),
('Sleeper',700,1540),
('Sleeper',1000,2200),
('Sleeper',1200,2640),
('Sleeper',1500,2700),
('Sitting',500,620),
('Sitting',600,744),
('Sitting',700,868),
('Sitting',1000,1240),
('Sitting',1200,1488),
('Sitting',1500,1860);

-- Queries
-- How many females and how many male passengers travelled for a minimum distance of 600 KM s?
SELECT 
    COUNT(*)
FROM
    passenger
WHERE
    distance >= 600;
-- Find the minimum ticket price for Sleeper Bus.
SELECT 
    MIN(price)
FROM
    price
WHERE
    bus_type = 'sleeper';
-- Select passenger names whose names start with character 'S' 
SELECT 
    passenger_name
FROM
    passenger
WHERE
    passenger_name LIKE 'S%';
-- Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
SELECT 
    p.Passenger_name,
    p.Boarding_City,
    p.Destination_City,
    p.Bus_Type,
    pr.price
FROM
    price pr
        RIGHT JOIN
    passenger p ON p.distance = pr.distance
        AND p.bus_type = pr.bus_type
ORDER BY passenger_name;
-- What are the passenger name/s and his/her ticket price who travelled in the Sitting bus  for a distance of 1000 KM s
SELECT 
    p.Passenger_name, pr.price
FROM
    price pr
        RIGHT JOIN
    passenger p ON p.distance = pr.distance
        AND p.bus_type = pr.bus_type
WHERE
    p.distance = 1000
        AND p.bus_type = 'sitting';
-- What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT 
    pr.bus_type, pr.price
FROM
    price pr
        INNER JOIN
    passenger p ON p.distance = pr.distance
        AND passenger_name = 'Pallavi';
-- List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
SELECT DISTINCT
    (distance)
FROM
    passenger;
-- Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
Select passenger_name, distance, (distance/sum(distance))*100 as percentage_travelled
from passenger;
-- 11)Display the distance, price in three categories in table Price
-- a)Expensive if the cost is more than 1000
-- b)Average Cost if the cost is less than 1000 and greater than 500
-- c)Cheap otherwise
SELECT 
    distance,
    price,
    CASE
        WHEN price > 1000 THEN 'Expensive'
        WHEN price < 1000 and price>500 THEN 'Average'
        ELSE 'Cheap'
    END as category
FROM
    price;
