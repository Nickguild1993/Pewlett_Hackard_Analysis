queries for challenge 

-- CHALLENGE MODULE 7 DELIVERABLE 1 --------------------------------------------------------------------
-- CHALLENGE MODULE 7 DELIVERABLE 1 --------------------------------------------------------------------

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-1-1' AND '1955-12-31'
ORDER BY e.emp_no
;

-- importing starter code to get rid of duplicate names in retirement_titles 
-- 8. -- Use Dictinct with Orderby to remove duplicate rows
-- SELECT DISTINCT ON (______) _____,
-- ______,
-- ______,
-- ______

-- INTO nameyourtable
-- FROM _______
-- ORDER BY _____, _____ DESC;

-- Distinct on

SELECT DISTINCT ON (emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC
;
-- table created, exported as unique_titles.csv into data folder of HP module

--15. write a query to retrieve the number of employees (who're about to retire) by their most recent job title

SELECT COUNT (title), title
INTO working_titles
FROM unique_titles
GROUP BY title ;
-- ORDER BY count DESC


-- need to create a table that has count of employees in each dept.  -- ORDER BY count DESC!!!!
SELECT * INTO retiring_titles
FROM working_titles
ORDER BY count DESC
;

-- DELIVERABLE 1 complete -----------------------------------------------------------------

-- DELIVERABLE 2 BEGINS ----------- mentorship-eligibility table

--1. ) retrieve emp_no, first_name, last_name, birth_date FROM employees table. get from_date, to_date from Department Employee table
-- Get title from titles table

SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-1-1' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no
;
