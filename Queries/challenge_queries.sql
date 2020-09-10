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
