USE employees;

-- Who have the same name as the managers of the “Finance” department?
CREATE VIEW finance_manager_namesakes AS
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
WHERE (e.first_name, e.last_name) IN (
SELECT m.first_name, m.last_name
FROM employees AS m
JOIN dept_manager AS dm ON m.emp_no = dm.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE d.dept_name = 'Finance'
);

-- Who in the “Production” department were hired after the promotion of the last manager in that department?

CREATE VIEW production_hired_after_last_manager AS
SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Production' AND e.hire_date > (
SELECT MAX(dm.from_date)
FROM dept_manager AS dm
JOIN departments AS pd ON dm.dept_no = pd.dept_no
WHERE pd.dept_name = 'Production'
);

-- Find the average salary of each department, from highest to lowest.

CREATE VIEW dept_avg_salary AS
SELECT d.dept_name, AVG(s.salary) AS ave_dept_salary
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
GROUP BY d.dept_no, d.dept_name;

-- Find the average salary for each type of Engineer, from highest to lowest.

CREATE VIEW engineer_avg_salary AS
SELECT t.title, AVG(s.salary) AS ave_salary
FROM salaries AS s
JOIN titles AS t ON s.emp_no = t.emp_no
WHERE t.title LIKE '%Engineer%'
GROUP BY t.title;


SELECT * FROM dept_avg_salary ORDER BY ave_dept_salary DESC;
SELECT * FROM engineer_avg_salary ORDER BY ave_salary DESC;
SELECT COUNT(*) FROM finance_manager_namesakes;
