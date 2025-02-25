-- 데이터 조작어 (DML) SELECT, DELETE, UPDATE, INSERT
-- 데이터 정의어 (DDL) CREATE, DROP, ALTER

-- test database를 생성하여 ssg@localhost 계정이 객체에 대한 모든 권한을 처리할 수 있도록
use testdb;

-- test_create_table 테이블을 생성하시오, 컬럼은 col_1 int, col_2 varchar(50), col_3 datetime 이다.
CREATE TABLE test_create_table (
col_1 int,
col_2 varchar(50),
col_3 datetime
);

-- test_create_table 에	1, 'testSQL', '2025-01-01' 데이터를 입력하세요.
INSERT INTO test_create_table values (1, 'testSQL', '2025-01-01');
INSERT INTO test_create_table values (1, 'testSQL', now());
INSERT INTO test_create_table values (1, 'testSQL', now());
INSERT INTO test_create_table values (1, 'testSQL', now());
INSERT INTO test_create_table values (1, 'testSQL', now());

INSERT INTO test_create_table(col_1, col_2, col_3) values(1, 'testSQL', now());
INSERT INTO test_create_table(col_1) VALUES(1);

INSERT INTO test_create_table(col_2, col_1, col_3) values('testSQL', 1, now());

-- 입력된 데이터를 확인하세요.
SELECT * FROM test_create_table;
rollback;
commit;

-- 여러 데이터를 한번에 삽입
INSERT INTO test_create_table(col_1, col_2, col_3)
VALUES(8, 'testSQL', now()), (9, 'testSQL', now()), (null, 'testSQL', now()); 

-- test_create_table의 col_1의 컬럼 속성을 변경//  col_1의 속성을 int -> smallint not null 속성 추가
ALTER TABLE test_create_table MODIFY COLUMN col_1 smallint NOT NULL;
desc test_create_table;

-- UPDATE 문으로 데이터 수정
-- UPDATE test_create_table SET 열1, 열2, 열3 WHERE [열 = 조건];
SELECT * FROM test_create_table;
UPDATE test_create_table SET col_2 = 'testSQL_UPDATE' WHERE col_1 = 5;
commit;

-- COMMIT 시에는 반영된 데이터값을 되돌릴 수 없다.
-- DML 작업시 특히 DELETE 작업시 COMMIT 작업은 신중히, 취소시 ROLLBACK 하면 한단계 취소.

-- DELETE FROM 테이블 이름 (WHERE 조건);
DROP TABLE test_create_table;
-- ------------------------------------------------------------------------

CREATE TABLE NewBook (
bookid integer,
bookname varchar(20),
publisher varchar(20),
price integer,
primary key (bookid)
);

ALTER TABLE NewBook MODIFY bookname varchar(20) NOT NULL;
ALTER TABLE NewBook MODIFY publisher varchar(20) UNIQUE;
ALTER TABLE NewBook MODIFY price INTEGER DEFAULT 10000 CHECK (price > 10000);

desc NewBook;

CREATE TABLE NewCustomer (
custid INTEGER PRIMARY KEY,
name VARCHAR(40),
address VARCHAR(40),
phone VARCHAR(30)
);

CREATE TABLE NewOrders (
	orderid integer,
	custid integer NOT NULL,
    bookid integer NOT NULL,
    saleprice integer,
    orderdate date,
    primary key (orderid),
    foreign key (custid) references NewCustomer(custid),
    foreign key (bookid) references NewBook(bookid)
    );

ALTER TABLE NewBook ADD COLUMN isbn VARCHAR(13);
ALTER TABLE NewBook MODIFY COLUMN isbn INTEGER;
ALTER TABLE NewBook DROP COLUMN isbn;
ALTER TABLE NewBook MODIFY COLUMN bookid INTEGER NOT NULL;

DROP TABLE NewBook;
DROP TABLE NewCustomer;
DROP TABLE NewOrders;
show tables;

-- foreign key (관계 해제)  =>  테이블을 기준, 데이터베이스 기준 외래키 확인

SELECT * FROM information_schema.table_constraints WHERE table_name = 'NewOrders';

ALTER TABLE NewOrders DROP FOREIGN KEY neworders_ibfk_1;
ALTER TABLE NewOrders DROP FOREIGN KEY neworders_ibfk_2;

ALTER TABLE NewOrders ADD CONSTRAINT fk_bookid FOREIGN KEY(bookid) REFERENCES NewBook(bookid) ON DELETE CASCADE;
ALTER TABLE NewOrders ADD CONSTRAINT fk_custid FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE;

SELECT * FROM NewCustomer;
INSERT INTO NewCustomer VALUES(1, 'sss', 'korea', '010-000-0000');
INSERT INTO NewCustomer VALUES(1, 'sss', 'korea', '010-000-0000');
UPDATE NewCustomer SET custid = 2 WHERE custid = 1;

DELETE FROM NewCustomer WHERE custid = 2;
commit;

-- NewBook 테이블에 책 한권 저장
DESC NewBook;
INSERT INTO NewBook VALUES(1, '한 눈으로 보는 세계', '민응사', 15000); 
INSERT INTO NewBook VALUES(2, '동아시아사', '민응사2', 10000); 
SELECT * FROM NewBook; 

DESC NewOrders;
-- NewOrders 테이블에 custid 1인 고객이 bookid 1인 책을 주문했다. 해당 데이터를 입력
DELETE FROM NewOrders;
INSERT INTO NewOrders VALUES(null, 1, 1, 10000, NOW());
UPDATE NewOrders SET bookid = 2 WHERE custid = 1;

DELETE FROM NewOrders WHERE custid = 1;
SELECT * FROM NewOrders;
SELECT * FROM NewBook;

-- NewOrders 테이블에 orderid에 auto_increments 속성을 추가
ALTER TABLE NewOrders MODIFY COLUMN orderid INT NOT NULL auto_increment;











































