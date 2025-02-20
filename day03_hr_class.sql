-- -- SQLPratice 03
SELECT * FROM employees;
-- 1.  사원정보(Employees)테이블에서 사원번호(employee_id), 이름(first_name, last_name), 급여(salary), 업무(job_id), 입사일(hire_date), 상사의 사원번호(manager_id)를 출력하시오. 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하세요
SELECT employee_id, concat(first_name, ' ', last_name) AS Name, salary, job_id, hire_date, manager_id
FROM Employees;
-- 2.  사원 정보(Employees) 테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary, 급여에 $100 너스를 추가하여 계산한 연봉은 “Increased Salary”라는 별칭으로 출력하시오
SELECT concat(first_name, ' ', last_name) AS Name, job_id AS Job, salary AS Salary, (salary*12)+100 AS 'Increased Ann_Salary', (salary+100)*12 AS 'Increased Salary'
FROM Employees;
-- 3.  사원 정보(Employees) 테이블에서 모든 사원의 이름(last_name)과 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고, 1 Year Salary라는 별칭을 붙여 출력하시오
SELECT CONCAT(last_name, ': 1 Year Salary = $', salary*12) AS '1 Year Salary'
FROM Employees;
-- 4.  부서별로 담당하는 업무를 한 번씩만 출력하시오
SELECT distinct department_id, job_id
FROM employees;
-- 5.  HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 사원 정보 (Employees) 테이블에서 급여가 $7,000 ~$10,000 범위 이외인 사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오
SELECT concat(first_name, ' ', last_name) AS Name, salary
FROM employees
WHERE salary NOT BETWEEN 7000 AND 10000
ORDER BY salary;
-- 6. 사원의 성(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오. 이때 머리글은 ‘e AND o Name’이라고 출력하시오
SELECT concat(first_name, ' ', last_name) AS 'e AND o Name'
FROM employees
WHERE last_name like '%e%' AND last_name like '%o%';
-- 7. 현재 날짜 타입을 날짜 함수를 통해 확인하고, 1995년 5월 20일부터 1996년 5월 20일 사이에 고용된 사원들의 성과 이름(Name으로 별칭), 사원 번호, 고용 일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오
SELECT NOW() FROM DUAL;		SELECT SYSDATE() FROM DUAL;
SELECT concat(first_name, ' ', last_name) AS Name, employee_id, hire_date
FROM employees
WHERE hire_date BETWEEN str_to_date('1995/05/20','%Y/%m/%d') AND str_to_date('1996/05/20','%Y/%m/%d')
ORDER BY hire_date;
-- 8. HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
SELECT concat(first_name, ' ', last_name) AS Name, salary, job_id, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;
-- 9. 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭) 순으로 출력한다
SELECT employee_id, concat(first_name, ' ', last_name) AS Name, salary, FORMAT(salary*112.3, 0) AS 'Increased Salary'
FROM employees
WHERE department_id = 60;
-- 10. 이름이 ‘s’로 끝나는 각 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 출력시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 EmployeeJOBs.로 표시하시오  예) Sigal Tobias is a PU_CLERK
-- 11. 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당 여부에 따른 연봉을 포함하여 출력하시오. 수당 여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 또한 출력 시 연봉이 높은 순으로 정렬한다 
-- 12. 모든 사원의 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이었는지 출력하시오. 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오

desc employees;