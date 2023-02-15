-- Homework Exercise

-- Question 1

--Find all the employees who work in the ‘Human Resources’ department.

SELECT *
FROM employees 
WHERE department = 'Human Resources';

-- Question 2

--Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.

SELECT 
first_name, last_name, country
FROM employees 
WHERE department = 'Legal';

--Question 3

-- Count the number of employees based in Portugal.

SELECT 
count (*) AS Portugese_employees
FROM employees
WHERE country = 'Portugal';

-- Question 4

-- Count the number of employees based in either Portugal or Spain.

SELECT 
count(*) AS Spanish_or_Portugese_employees
FROM employees 
WHERE country IN ('Spain', 'Portugal');

-- Question 5

-- Count the number of pay_details records lacking a local_account_no

SELECT *
FROM pay_details 
WHERE local_account_no IS NULL; 

-- Question 6

-- Are there any pay_details records lacking both a local_account_no and iban number?

SELECT *
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL; 

-- Question 7

-- Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).

SELECT 
first_name, last_name 
FROM employees 
ORDER BY last_name ASC NULLS LAST;

-- Question 8

-- Get a table of employees first_name, last_name and country, ordered alphabetically first by country 
--and then by last_name (put any NULLs last).

SELECT 
first_name, last_name, country
FROM employees 
ORDER BY 
country NULLS LAST,
last_name NULLS LAST;

-- Question 9 

-- Find the details of the top ten highest paid employees in the corporation.

SELECT *
FROM employees 
ORDER BY 
salary DESC NULLS LAST 
LIMIT 10;

-- Question 10 

-- Find the first_name, last_name and salary of the lowest paid employee in Hungary.


SELECT 
first_name, last_name, salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY
salary
LIMIT 1;

-- Question 11 

-- How many employees have a first_name beginning with ‘F’?

SELECT 
count(*) AS first_name_f
FROM employees 
WHERE first_name LIKE 'F%';

-- Question 12

-- Find all the details of any employees with a ‘yahoo’ email address?

SELECT *
FROM employees 
WHERE email LIKE '%yahoo%';


-- Question 13

-- Count the number of pension enrolled employees not based in either France or Germany.

-- Attempt 1, wrong
SELECT 
count(*) AS pension_enrolled
FROM employees 
WHERE country != ('France', 'Germany')
AND pension_enrol = TRUE;

-- Attempt 2, wrong 

SELECT *
FROM employees 
WHERE country NOT IN ('Germany', 'France')
AND pension_enrol = TRUE; 

Missed ou

-- Attempt 3 - From answers

SELECT 
  COUNT(id) AS num_pension_not_France_Germany
FROM employees
WHERE pension_enrol IS TRUE AND country NOT IN ('France', 'Germany')


-- Question 14

-- What is the maximum salary among those employees in the ‘Engineering’ department
-- who work 1.0 full-time equivalent hours (fte_hours)?

SELECT *
FROM employees 
WHERE department = 'Engineering'
AND fte_hours = 1
ORDER BY salary DESC 
LIMIT 1;

-- Question 15

-- Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary,
-- and a new column effective_yearly_salary which should contain fte_hours multiplied by salary.

-- Attempt 1 - Wrong
SELECT 
first_name, last_name, fte_hours, salary
concat (salary * fte_hours) AS effective_yearly_salary
FROM employees;

-- Attempt 2 - From answers

SELECT 
  first_name,
  last_name,
  fte_hours,
  salary,
  fte_hours * salary AS effective_yearly_salary
FROM employees 

-- Question 16

--The corporation wants to make name badges for a forthcoming conference. 
--Return a column badge_label showing employees’ first_name and last_name 
-- joined together with their department in the following style: ‘Bob Smith - Legal’.
-- Restrict output to only those employees with stored first_name, last_name and department.

-- Attempt 1 - Got right, missed out a comma

SELECT 
first_name, last_name, department,
concat (first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees
WHERE (first_name IS NOT NULL) AND (last_name IS NOT NULL) AND (department IS NOT NULL)

-- Attempt 2 - From answers

SELECT
  first_name,
  last_name,
  department,
  CONCAT(first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees

--Question 17

-- From answers

SELECT
  first_name,
  last_name,
  department,
  start_date,
  CONCAT(
    first_name, ' ', last_name, ' - ', department, 
    ' (joined ', EXTRACT(YEAR FROM start_date), ')'
  ) AS badge_label
FROM employees
WHERE 
  first_name IS NOT NULL AND 
  last_name IS NOT NULL AND 
  department IS NOT NULL AND
  start_date IS NOT NULL
  
  -- Question 18 
  
  -- From answers 
  
  SELECT 
  first_name, 
  last_name, 
  CASE 
    WHEN salary < 40000 THEN 'low'
    WHEN salary IS NULL THEN NULL
    ELSE 'high' 
  END AS salary_class
FROM employees
