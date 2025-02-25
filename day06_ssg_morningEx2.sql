CREATE DATABASE saledb;
use saledb;

CREATE TABLE Salesperson (
	name varchar(10) PRIMARY KEY,
    age int NOT NULL,
    salary int NOT NULL
);

CREATE TABLE Orders (
	number int NOT NULL,
    custname varchar(10),
    salesperson varchar(10),
    amount int NOT NULL,
    PRIMARY KEY(custname, salesperson)
);

ALTER TABLE Orders ADD CONSTRAINT fk_ordersale_custname FOREIGN KEY(custname) REFERENCES Customer(name);
ALTER TABLE Orders ADD CONSTRAINT fk_ordersale_salesperson FOREIGN KEY(salesperson) REFERENCES Salesperson(name);
ALTER TABLE Orders MODIFY COLUMN number INT NOT NULL UNIQUE AUTO_INCREMENT;

CREATE TABLE Customer (
	name varchar(10) PRIMARY KEY,
    city varchar(10) NOT NULL,
    industrytype varchar(10) NOT NULL
);

-- 1
INSERT INTO Salesperson VALUES 
	('TOM', 20, 30000),
    ('JOY', 31, 15000),
    ('BOB', 22, 27000);
    
INSERT INTO Customer VALUES
	('KIM', 'LA', 'sale'),
    ('PARK', 'SSS', 'sale'),
    ('SEO', 'LA', 'sale');
    
INSERT INTO Orders VALUES
	(null, 'KIM', 'TOM', 5),
    (null, 'PARK', 'TOM', 10),
    (null, 'SEO', 'JOY', 3),
    (null, 'KIM', 'JOY', 7),
	(null, 'PARK', 'BOB', 1);
    
-- 2
SELECT DISTINCT name, salary FROM Salesperson;

-- 3
SELECT name FROM Salesperson WHERE age < 30;

-- 4
SELECT name FROM Customer WHERE city LIKE '%S';

-- 5
SELECT COUNT(DISTINCT custname) AS '주문한 고객의 수' FROM Orders;

-- 6
SELECT salesperson, COUNT(custname) AS 주문수 FROM Orders GROUP BY salesperson;

-- 7
SELECT name, age FROM Salesperson WHERE name in
	(SELECT salesperson FROM Orders WHERE custname in 
		(SELECT name FROM Customer WHERE city = 'LA'));

-- 8
SELECT DISTINCT s.name, s.age
FROM Salesperson s
JOIN Orders o ON(s.name = o.salesperson)
JOIN Customer c ON(o.custname = c.name)
WHERE c.city = 'LA';

-- 9
SELECT name, age FROM Salesperson WHERE name in
	(SELECT salesperson FROM Orders GROUP BY salesperson HAVING COUNT(*) >= 2);
    
-- 10
UPDATE Salesperson SET salary = 45000 WHERE name = 'TOM';
SELECT * FROM Salesperson;