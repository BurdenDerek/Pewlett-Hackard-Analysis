CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

SELECT * FROM departments;

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

SELECT * FROM employees;

CREATE TABLE department_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_Date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no,dept_no)
);

SELECT * FROM department_manager;

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no)
);

SELECT * FROM salaries;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_emp;

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(50) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, from_date)
);

SELECT * FROM titles;

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM department_manager;
SELECT * FROM salaries;
SELECT * FROM titles;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     department_manager.emp_no,
     department_manager.from_date,
     department_manager.to_date
FROM departments
INNER JOIN department_manager
ON departments.dept_no = department_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     department_manager.emp_no,
     department_manager.from_date,
     department_manager.to_date
FROM departments
INNER JOIN department_manager
ON departments.dept_no = department_manager.dept_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
	 FROM departments as d
INNER JOIN department_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT emp_no,
	first_name,
last_name,
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM department_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT * FROM dept_info;
SELECT * FROM emp_by_dept;
SELECT * FROM retirement_info;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_info;
SELECT * FROM current_emp;

-- Sales team retirement info
SELECT emp_no, dept_no
FROM dept_emp 
WHERE dept_emp.dept_no = ('d007');

SELECT emp_no, dept_no
INTO sales_dept
FROM dept_emp
WHERE (dept_no = 'd007');

SELECT * FROM sales_dept;

DROP TABLE sales_retirement;

SELECT 	sd.emp_no, 
		sd.dept_no,
		ri.first_name,
		ri.last_name
INTO sales_retirement
FROM sales_dept AS sd
INNER JOIN retirement_info AS ri
ON(sd.emp_no = ri.emp_no);

SELECT * FROM sales_retirement;

SELECT * 
FROM sales_dept
INNER JOIN retirement_info 
ON sales_dept.emp_no=retirement_info.emp_no;

SELECT emp_no, dept_no
FROM dept_emp 
WHERE dept_emp.dept_no = ('d005');

SELECT emp_no, dept_no
INTO dev_sales_dept
FROM dept_emp
WHERE (dept_no = 'd005')
OR (dept_no = 'd007');

SELECT * FROM dev_sales_dept;
DROP TABLE dev_sales_retirement;

SELECT 	ds.emp_no, 
		ds.dept_no,
		ri.first_name,
		ri.last_name
INTO dev_sales_retirement
FROM dev_sales_dept AS ds
INNER JOIN retirement_info AS ri
ON(ds.emp_no = ri.emp_no);

SELECT * FROM dev_sales_retirement;
DROP TABLE dev_sales_retirement;