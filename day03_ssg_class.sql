-- 1. 운영자적 관점 SQL : 집계 (aggregate) -> 집계함수(aggregate function) 제공
-- 집계함수란 테이블의 각 열에 대해 계산하는 함수

-- 1. 고객(customer)이 주문한 도서의 총판매액을 구하세요.
use ssgdb;
show tables;
select * from customer;

SELECT SUM(saleprice) AS '총매출'
FROM orders;

-- 2
SELECT SUM(saleprice) AS '총매출'
FROM orders
WHERE custid=2;

SELECT SUM(o.saleprice) AS '김연아 총매출'
FROM customer c
JOIN orders o ON(c.custid = o.custid)
WHERE c.name = '김연아';

-- 3
SELECT SUM(saleprice) AS TOTAL, AVG(saleprice) AS AVERAGE, MIN(saleprice) AS MINIMUM, MAX(saleprice) AS MAXIMUM
FROM orders;

-- 4 count() -> 행의 개수를 셈		count(*) 전체 튜플의 수 반환하는데 Null을 제하고 반환
SELECT COUNT(orderid)
FROM orders;

-- 5
SELECT custid AS CUSTID, COUNT(custid) AS 도서수량, SUM(saleprice) AS 총액
FROM orders
GROUP BY custid;

-- 6
SELECT custid AS CUSTID, COUNT(custid) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(custid) >= 2;

-- sakila_db 
-- sakiladb 생성, sakila 사용자를 만들어 sakiladb에 대한 모든 접근 권한 부여


-- GROUP BY 절 사용하면 속성값이 같은 값끼리 그룹을 만들 수 있다.alter

SELECT * FROM customer;

-- 3-19
SELECT custid AS 고객아이디, count(bookid) AS 도서수량, SUM(saleprice) AS 총액
FROM orders
GROUP BY custid;

-- 3-20
SELECT custid AS CUSTID, COUNT(custid) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(custid) >= 2;

SELECT custid, bookid, SUM(saleprice)
FROM orders
GROUP BY bookid;
