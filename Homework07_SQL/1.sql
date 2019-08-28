--Question 1
select e.emp_num, e.last_name, e.first_name, e.gender, s.salary
from employees e join salaries s on e.emp_num = s.emp_no;