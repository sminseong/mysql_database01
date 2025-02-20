show databases;
use ssgdb;
show tables;

CREATE TABLE memberTBL(
memberID CHAR(8) NOT NULL,
memberName CHAR(5) NOT NULL,
memberAddress CHAR(20)
);

CREATE TABLE productTBL(
productName CHAR(4) NOT NULL,
cost INT NOT NULL,
makeDate DATE,
company CHAR(5),
amount INT NOT NULL
);

desc memberTBL;
desc productTBL;

ALTER TABLE productTBL ADD COLUMN product_ID INT NOT NULL UNIQUE;
ALTER TABLE productTBL DROP COLUMN product_ID;

ALTER TABLE productTBL CHANGE COLUMN cost pay INT;
ALTER TABLE productTBL ADD COLUMN product_ID INT NOT NULL UNIQUE FIRST;
ALTER TABLE productTBL ADD COLUMN descript VARCHAR(50) AFTER pay;

ALTER TABLE productTBL MODIFY COLUMN descript TEXT;

desc productTBL;