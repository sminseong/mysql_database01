-- 두 개 이상의 테이블을 이용한 SQL 질의 방법
SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM book;
-- JOIN 은 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는 연산

SELECT * FROM customer, orders; -- 크로스 조인
SELECT COUNT(*) FROM customer;	-- 5명
SELECT COUNT(*) FROM orders; 	-- 10건
-- 5 X 10 = 50	(조건이 없는 테이블간의 조인을 Cross Join)

-- 고객과 고객의 주문에 관한 데이터를 모두 출력하시오. (동등조인 equi join)
SELECT * FROM customer, orders WHERE customer.custid = orders.custid;
SELECT * FROM customer c JOIN orders o ON (c.custid = o.custid);

SELECT * FROM customer c JOIN orders o ON (c.custid = o.custid) ORDER BY c.custid;

-- 3-23
SELECT c.name NAME, o.saleprice SALEPRICE FROM customer c JOIN orders o ON (c.custid = o.custid);
SELECT c.name, o.saleprice
FROM customer c, orders o
WHERE c.custid = o.custid;

-- 3-24
SELECT c.name, SUM(saleprice)
FROM customer c
JOIN orders o ON (c.custid = o.custid)
GROUP BY c.name
ORDER BY c.name;

SELECT c.name, SUM(saleprice)
FROM customer c, orders o
WHERE c.custid = o.custid
GROUP BY c.name
ORDER BY c.name;

-- 3-25
SELECT c.name, b.bookname
FROM customer c
JOIN orders o ON (c.custid = o.custid)
JOIN book b ON (b.bookid = o.bookid);

SELECT c.name, b.bookname
FROM customer c, orders o, book b
WHERE c.custid = o.custid AND o.bookid = b.bookid;

-- 3-26
SELECT c.name, b.bookname
FROM customer c
JOIN orders o ON (c.custid = o.custid)
JOIN book b ON (b.bookid = o.bookid)
WHERE o.saleprice >= 20000;

SELECT c.name, b.bookname, b.price
FROM customer c, orders o, book b
WHERE c.custid = o.custid AND o.bookid = b.bookid AND b.price >= 20000;


-- 3-27 외부 조인(outer join)
SELECT c.name, o.saleprice
FROM customer c
LEFT JOIN orders o ON (c.custid = o.custid);

-- 3-28
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

-- 직원들의 직속상사의 정보를 출력하시요. (self join)
SELECT staff.last_name, staff.job_id, manager.last_name, manager.job_id
FROM employees staff, employees manager
WHERE staff.manager_id = manager.employee_id;


SELECT MAX(price) FROM book;
SELECT bookname FROM book WHERE price = 35000;
-- 두개의 질의를 하나의 질의로 만들 수는 없을까? 	subquery(부속질의)로 해결가능하다.
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

-- 단일행 - 단일열( 1 X 1 )		연산자 =
-- 다중행 - 단일열( n X 1 )		연산자 in	 	
-- 단일행 - 다중열( 1 X n )
-- 다중행 - 다중열( n X n )

-- 도서를 구매한 적이 있는 고객의 이름을 출력하세요.
SELECT custid FROM orders;
SELECT name FROM customer WHERE custid in (1, 2, 3, 4);

SELECT custid
FROM orders
WHERE custid in (SELECT custid FROM orders);

-- 3-29
SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders WHERE bookid IN (SELECT bookid FROM book));

SELECT c.name
FROM customer c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.custid = c.custid); 

SELECT DISTINCT c.name
FROM customer c
JOIN orders o ON (c.custid = o.custid);

-- 3-30
SELECT DISTINCT c.name
FROM customer c
JOIN orders o ON (c.custid = o.custid)
JOIN book b ON (b.bookid = o.bookid)
WHERE b.publisher = '대한미디어';

SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders WHERE bookid IN (SELECT bookid FROM book WHERE publisher = '대한미디어'));

SELECT c.name
FROM customer c
WHERE EXISTS (SELECT 1 FROM orders o JOIN book b ON (o.bookid = b.bookid) 
			  WHERE c.custid = o.custid AND b.publisher = '대한미디어');
			


-- 부속질의 간에는 상하관계가 있다. 먼저 하위부속질의를 실행하고, 그 결과를 이용하여 상위 부속질의를 실행한다.

-- 상관부속질의 (correlated subquery) 상위 부속질의와 하위 부속질의가 독립적이지 않고 서로 관련을 맺고 있다.

-- 3-31
SELECT * FROM book WHERE publisher = '굿스포츠';
SELECT AVG(PRICE) FROM BOOK GROUP BY publisher;
SELECT * FROM book WHERE price >= 14450;

SELECT * FROM book GROUP BY publisher HAVING price >= (SELECT AVG(PRICE) FROM BOOK GROUP BY publisher);
SELECT b1.bookname
FROM book b1
WHERE price >= (SELECT AVG(b2.price) FROM book b2 WHERE b2.publisher = b1.publisher);


SELECT b1.bookname
FROM book b1
WHERE b1.price >= (SELECT AVG(b2.price)
				   FROM book b2
                   WHERE b2.publisher = b1.publisher);



