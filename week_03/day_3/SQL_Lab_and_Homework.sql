
-- Day 3 SQL Lab and Homework

-- Question 1

SELECT count(*)
FROM employees 
WHERE grade IS NULL AND 
salary IS NULL 

-- Question 2

SELECT 
concat(first_name, ' ', last_name) AS full_name,
department
FROM employees 
ORDER BY department, last_name

-- Question 3

SELECT 
first_name,
last_name,
salary
FROM employees 
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLS LAST 
LIMIT 10

-- Question 4

SELECT count(*) AS joined_2003, department
FROM employees 
WHERE (start_date BETWEEN '2003-01-01' AND '2003-12-31')
GROUP BY department

-- Question 5

SELECT department,
fte_hours,
count(fte_hours) AS hours_worked
FROM employees 
GROUP BY department, fte_hours
ORDER BY department, fte_hours;

-- Question 6

SELECT count(pension_enrol),
pension_enrol
FROM employees 
GROUP BY pension_enrol 

-- Question 7

SELECT 
first_name,
last_name, 
department,
salary
FROM employees 
WHERE pension_enrol = FALSE AND department = 'Accounting'
ORDER BY salary DESC NULLS LAST 
LIMIT 1

-- Question 8

SELECT 
country,
count(country) AS number_of_employees,
avg(salary) AS average_salary
FROM employees 
GROUP BY country 
HAVING count(*) > 30
ORDER BY average_salary DESC

-- Question 9 

SELECT 
first_name,
last_name,
fte_hours,
salary,
fte_hours * salary AS effective_yearly_salary
FROM employees 
WHERE fte_hours * salary > 30000

-- Question 10

SELECT 
e.*, t.name
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
WHERE t.name IN ('Data Team 1', 'Data Team 2');

-- Question 11 

-- Find the first name and last name of all employees who lack a local_tax_code.

SELECT 
e.*, p.*
FROM employees AS e INNER JOIN pay_details AS p 
ON e.pay_detail_id = p.id
WHERE local_tax_code IS NULL 

-- Question 12

SELECT 
e.*, t.*,
(48 * 35 * CAST(charge_cost AS NUMERIC) - salary) * fte_hours AS expected_profit
FROM employees AS e LEFT JOIN teams AS t 
ON e.team_id = t.id

-- Question 13

-- Find the first_name, last_name and salary of the lowest paid employee in Japan 
--who works the least common full-time equivalent hours across the corporation.”

SELECT 
    fte_hours
FROM employees 
GROUP BY fte_hours
ORDER BY count(*)
LIMIT 1

SELECT 
first_name,
last_name,
salary,
fte_hours 
FROM employees 
WHERE country = 'Japan'
AND fte_hours = (SELECT 
    fte_hours
FROM employees 
GROUP BY fte_hours
ORDER BY count(*)
LIMIT 1)
ORDER BY salary 
LIMIT 1

-- Question 14.
-- Obtain a table showing any departments in which there are 
-- two or more employees lacking a stored first name. 
-- Order the table in descending order of the number of employees lacking a first name,
-- and then in alphabetical order by department.

SELECT count(department) AS employees_with_no_name, department
FROM employees 
WHERE first_name IS NULL 
GROUP BY department
HAVING count(department) >= 2 
ORDER BY employees_with_no_name DESC, department

-- Question 15

-- Return a table of those employee first_names shared by more than one employee, 
-- together with a count of the number of times each first_name occurs. 
-- Omit employees without a stored first_name from the table. 
-- Order the table descending by count, and then alphabetically by first_name.

SELECT first_name, count(first_name) AS same_first_name
FROM employees
WHERE first_name IS NOT NULL 
GROUP BY first_name 
HAVING count (first_name) > 1
ORDER BY same_first_name DESC, first_name ASC

-- Question 16

-- Find the proportion of employees in each department who are grade 1. 

SELECT department, grade, count(department) AS in_grade
FROM employees 
WHERE grade = 1
GROUP BY department;

-- Extension

-- Question 1
 
--Get a list of the id, first_name, last_name, department, salary and fte_hours 
-- of employees in the largest department. 
-- Add two extra columns showing the ratio of each employee’s salary to that department’s
-- average salary, and each employee’s fte_hours to that department’s average fte_hours.

SELECT id, first_name, last_name, department, salary, fte_hours
FROM employees
GROUP BY department
