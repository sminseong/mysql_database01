use ssgdb;
show tables;

select bookname, publisher from book;
-- book 테이블의 전체 정보를 출력
select * from book;

-- book 테이블의 구조
describe book;
desc book;

SELECT bookname, publisher
FROM book
WHERE price <= 10000;

-- Oracle, MySQL, MariaDB, PostgreeSQL 관계형 데이터베이스 시스템
show databases;
CREATE DATABASE shopdb;
USE shopdb;

CREATE TABLE memberTBL (
memberID varchar(8) not null,
memberName varchar(10) not null,
memberAddress varchar(20)
);

CREATE TABLE productTBL (
-- productID int auto_increment,
productName VARCHAR(4) NOT NULL,
cost INT NOT NULL,
makeDate DATE
-- primary key(productID)
);

desc memberTBL;
desc productTBL;

-- 테이블 수정
alter table productTBL ADD COLUMN productID int not null unique;
-- 테이블 수정 (컬럼삭제)
alter table productTBL DROP COLUMN productID;
-- 컬럼 변경
alter table productTBL CHANGE COLUMN cost price int;

-- productName 컬럼 앞에 productID 컬럼을 추가
ALTER TABLE productTBL ADD COLUMN productID int not null first;

-- 테이블의 지정 컬럼 뒤에 추가
ALTER TABLE productTBL ADD COLUMN descript varchar(100) not null after price;

-- 컬럼 타입 변경
ALTER TABLE productTBL MODIFY COLUMN price smallint;
ALTER TABLE productTBL MODIFY COLUMN price smallint primary key;
ALTER TABLE productTBL MODIFY COLUMN price smallint;
ALTER TABLE productTBL DROP primary key;

use ssgdb;

select bookname, price from book;
select price, bookname from book;
select bookid, bookname, publisher, price from book;
select distinct publisher from book;

select * from book where price < 20000;
select * from book where price >= 10000 And price <= 20000;
select * from book where price between 10000 and 20000;

select * from book where publisher like '굿스포츠' or publisher like '대한미디어';
select * from book where publisher in ('굿스포츠', '대한미디어');

select * from book where publisher not like '굿스포츠' and publisher not like '대한미디어';
select * from book where publisher not in ('굿스포츠', '대한미디어');

select bookname, publisher from book where bookname = '축구의 역사';
select bookname, publisher from book where bookname like '축구의 역사';

select bookname, publisher from book where bookname like '%축구%';

select * from book where bookname like '_구%';
select * from book where bookname like '__의%';

select * from book where bookname like '%축구%' And price >= 20000;

select * from book where publisher in ('굿스포츠', '대한미디어');

select * from book order by bookname;

select * from book order by price, bookname;

select * from book order by price desc, publisher asc;

select sum(price) AS 총매출 from book;

select * from book where exists (select 1 from book where book.price > 10000);