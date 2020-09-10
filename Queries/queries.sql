-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY  (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM departments;

SELECT * FROM departments;

SELECT * FROM dept_manager;

-- querying dates 7.3.1
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31' ;

-- querying 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31' ;

-- querying 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31' ;

-- querying 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31' ;

--querying 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31' ;

--querying 1952-55 w/ hire 85-88 Retirement eligibilty 
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- COUNT FUNCTION - could use either first_name or last_name b/c column length is the same, output will be too. 
SELECT COUNT (first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table- 7.3.1 export | SELECT INTO
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Use SELECT to see the new table we added above
SELECT * FROM retirement_info ;


-- 7.3.2 JOIN DA TABLE

-- First, drop the old retirement_info table
DROP TABLE retirement_info ;

-- update code to create new retirement_info table w/ emp_no column
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- check the table
SELECT * FROM retirement_info ;

-- 7.3.3 practicing joins - inner join for Departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no ;
-- SELECT statement selects only the columns we want to view from each table
-- what's going on above. table after FROM (departments) is table 1 (left table) 
-- table after INNER JOIN is table 2 (right table) 
-- ON departments.dept_no = dept_manager.dept_no tells postgres where to look for matches

-- 7.3.3 USE left join to capture retirement-info table
-- what we need - employee number, employee name (first and last), IF person still employed
-- need to join retirement_info w/ dept_emp

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--show the current_emp table
SELECT * FROM current_emp ;

-- count first_name from current_emp table
SELECT COUNT (first_name) FROM current_emp ;

-- 7.3.4 - GROUP BY and ORDER BY
-- in postgres GROUPY BY is used when we want to group rows of identical data together in a table.
-- going to use GROUP BY to seperate employees into their departments.

-- JOIN current_emp and dept_emp tables.
SELECT COUNT (ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no ;
-- things to note: the COUNT function was used on the employee numbers // assigned aliases to both tables.
-- GROUP BY was added to the select statement
-- added COUNT( ) to the SELECT statement b/c we wanted a total number of employees.
-- didn't use SUM ( ) b/c that would add the employee numbers together, which would be worthless here.
-- used a LEFT JOIN b/c we wanted all employee numbers from table 1 (current_emp) to be included in the returned data.
-- GROUP BY is the magic clause that gives us the number of employees retiring from each department.

-- there is no order to this table- if you run it again, the order will change.  gotta use ORDER BY to fix this.

-- ORDER BY
-- Employee count by department number
SELECT COUNT (ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no ;
-- the ORDER BY de.dept_no makes the output ordered

-- SKILL DRILL - update codeblock to create a new table, then export as a CSV.
-- creating new table- current_emp_dept 
SELECT COUNT (ce.emp_no), de.dept_no
INTO current_emp_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no ; 

-- 7.3.5 ###### 7.3.5 ######7.3.5 ######7.3.5 ######7.3.5 ######7.3.5 ######7.3.5 ######7.3.5 ######
-- 										Lists we need to make
-- 1.) Employee Information: A list of employees containing their unique employee number, last name, first name, gender, and salary

-- 2.) Management: A list of managers for each department, including the department number, name, 
--		and the manager's employee number, last name, first name, and the starting and ending employment dates

-- 3.) Department Retirees: An updated current_emp list that includes everything it currently has, but also the employee's departments


-- LIST 1 : Employee Information
SELECT * FROM salaries;
-- dates are all over the place, use ORDER BY column_name DESC ; to order them
SELECT * FROM salaries
ORDER BY to_date DESC ;
-- of course, this isn't helpful b/c the to_date has to do with each employees salary...not last date of employment
-- take old code from when we made the retirement_info table and repurpose | new table is emp_info
-- making emp_info table
SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- JOINING with salaries table to get salary and to_date | JOINED 3 tables - employees, salaries, and dept_emp


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
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
	 
-- LIST 2 #### LIST 2 #### LIST 2 #### LIST 2 #### LIST 2 #### LIST 2 #### LIST 2 #### LIST 2 #### LIST 2 #### 
-- MANAGEMENT ### MANAGEMENT 
-- Need the following columns: managers employee number, last name, first name, department number, starting/ending employment dates

-- List of managers per department 
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no) ;
		
-- LIST 3 DEPARTMENT RETIREES
-- Final list only needs to have the *departments* added to the current_emp table. 
-- Use INNER JOINs on the *current_emp*, *departments*, and *dept_emp* to include the list of columns we need-
-- THOSE COLUMNS ARE: 1). emp_no 2.) first_name 3.) last_name 4.) dept_name

SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no) ;

-- 7.3.6 CHALLENGE LIST | only SALES TEAM (d007) relevant. EMPLOYEE NUMBERS, FIRST_NAME, LAST_NAME, DEPT_NAME

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	di.dept_name
INTO retirement_sales_dept
FROM retirement_info as ri
INNER JOIN dept_info as di
ON (ri.emp_no = di.emp_no)
WHERE (di.dept_name = 'Sales') ;

-- 7.3.6 CHALLENGE LIST 2 | same as above, but we want DEPT_NAME info for sales AND development teams.

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	di.dept_name
INTO retirement_sales_development
FROM retirement_info AS ri
INNER JOIN dept_info AS di
ON (ri.emp_no = di.emp_no)
WHERE di.dept_name IN ('Sales', 'Development') ;