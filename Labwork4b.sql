-- Who have the same name as the managers of the “Finance” department?
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
WHERE (e.first_name, e.last_name) IN (
SELECT m.first_name, m.last_name
FROM employees AS m
JOIN dept_manager as dm ON m.emp_no = dm.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE d.dept_name = "Finance" 
);
-- Who in the “Production” department were hired after the promotion of the last manager in that department?

SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) as full_name
FROM employees AS e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = "Production" AND (e.hire_date) > (
SELECT MAX(dm.from_date)
FROM dept_manager AS dm
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE d.dept_name = "Production"
);

-- Find the average salary of each department, from highest to lowest.
SELECT d.dept_name, AVG(s.salary) AS ave_dept_salary
FROM salaries AS s
JOIN dept_emp AS de ON s.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY d.dept_no, d.dept_name
ORDER BY ave_dept_salary DESC;

-- Find the average salary for each type of Engineer, from highest to lowest.

SELECT DISTINCT t.title, AVG(s.salary) AS ave_salary
FROM salaries as s
JOIN titles as t ON s.emp_no = t.emp_no
WHERE t.title LIKE "%Engineer%"
GROUP BY t.title
ORDER BY ave_salary DESC;



