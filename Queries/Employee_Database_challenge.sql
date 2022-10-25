--Deliverable 1
SELECT 
e.emp_no,
e.first_name,
e.last_name,
t.titles,
t.from_date, 
t.to_date

INTO retirement_titles
FROM employees as e 
inner join titles as t  
on e.emp_no=t.emp_no
WHERE (e.birth_date between'1952-01-01' and '1955-12-01') 
order by e.emp_no asc;
select * from retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
titles

INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;
select * from unique_titles

select count(titles), titles from unique_titles 
group by titles 
order by count desc;

--Deliverable 2

select distinct on (e.emp_no) 
e.first_name, 
e.last_name, 
e.birth_date, 
de.from_date, 
de.to_date, 
t.titles
into mentorship_eligibility
from (employees as e inner join dept_emp as de on e.emp_no=de.emp_no)
inner join titles as t on e.emp_no=t.emp_no
where (de.to_date = '9999-01-01' and e.birth_date between'1965-01-01' and'1965-12-01' ); 
select * from mentorship_eligibility

--Additional Tables 
--All current titles
SELECT employees.emp_no,
		employees.first_name,
		employees.last_name,
		titles.titles,
		titles.from_date,
		titles.to_date

INTO retirement_titles_all
FROM employees 
	INNER JOIN titles
	ON (employees.emp_no = titles.emp_no)
ORDER BY emp_no ASC; 

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
titles

INTO retirement_titles_current
FROM retirement_titles_all
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;
select count(titles),titles 
into retirement_titles_current_count 
from retirement_titles_current 
group by titles 
order by count desc; 
select * from retirement_titles_current_count 

--Mentorship count 
select count(titles), titles 
into mentorship_count
from mentorship_eligibility
group by titles 
order by count DESC; 
select * from mentorship_count