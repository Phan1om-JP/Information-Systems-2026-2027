-- CREATE DATABASE usth;
-- USE usth;

-- CREATE TABLE employees (
-- emp_no INT NOT NULL,
-- birth_date DATE NOT NULL,
-- first_name VARCHAR(14) NOT NULL,
-- last_name VARCHAR(16) NOT NULL,
-- gender ENUM ('M','F') NOT NULL,
-- hire_date DATE NOT NULL,
-- PRIMARY KEY (emp_no)
-- );
-- CREATE TABLE departments (
-- dept_no CHAR(4) NOT NULL,
-- dept_name VARCHAR(40) NOT NULL,
-- PRIMARY KEY (dept_no),
-- UNIQUE KEY (dept_name)
-- );
-- DESCRIBE employees;
-- DESCRIBE departments;

-- INSERT INTO `employees` VALUES
-- (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26'),
-- (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1985-11-21'),
-- (10003, '1959-12-03', 'Parto', 'Bamford', 'M', '1986-08-28'),
-- (10004, '1954-05-01', 'Chirstian', 'Koblick', 'M', '1986-12-01');

-- INSERT INTO `departments` VALUES
-- ('d001', 'Marketing'),
-- ('d002', 'Finance'),
-- ('d003', 'Human Resources');

-- 1. Find employees with last names is "Bamford"
SELECT * 
FROM employees
WHERE last_name = "Bamford";

-- 2. Find male employees with last name is “Bamford”
SELECT * 
FROM employees
WHERE gender = "M" AND last_name = "Bamford";

-- 3. Find departments with name as “Finance"

SELECT * 
FROM departments
WHERE dept_name = "Finance";

-- 4. Find last_name of last 3 hired employees

SELECT last_name 
FROM employees
ORDER BY hire_date DESC LIMIT 3;

-- 5. Find highest salary paid

USE employees;
SELECT salary
FROM salaries 
ORDER BY salary DESC LIMIT 1;

-- 6. Find lowest salary paid

SELECT salary
FROM salaries
ORDER BY salary 
LIMIT 1;

-- 7. Find number of departments

SELECT COUNT(*)
FROM departments;

-- 8. Find lowest AND highest salaries ever paid (UNION)

(SELECT salary
FROM salaries
ORDER BY salary LIMIT 1)
UNION
(SELECT salary
FROM salaries
ORDER BY salary DESC LIMIT 1);

-- 9. Find employees with last name either ‘Facello’ or ‘Simmel’

(SELECT last_name
FROM employees
WHERE last_name = "Facello")
UNION
(SELECT last_name
FROM employees
WHERE last_name = "Simmel");

-- Labwork3

-- 1. All info of all employees

SELECT * FROM employees;

-- 2. All info of all departments

SELECT * FROM departments;

-- 3. Full names of all employees

SELECT first_name, last_name FROM employees;

-- 4. Names of all departments

SELECT dept_name
FROM departments;

-- 5. Full names of employees working in “Sales” department

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = "Sales";

-- 6. Full names of male employees working in “Finance” department

SELECT CONCAT(e.first_name, ' ', e.last_name) as full_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = "Finance" AND gender = "M";

-- 7. Salaries of female employees working in “Marketing” department

SELECT s.salary 
FROM salaries AS s
JOIN employees AS e ON e.emp_no = s.emp_no
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE gender = "F" AND d.dept_name = "Marketing";


-- 8. Full names of employees who have the same last name as their manager

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN dept_manager AS dm On de.dept_no = dm.dept_no
JOIN employees AS m On dm.emp_no = m.emp_no
WHERE e.last_name = m.last_name AND e.emp_no <> m.emp_no;


-- 9. Full names of managers who have been doing the job at least twice
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, COUNT(*) AS times
FROM employees as e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name
HAVING COUNT(*) >= 2;


-- 10. Full names of employees who was paid more than $100000

SELECT DISTINCT e.emp_no, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.salary > 100000;


-- 11. Names of all departments that have employees paid more than $100000

SELECT DISTINCT d.dept_name
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries as s ON de.emp_no = s.emp_no
WHERE s.salary > 100000;

-- 12. Development (d005) and Research (d008) to Research and Development(d010)
INSERT INTO departments (dept_no, dept_name) VALUES ("d010", "Research and Development");

UPDATE dept_emp
SET dept_no = "d010"
WHERE dept_no IN ("d005", "d008");

UPDATE dept_manager
SET dept_no = "d010"
WHERE dept_no IN ("d005", "d008");

DELETE FROM departments
WHERE dept_no IN ('d005', 'd008');


-- 13. Marketing (d001) and Sales (d007) to Marketing and Sales (d011)

INSERT INTO departments (dept_no, dept_name) VALUES ("d011", "Marketing and Sales");

UPDATE dept_emp
SET dept_no = "d011"
WHERE dept_no IN ("d001", "d007");

UPDATE dept_manager
SET dept_no = "d011"
WHERE dept_no IN ("d001", "d007");

DELETE FROM departments
WHERE dept_no IN ('d001', 'd007');
