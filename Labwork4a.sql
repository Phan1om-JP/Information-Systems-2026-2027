USE employees;
-- What is the average salary of each employee?
SELECT emp_no, AVG(salary) AS avg_salary
FROM salaries
GROUP BY emp_no;
-- How much was each employee paid in total?
SELECT emp_no, SUM(salary) AS total
FROM salaries
GROUP BY emp_no;
-- Minimum, maximum and total salaries of each department?
SELECT emp_no, MIN(salary) AS minimum, MAX(salary) AS maximum, SUM(salary) AS total
FROM salaries
GROUP BY emp_no;
-- Which departments have paid more than 20 billion dollars for their employees?
SELECT d.dept_name, SUM(s.salary) AS total_paid
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
GROUP BY d.dept_no, d.dept_name
HAVING total_paid > 0000000000
ORDER BY total_paid DESC;
-- Total salaries of male employees in each department?
SELECT d.dept_name, SUM(s.salary) AS total_paid
FROM departments as d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE e.gender = "M"
GROUP BY d.dept_no, d.dept_name;

-- Total salaries of department managers for each department, from highest to lowest?

SELECT d.dept_name, SUM(s.salary) AS total_paid 
FROM departments as d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN salaries AS s ON dm.emp_no = s.emp_no
GROUP BY d.dept_no, d.dept_name
ORDER BY total_paid DESC;