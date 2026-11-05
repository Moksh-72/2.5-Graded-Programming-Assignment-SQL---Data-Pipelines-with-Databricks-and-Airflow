-- Exercise 2: SQL Joins & Aggregations
-- Database: Sample SQLite database
-- Tables: employees, departments

-- Part A: JOIN Exercises

-- Exercise 1: Employees and Department Budgets
-- Display each employee's name, department, salary, and department budget.
SELECT
    e.name AS employee_name,
    d.name AS department_name,
    e.salary,
    d.budget
FROM employees AS e
INNER JOIN departments AS d
    ON e.department = d.name;


-- Exercise 2: Employees and Their Managers
-- Display each employee and their manager, including employees without a listed manager.
SELECT
    e.name AS employee_name,
    m.name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.id;


-- Part B: Aggregation Exercises

-- Exercise 3: Employee Count by Department
-- Count employees in each department and sort from highest to lowest.
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;


-- Exercise 4: Average Salary by Department
-- Calculate each department's average salary, rounded to two decimal places.
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;


-- Exercise 5: Salary Summary by Department
-- Show minimum salary, maximum salary, total salary, and employee count.
SELECT
    department,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    SUM(salary) AS total_salary,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- Exercise 6: Departments with More Than Two Employees
-- Keep only departments with more than two employees.
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 2
ORDER BY employee_count DESC;


-- Exercise 7: Department Budget and Salary Comparison
-- Compare each department's budget with its total employee salary.
-- COALESCE returns 0 for departments with no matching employees.
SELECT
    d.name AS department_name,
    d.budget,
    COALESCE(SUM(e.salary), 0) AS total_salary,
    d.budget - COALESCE(SUM(e.salary), 0) AS budget_remaining
FROM departments AS d
LEFT JOIN employees AS e
    ON d.name = e.department
GROUP BY
    d.name,
    d.budget
ORDER BY budget_remaining DESC;
