-----Create Schema and tables

drop table departments;
drop table dep_employees;
drop table dep_manager;
drop table employees;
drop table salaries;
drop table titles;


CREATE TABLE departments (
    dept_no varchar   NOT NULL,
    dept_name varchar   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dep_employees (
    emp_no int   NOT NULL,
    dept_no varchar   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
    CONSTRAINT "tbl_depemployees_emp_number_FK" 
	FOREIGN KEY (emp_no)
	REFERENCES Employees (emp_no),
	CONSTRAINT "tbl_depemployees_dep_number_FK" 
	FOREIGN KEY (dept_no)
	REFERENCES Departments (dept_no)
);

CREATE TABLE dept_manager (
    dept_no varchar   NOT NULL,
    emp_no int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
   CONSTRAINT "dept_manager_FK" 
	FOREIGN KEY (dept_no)
	REFERENCES Departments (dept_no),
	CONSTRAINT "dept_manager_FK1" 
	FOREIGN KEY (emp_no)
	REFERENCES Employees (emp_no)
	
);


CREATE TABLE Employees (
    emp_no int   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    gender varchar   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
	CONSTRAINT "tbl_salaries_emp_number_FK" 
	FOREIGN KEY (emp_no)
	REFERENCES Employees (emp_no)
);

CREATE TABLE Titles (
    emp_no int   NOT NULL,
    title varchar   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
	CONSTRAINT "tbl_titles_emp_number_FK" 
	FOREIGN KEY (emp_no)
	REFERENCES Employees (emp_no)
);

----1) List the following details of each employee: employee number, last name, first name, gender, and salary.
create view question1 as
select a.emp_no, a.last_name, a.first_name, a.gender, b.salary from Employees a left join salaries b on a.emp_no = b.emp_no;

----2) List employees who were hired in 1986.
create view question2 as
select emp_no, last_name, first_name, extract(year from hire_date) from Employees where extract(year from hire_date) = 1986

---3) List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
create view question3 as
select b.dept_name, a.dept_no, a.emp_no, c.last_name, c.first_name, a.from_date, a.to_date from dept_manager a left join departments b on a.dept_no = b.dept_no left join dep_employees d on b.dept_no = d.dept_no left join Employees c on d.emp_no = c.emp_no;

----4)List the department of each employee with the following information: employee number, last name, first name, and department name.
create view question4 as 
select a.emp_no, a.last_name, a.first_name, b.dept_name from Employees a left join Dep_Employees c on a.emp_no = c.emp_no left join departments b on c.dept_no = b.dept_no;

----5)List all employees whose first name is "Hercules" and last names begin with "B."
create view question5 as
select first_name, last_name from employees where first_name = 'Hercules' and last_name like 'B%';

---6)List all employees in the Sales department, including their employee number, last name, first name, and department name.
create view question6 as 
select a.emp_no, a.last_name, a.first_name, b.dept_name from Employees a left join Dep_Employees c on a.emp_no = c.emp_no left join  departments b on c.dept_no = b.dept_no where dept_name = 'Sales';


----7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
create view question7 as 
select a.emp_no, a.last_name, a.first_name, b.dept_name from Employees a left join Dep_Employees c on a.emp_no = c.emp_no left join  departments b on c.dept_no = b.dept_no where dept_name in ('Sales','Developments');

---------8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
create view question8 as 
select last_name, count(last_name)as  count from Employees group by last_name order by count(last_name);
