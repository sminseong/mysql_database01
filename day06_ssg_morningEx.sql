use ssgdb;

CREATE TABLE 극장 (
	극장번호 int PRIMARY KEY,
    극장이름 varchar(10) NOT NULL,
    위치 varchar(10) NOT NULL
);

CREATE TABLE 상영관 (
	극장번호 int,
    상영관번호 int CHECK(상영관번호 between 1 AND 10),
    영화제목 varchar(20),
    가격 int CHECK(가격 <= 20000),
    좌석수 int,
    PRIMARY KEY(극장번호, 상영관번호),
    FOREIGN KEY(극장번호) REFERENCES 극장(극장번호)
);

CREATE TABLE 예약 (
	극장번호 int,
    상영관번호 int,
    고객번호 int,
    좌석번호 int UNIQUE,
    날짜 date,
    PRIMARY KEY(극장번호, 상영관번호, 고객번호),
    FOREIGN KEY(극장번호, 상영관번호) REFERENCES 상영관(극장번호, 상영관번호),
    FOREIGN KEY(고객번호) REFERENCES 고객(고객번호)
);

CREATE TABLE 고객 (
	고객번호 int PRIMARY KEY,
    이름 varchar(10),
    주소 varchar(10)
);

INSERT INTO 극장 VALUES
	(1, '롯데', '잠실'),
    (2, '메가', '강남'),
    (3, '대한', '잠실');
    
INSERT INTO 상영관 VALUES
	(1, 1, '어려운 영화', 15000, 48),
    (3, 1, '멋진 영화', 7500, 120),
    (3, 2, '재밌는 영화', 8000, 110);
    
INSERT INTO 고객 VALUES
	(3, '홍길동', '강남'),
    (4, '김철수', '잠실'),
    (9, '박영희', '강남');
    
INSERT INTO 예약 VALUES
	(3, 2, 3, 15, '2024-09-01'),
	(3, 1, 4, 16, '2024-09-01'),
	(1, 1, 9, 48, '2024-09-01');
    
-- (1) 단순 질의
SELECT 극장이름, 위치 FROM 극장;
SELECT * FROM 극장 WHERE 위치 = '잠실';
SELECT 이름 FROM 고객 WHERE 주소 = '잠실' ORDER BY 이름;
SELECT 극장번호, 상영관번호, 영화제목 FROM 상영관 WHERE 가격 <= 8000;
SELECT * FROM 고객 WHERE 주소 in ('강남', '잠실');

-- (2) 집계 질의
SELECT COUNT(극장번호) FROM 극장;
SELECT AVG(가격) FROM 상영관;
SELECT COUNT(고객번호) FROM 예약 WHERE 날짜 = '2024-09-01';

-- (3) 부속질의와 조인
SELECT 영화제목 FROM 상영관 WHERE 극장번호 = (SELECT 극장번호 FROM 극장 WHERE 극장이름 = '대한');

SELECT 이름 
FROM 고객 a
JOIN 예약 b ON (a.고객번호 = b.고객번호)
JOIN 극장 c ON (b.극장번호 = c.극장번호)
WHERE c.극장이름 = '대한';

SELECT SUM(가격) FROM 상영관 WHERE 극장번호 = (SELECT 극장번호 FROM 극장 WHERE 극장이름 = '대한');

-- (4) 그룹 질의
SELECT 극장.극장이름, COUNT(상영관.상영관번호) '상영관 수' FROM 상영관 JOIN 극장 ON(상영관.극장번호=극장.극장번호) GROUP BY 극장.극장번호;
SELECT * FROM 상영관 WHERE 극장번호 in(SELECT 극장번호 FROM 극장 WHERE 위치 = '잠실');
SELECT 극장번호, COUNT(고객번호) FROM 예약 WHERE 날짜 = '2024-09-01' GROUP BY 극장번호;

SELECT b.영화제목, COUNT(a.고객번호) AS 관객수
FROM 예약 a
JOIN 상영관 b ON(a.극장번호 = b.극장번호) AND (a.상영관번호 = b.상영관번호)
WHERE a.날짜 = '2024-09-01'
GROUP BY b.영화제목
ORDER BY COUNT(a.고객번호) DESC
LIMIT 1;

-- (5) DML
INSERT INTO 고객 VALUES (5, '서민성', '잠실');
INSERT INTO 예약 VALUES (3, 2, 5, 10, '2024-09-01');

UPDATE 상영관 SET 가격 = 가격 * 1.1;
SELECT * FROM 상영관;