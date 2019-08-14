--Question 1
select e.emp_num, e.last_name, e.first_name, e.gender, s.salary
from employees e join salaries s on e.emp_num = s.emp_no;

--Question 2
select e.emp_num, e.last_name, e.first_name, e.hire_date
from employees e
where e.hire_date between '1/1/1986' and '12/31/1986';

--Question 3
select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
from departments d join dept_manager dm on d.dept_no = dm.dept_no join employees e on dm.emp_no = e.emp_num;

--Question 4
select e.emp_num, e.last_name, e.first_name, d.dept_name
from employees e join dept_emp de on e.emp_num = de.emp_no join departments d on d.dept_no = de.dept_no;

--Question5
select e.last_name, e.first_name 
from employees e
where e.first_name = 'Hercules' and 
		e.last_name like 'B%';

--Question 6
select e.emp_num, e.last_name, e.first_name, s.salary, d.dept_name
from employees e join dept_emp de on e.emp_num = de.emp_no 
join departments d on d.dept_no=de.dept_no join salaries s on e.emp_num = s.emp_no
where d.dept_name = 'Sales';

--Question7
select e.emp_num, e.last_name, e.first_name, s.salary, d.dept_name
from employees e join dept_emp de on e.emp_num = de.emp_no 
join departments d on d.dept_no=de.dept_no join salaries s on e.emp_num = s.emp_no
where d.dept_name in ('Sales','Development');

--Question 8
select e.last_name, count(e.first_name) as count_lname
from employees e
group by e.last_name
order by count(e.last_name) desc;