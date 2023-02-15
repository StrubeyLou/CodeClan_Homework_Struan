-- Homework and Lab 


-- Question 1

-- (a). Find the first name, last name and team name of employees who are members of teams. 

SELECT 
e.first_name, e.last_name, t.name 
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id

-- b). Find the first name, last name and team name of employees who are members of teams and 
-- are enrolled in the pension scheme.

SELECT 
e.FIRST_name, e.last_name, t.name
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id 
WHERE pension_enrol = TRUE 

-- (c). Find the first name, last name and team name of employees 
--who are members of teams, where their team has a charge cost greater than 80.

SELECT 
e.FIRST_name, e.last_name, t.name
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id 
WHERE CAST (t.charge_cost AS NUMERIC) > 80

-- Question 2

-- (a). Get a table of all employees details, together with their local_account_no and local_sort_code, 
-- if they have them. 

SELECT 
e.*, p.local_account_no, p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p
ON e.id = p.id;

-- b) Amend your query above to also return the name of the team that each employee belongs to. 

SELECT 
e.*, p.local_account_no, p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p
ON e.id = p.id
LEFT JOIN teams AS t 
ON t.id = e.id;

-- Question 3
-- (a). Make a table, which has each employee id along with the team that employee belongs to.

SELECT 
e.first_name, e.last_name, e.id, t.name 
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id

-- (b). Breakdown the number of employees in each of the teams. 

SELECT 
t.name, count (t.name)
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id
GROUP BY t.name

-- (c). Order the table above by so that the teams with the least employees come first. 

SELECT 
t.name, count (t.name)
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id
GROUP BY t.name
ORDER BY count ASC 

-- Question 4
-- (a). Create a table with the team id, team name 
-- and the count of the number of employees in each team.

SELECT 
t.name, t.id, count (e.id) AS n_employees
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t."name", t.id  

-- (b) The total_day_charge of a team is defined as the charge_cost 
-- of the team multiplied by the number of employees in the team. 
-- Calculate the total_day_charge for each team. 

SELECT 
t.name, t.id, count (e.id) AS n_employees, n_employees * charge_cost AS total_day_charge
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t."name", t.id 

-- (c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000? 

-- Question 5

--How many of the employees serve on one or more committees?

SELECT DISTINCT count(employee_id) AS committee_count
FROM employees_committees;
