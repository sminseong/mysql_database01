-- 연습문제
SELECT * FROM orders;
-- 1-1
SELECT bookname AS '도서명'
FROM book
WHERE bookid = 1;

-- 1-2
SELECT bookname AS '도서명'
FROM book
WHERE price >= 20000;

-- 1-3
SELECT SUM(saleprice) AS '총구매액'
FROM orders
WHERE custid = 1;

-- 1-4
SELECT COUNT(bookid) AS '구매한 도서의 수'
FROM orders
WHERE custid = 1;

-- 2-1
SELECT COUNT(*) AS '총갯수'
FROM book;

-- 2-2
SELECT COUNT(DISTINCT publisher) AS '출판사수'
FROM book;

-- 2-3
SELECT name AS 이름, address AS 주소
FROM customer;

-- 2-4
SELECT orderid AS '주문번호'
FROM orders
WHERE orderdate BETWEEN '2024-07-04' AND '2024-07-07';

-- 2-5
SELECT orderid AS '주문번호'
FROM orders
WHERE orderdate NOT BETWEEN '2024-07-04' AND '2024-07-07';

-- 2-6
SELECT name AS 이름, address AS 주소
FROM customer
WHERE name LIKE '김%';

-- 2-7
SELECT name AS 이름, address AS 주소
FROM customer
WHERE name LIKE '김%아';