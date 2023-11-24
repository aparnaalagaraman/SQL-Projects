--Problem 3:

--Select the names and job start dates of all employees who work for the department number 5.
SELECT e.f_name,e.l_name,jh.start_date
FROM employees e 
INNER JOIN job_history jh
ON e.emp_id = jh.empl_id
WHERE dep_id = 5;

--Problem 2:
--Select the names, job start dates, and job titles of all employees who work for the department number 5.
SELECT e.f_name,e.l_name,jh.start_date,j.job_title
FROM employees e 
INNER JOIN job_history jh
ON e.emp_id = jh.empl_id
INNER JOIN jobs j
ON e.job_id = j.job_ident
WHERE dep_id = 5;

--Problem 3:
--Perform a Left Outer Join on the EMPLOYEES and DEPARTMENT tables and select employee id, last name, department id and department name for all employees.
SELECT e.emp_id,e.l_name,d.dept_id_dep,d.dep_name
FROM employees e 
LEFT JOIN departments d 
ON e.dep_id = d.dept_id_dep;


--Problem 4:
--Re-write the previous query but limit the result set to include only the rows for employees born before 1980.
SELECT e.emp_id,e.l_name,e.b_date,d.dept_id_dep,d.dep_name
FROM employees e 
LEFT JOIN departments d 
ON e.dep_id = d.dept_id_dep
WHERE YEAR(e.b_date)< 1980;

--Problem 5:
--Re-write the previous query but have the result set include all the employees but department names for only the employees who were born before 1980.
SELECT e.emp_id,e.l_name,e.b_date,e.dep_id,d.dep_name
FROM employees e 
LEFT JOIN departments d 
ON e.dep_id = d.dept_id_dep
AND YEAR(e.b_date)< 1980;

--Problem 6:
--Perform a Full Join on the EMPLOYEES and DEPARTMENT tables and select the First name, Last name and Department name of all employees.
SELECT e.f_name,e.l_name,d.dep_name
FROM employees e 
FULL OUTER JOIN departments d 
ON e.dep_id = d.dept_id_dep;

--Problem:
--Re-write the previous query but have the result set include all employee names but department id and department names only for male employees.
SELECT e.f_name,e.l_name,d.dept_id_dep,d.dep_name
FROM employees e 
FULL OUTER JOIN departments d 
ON e.dep_id = d.dept_id_dep
AND e.sex = 'M';