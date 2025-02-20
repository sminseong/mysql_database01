use hr;
show tables;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM Job_Grades;
-- 1. 연봉이 12000 이상되는 직원들의 LAST_NAME 및 연봉을 조회한다.
SELECT last_name, salary
FROM employees
WHERE salary >= 12000;
 
-- 2. 사원번호가 176 인 사람의 LAST_NAME 과 부서 번호를 조회한다.
SELECT last_name, department_id
FROM employees
WHERE employee_id = 176;
 
-- 3. 연봉이 5000 에서 12000의 범위 이외인 사람들의 LAST_NAME 및 연봉을 조회힌다.
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;
 
-- 4. 1998/02/20 일부터 1998/05/01 사이에 고용된 사원들의 LAST_NAME 사번, 고용일자를 조회한다.  단, 고용일자 순으로 정렬한다.
SELECT last_name, employee_id, hire_date
FROM employees
WHERE hire_date BETWEEN '1998-02-20' AND '1998-05-01'
ORDER BY hire_date;
  
-- 5. 20 번 및 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME 및 부서 번호를 알파벳순으로 조회한다.
SELECT last_name, employee_id
FROM employees
WHERE department_id in (20, 50)
ORDER BY last_name;
 
-- 6. 20 번 및 50 번 부서에 근무하며, 연봉이 5000 ~ 12,000 사이인 사원들의 LAST_NAME 및 연봉을 조회한다.
SELECT last_name, salary
FROM employees
WHERE department_id in (20, 50) AND salary BETWEEN 5000 AND 12000;
 
-- 7. 1994년도에 고용된 모든 사람들의 LAST_NAME 및 고용일을 조회한다.
SELECT last_name, hire_date
FROM employees
WHERE YEAR(hire_date)=1994;
 
-- 8. 매니저가 없는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;
 
-- 9. 매니저가 있는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NOT NULL;
 
-- 10. 커미션을 버는 모든 사원들의 LAST_ANME, 연봉 및 커미션을 조회한다.   연봉 역순, 커미션 역순차로 정렬한다.
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;
 
-- 11. LAST_NAME 의 네번째 글자가 a 인 사원들의 LAST_NAME 을 조회한다.
SELECT last_name
FROM employees
WHERE last_name LIKE '___a%';
 
-- 12. LAST_NAME 에 a 및(OR) e 글자가 있는 사원들의 LAST_NAME 을 조회한다.
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' OR last_name LIKE '%e%';
 
-- 13. 연봉이 2,500, 3,500, 7000 이 아니며 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
SELECT CONCAT(first_name, ' ', last_name) NAME, salary, job_id
FROM employees
WHERE salary NOT IN (2500, 3500, 7000) AND job_id IN ('SA_REP', 'ST_CLERK');
    
-- 14. 모든 사원들의 LAST_NAME, 부서 이름 및 부서 번호을 조회한다.
SELECT e.last_name, d.department_name, d.department_id
FROM employees e
JOIN departments d ON (e.department_id = d.department_id);
 
-- 15. 부서번호 30 내의 모든 직업들을 조회한다. 90 부서 또한 포함한다.
SELECT job_id
FROM employees
WHERE department_id = 90 OR department_id <= 30;
 
-- 16. 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
JOIN locations l ON (l.location_id = d.location_id)
WHERE e.commission_pct IS NOT NULL;

-- 17.  hr 스키마에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후 Oxford에 근무하는 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 도시명을 출력하시오. 이때 첫 번째 열은 회사명인 ‘신세계’라는 상수 값이 출력되도록 하시오
SELECT '신세계' 회사명, CONCAT(e.first_name, ' ', e.last_name) NAME, e.job_id, d.department_name, l.city
FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
JOIN locations l ON (l.location_id = d.location_id)
WHERE l.city = 'Oxford';

-- 18.  hr 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 사원 수가 다섯명 이상인 부서의 부서명과 사원 수를 출력하시오. 이때 사원 수가 많은 순으로 정렬하시오
SELECT d.department_name, COUNT(e.employee_id) '사원 수'
FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
GROUP BY e.department_id
HAVING COUNT(e.employee_id) >= 5
ORDER BY COUNT(e.employee_id) DESC;

-- 19.  hr 스키마의 Job_Grades 테이블을 사용하여 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 급여 등급은 Job_Grades 테이블에 표시된다. 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 입사일, 급여, 급여 등급을 출력하시오
SELECT CONCAT(e.first_name, ' ', e.last_name) NAME, e.job_id, d.department_name, e.hire_date, e.salary, (SELECT g.grade_level FROM Job_Grades g WHERE e.salary BETWEEN g.lowest_sal AND g.highest_sal) GRADE
FROM employees e
JOIN departments d ON (e.department_id = d.department_id);

-- 20. 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.예) 홍길동은 허균에게 보고한다 → Neena Kochhar report to STEVEN KING 어떤 사원이 어떤 사원에게 보고하는지 위 예를 참고하여 출력하시오. 단, 보고할 상사가 없는 사원이 있다면 그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오
SELECT IF(e2.employee_id IS NULL, CONCAT(e1.first_name, ' ', e1.last_name,  ' NO report'), 
          CONCAT(e1.first_name, ' ', e1.last_name, ' report to ', UPPER(e2.first_name), ' ', UPPER(e2.last_name))) 보고서
FROM employees e1
LEFT JOIN employees e2 ON (e1.manager_id = e2.employee_id);