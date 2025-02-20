use hr;
show tables;
SELECT * FROM employees;

-- 1
SELECT COUNT(employee_id)-2 AS '총 사원수' FROM employees;
SELECT COUNT(DISTINCT manager_id) "직속 상사" FROM employees;

-- 2
SELECT department_id AS '부서아이디',
	   CONCAT('$', FORMAT(SUM(salary), 0)) AS '급여 합계',
	   CONCAT('$', FORMAT(AVG(salary), 1)) AS '급여 평균',
       CONCAT('$', FORMAT(MAX(salary), 0)) AS '급여 최댓값',
       CONCAT('$', FORMAT(MIN(salary), 0)) AS '급여 최솟값'
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id;

-- 3
SELECT job_id AS '업무', AVG(salary) AS '급여평균'
FROM employees
WHERE job_id NOT LIKE '%CLERK%'
GROUP BY job_id
HAVING AVG(salary) >= 10000
ORDER BY AVG(salary) DESC;
