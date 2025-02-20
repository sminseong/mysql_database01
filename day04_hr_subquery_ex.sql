SELECT * FROM employees;
SELECT * FROM locations;
SELECT * FROM departments;
-- HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. Tucker 사원보다 급여 를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
SELECT CONCAT(first_name, ' ', last_name) NAME, job_id, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Tucker');

-- 사원의 급여 정보 중 업무별 최소 급여를 받는 사원의 성과 이름(Name으로 별칭), 업무,급여, 입사일을 출력하시오
SELECT CONCAT(e1.first_name, ' ', e1.last_name) NAME, e1.job_id, e1.salary, e1.hire_date
FROM employees e1
WHERE e1.salary = (SELECT MIN(e2.salary) FROM employees e2 WHERE e2.job_id = e1.job_id);

-- 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 성과 이름(Name으로 별칭), 급여,부서번호, 업무를 출력하시오
SELECT CONCAT(e1.first_name, ' ', e1.last_name) NAME, e1.salary, e1.department_id, e1.job_id
FROM employees e1
WHERE e1.salary > (SELECT AVG(e2.salary) FROM employees e2 WHERE e2.department_id = e1.department_id);

-- 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 ‘O’로 시작하는 지역에 살고 있는 사원의 사번, 성과 이름(Name으로 별칭), 업무, 입사일을 출력하시오
SELECT employee_id, CONCAT(first_name, ' ', last_name) NAME, job_id, hire_date
FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM locations WHERE city LIKE 'O%'));

-- 시애틀에 사는 사람 중 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
SELECT e.last_name
       , (SELECT d.department_name FROM departments d WHERE d.department_id = e.department_id) '부서명'
       , (SELECT d.location_id FROM departments d WHERE d.department_id = e.department_id) '지역 ID'
       , (SELECT l.city FROM locations l WHERE l.location_id = (SELECT d.location_id FROM departments d WHERE d.department_id = e.department_id)) '도시명'
FROM employees e
WHERE e.department_id in (SELECT d.department_id FROM departments d WHERE d.location_id = (SELECT l.location_id FROM locations l WHERE l.city = 'Seattle')) 
      AND e.commission_pct IS NULL;

-- LAST_NAME 이 DAVIES 인 사람보다 후에 고용된 사원들의 LAST_NAME 및 HIRE_DATE 을 조회한다.
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'DAVIES');

-- 매니저로 근무하는 사원들의 총 수를 조회한다.
SELECT COUNT(DISTINCT e1.employee_id) AS 매니저수
FROM employees e1
WHERE e1.employee_id IN (SELECT e1.employee_id FROM employees e2 WHERE e2.manager_id = e1.employee_id);

-- LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 조회한다.
SELECT employee_id, hire_date
FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Zlotkey');