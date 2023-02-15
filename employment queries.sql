ALTER TABLE departments_dup
 ADD COLUMN
(
dept_manager varchar(40) not null 
);

ALTER TABLE departments_dup
drop column dept_manager;

alter table departments_dup
CHANGE column dept_no dept_no char(4) null;

alter table departments_dup
CHANGE column dept_name dept_name varchar(40) null;


delete from departments_dup
where dept_no= 'd002';

insert into departments_dup(dept_no) value('d010'),('d011');

create table dept_manager_dup
(
emp_no int(11) not null,
dept_no char(4) null,
from_date date not null,
to_date date NULL
);

insert into dept_manager_dup
select * from dept_manager;

insert into dept_manager_dup (emp_no,from_date)
values (999904,'2017-01-01'),
		(999905,'2017-01-01'),
        (999906,'2017-01-01'),
        (999907,'2017-01-01');
        

delete from dept_manager_dup
where dept_no ="d001";
        

insert into departments_dup(dept_name) value ('public relations'); 


delete from departments_dup where dept_no = ('d002');


select m.dept_no, m.emp_no, d.dept_name
from
	dept_manager_dup m
		inner join
	departments_dup d on m.dept_no = d.dept_no
order by m.dept_no; 

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;
    
    
# dealing with duplicates, first we need to create the duplicates

insert into dept_manager_dup 
value ('110228', 'd003', '1992-03-21', '1999-01-01');

insert into departments_dup 
value ('d009', 'customer service');

select*  from dept_manager_dup order by  dept_no asc;

select * from departments_dup group by dept_no order by dept_no asc;

			# left join_ group by helps you remove duplicates
            
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT outer JOIN
    departments_dup d ON m.dept_no = d.dept_no
 ORDER BY m.dept_no; 

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM
    employees e
        left JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
    where e.last_name = 'Markovitch'
    order by dm.dept_no desc,e.emp_no;
    
    SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        right JOIN
    departments_dup d ON m.dept_no = d.dept_no
order BY m.dept_no; 
    
    # using where instead of join
    select 
			m.dept_no, m.emp_no, d.dept_no
	from
		dept_manager_dup m,
		departments_dup d
    where 
    m.dept_no = d.dept_no
    order by m.dept_no;
            
            # using join and where in the same query, extracting data from two dfn tables with a condition
            
 select 
 e.emp_no, e.first_name, e.last_name, s.salary
 from 
 employees e
 join
 salaries s on e.emp_no = s.emp_no
 where s.salary > '145000';
 
 # CROSS JOIN
 
 select 
 dm.*, d.*
 from 
 dept_manager dm
 cross join
 departments d
 order by dm.emp_no, d.dept_no; 
 
 # cross join with a condition
 
 select 
 dm.*, d.*
 from 
 dept_manager dm
 cross join
 departments d
 where
 d.dept_no <> dm.dept_no
 order by dm.emp_no, d.dept_no; 
 
 # connecting more than two tables
 
 select 
 e.*, d.*
 from 
 dept_manager dm
 cross join
 departments d
 join
 employees e on dm.emp_no = e.emp_no 
 where
 d.dept_no <> dm.dept_no
 order by dm.emp_no, d.dept_no;
 
 # select a list with the first 10 employess with all the departments thay can be assigned to
 
 select 
 e.*, d.*
 from 
 employees e
 cross join 
 departments d 
 where 
 e.emp_no<10011
 order by e.emp_no, d.dept_name 
 ;
 
 # average salaries of men and women in the company
 select 
 e.gender, round(avg(s.salary),0) as average_salary
 from 
 employees e
 join 
 salaries s on e.emp_no =  s.emp_no
 group by gender;
 
 # joining more that one table
 
 select
 e.first_name,
 e.last_name,
 e.hire_date,
 m.from_date,
 d.dept_name
from 
employees e
join
dept_manager m on e.emp_no = m.emp_no
join 
departments d on m.dept_no = d.dept_no
;

# average amount of salary paid by department

select 
d.dept_name, avg(salary) as average_salary
from
departments d
join
dept_manager m on d.dept_no = m.dept_no
join
salaries s on m.emp_no = s.emp_no
group by d.dept_name
having average_SALARY > 60000
ORDER BY average_salary desc;

#how many male & female managers do we have in the employees data base

select 
e.gender, count(dm.emp_no)
from
employees e
join
dept_manager dm on e.emp_no = dm.emp_no
group by gender
;

create table employee_dup
(
emp_no int(11),
birth_date date,
first_name varchar(14),
last_name varchar(16),
gender enum('m','f'),
hire_date date
);

-- duplicate the employees table

insert into employee_dup
select *from employees limit 20;

-- insert a duplicate row
insert into employee_dup 
values
('10001', '1953-09-02','Georgi','Facello', 'm','1986-06-26');

select * from employee_dup order by emp_no limit 20;

drop table employee_dup;

create table employee_dup
(
emp_no int(11),
birth_date date,
first_name varchar(14),
last_name varchar(16),
gender enum('m','f'),
hire_date date
);

insert into employee_dup
select e.* from employees e limit 20;

select * from employee_dup;

insert into employee_dup 
values
('10001', '1953-09-02','Georgi','Facello', 'm','1986-06-26');

-- Union vs union all-- union ignores duplicates, union all doesnt
select 
		e.emp_no,
        e.first_name,
        e.last_name,
        Null as dept_no,
        null as from_date
from
		employee_dup e
where
	e.emp_no = 10001
    union select
    null as emp_no,
    null as first_name,
    null as last_name,
    m.dept_no,
    m.from_date
from 
	dept_manager m;
    
    -- sub queries; queries embedded in a query; subqueries must always be placed in()
    # department heads' names and their emp_no
select 
	e.first_name, e.last_name, emp_no
    from
    employees e
    where
    e.emp_no in (select dm.emp_no from dept_manager dm);
    
    -- another example
    -- Extract info about all department managers who were hired btn 1990-01-01 and 1995-01-01
    
    select * from dept_manager where emp_no in (select emp_no from employees where hire_date between '1990-01-01' and '1995-01-01');
    
    -- exists:- checks if a certain rows are found with in a sub query

select * from dept_manager where exists (select emp_no from employees where hire_date between '1990-01-01' and '1995-01-01');


-- SUBQUERIES-------------------------------------------

-- assign employee number 110022 as a manager to all employees from 10001 to 10020, and employee number 110039 as
-- a manager to all employees from 10021 to 10040
SELECT 
A.*
FROM
	(SELECT 
    e.emp_no AS employee_id,
    dept_no AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_id
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no) as A 

UNION SELECT 
B.*
FROM
	(SELECT 
    e.emp_no AS employee_id,
    dept_no AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110039) AS manager_id
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no > 10020
GROUP BY e.emp_no
ORDER BY e.emp_no
limit 20) as B ;

drop table if exists emp_manager; 

create table emp_manager 
(
emp_no int(11) not null,
dept_no char(4) null,
manager_no int(11) not null
);


INSERT INTO emp_manager
SELECT
    u.*
FROM
    (SELECT
        a.*
    FROM
        (SELECT
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT
        b.*
    FROM
        (SELECT
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT
        c.*
    FROM
        (SELECT
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT
        d.*
    FROM
        (SELECT
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
    
    -- extract data only for those employees who are managers from the emp_manager
    
    select distinct
    e.* from emp_manager e
    join dept_manager d on e.emp_no = d.emp_no; 
    
    -- extract employees from dept_emptable with two start and end dates
    select * from dept_emp;
    
    select 
    emp_no, from_date, to_date, count(emp_no) as num
    from dept_emp 
    group by emp_no
    having num >1;
    
    
    -- view--------------------------------------------
    
    create or replace view v_dept_emp_latest_dates as
    select 
			emp_no, max(from_date) as from_date, max(to_date) as to_date
	from
			dept_emp
	Group by emp_no;
    
    select * from current_dept_emp;
    
    -- Stored routine ( Stored procedures)---------------------------
    
    use employees;
    
    drop procedure if exists select_employees;
    
    Delimiter $$ 
    Create procedure select_employees()
    Begin 
				select * from employees limit 1000;
	end $$
    delimiter ;
    
    -- how we invoke the procedure created
    
    Call select_employees();
    
    -- another way of creating procedures is by right clicking on the stored procedures in the schema section
    
    
-- another important use of stored procedures---stored procedure with an input parameter represented by an (in parameter 'p')

use employees;
drop procedure if exists emp_salary;

delimiter $$
use employees $$
create procedure emp_salary(in p_emp_no integer)
begin 
select 
  e.first_name, e.last_name, s.salary,s.from_date, s.to_date
  from
  employees e 
      join
      salaries s on e.emp_no=s.emp_no
      where 
      e.emp_no = p_emp_no;
      end $$
       delimiter ;
       
       -- stored routine using in and out, you must use the select into structure in the query
       
       use employees;
drop procedure if exists emp_avg_salary_out;

delimiter $$
use employees $$
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,3))
begin 
select 
 avg(s.salary)
 into p_avg_salary 
  from
 employees e
      join
      salaries s on e.emp_no=s.emp_no
      where 
      e.emp_no = p_emp_no;
      end $$
       delimiter ;
       
       -- variables---------------you must execute the codes in order
       set @v_avg_salary = 0;
       call employees.emp_avg_salary_out(11300, @v_avg_salary);
       select @v_avg_salary;
       
      
      
      -- functions-------------v-variable-----------------------------
       use employees;
drop function if exists emp_avg_salary_out;

delimiter $$
use employees $$
create function f_emp_avg_salary(p_emp_no integer) returns decimal(10,2)
deterministic no sql reads sql data
begin 
declare v_avg_salary Decimal(10,2);
SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
return v_avg_salary;
      end $$
       delimiter ;

-- my sql tgriggers--------------------------


-- indexes-------------helps speed up the work time
select * from salaries where salary>100000;

create index i_salary on salaries(salary); 

-- case statement 
select 
		emp_no, first_name, last_name,
case when gender ='m' then 'male' else 'female'
end as gender from employees;

-- using if
select 
		emp_no, first_name, last_name,
if(gender ='m','male','female') 
as gender from employees;

-- THE DIFFERENCE is IF is only used when you have JUST ONE comparisons unlike case where more than one can be applied- example

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'salary was raised more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'salary was raised by more than $20,000 but less than 30,000'
        ELSE 'salary was raised by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- My SQL window functions --------------
SELECT 
    emp_no, salary,
row_number() over() as row_num
FROM
    salaries;
    
    SELECT 
    emp_no, salary,
row_number() over(partition by emp_no order by salary desc) as row_num
FROM
    salaries;
    
-- my SQL alows you use several window functions in a singles query. Partition by can only be used in the context of applying window fxs
    
   select emp_no, min(salary) from salaries group by emp_no;
   
   select emp_no, count(salary) from salaries group by emp_no;
   
   
   -- rank() and dense_rank() ranks from top to bottom-----------------------------------------
   SELECT 
    emp_no, salary,
rank () over(partition by emp_no order by salary desc) as rank_num
FROM
    salaries
    where emp_no =11839 order by rank_num;
    
    -- dense rank ---------------------------------------------------
    
     SELECT 
    emp_no, salary,
dense_rank () over w as dense_rank_num
FROM
    salaries
    where emp_no = 11839
    WINDOW w as (partition by emp_no order by salary desc)
    order by dense_rank_num;
    
    
    SELECT 
    dm.emp_no, COUNT(s.salary) AS manager_salary
FROM
    dept_manager dm
        JOIN
    salaries s ON dm.emp_no = s.salary
GROUP BY dm.emp_no
ORDER BY dm.emp_no;

-- LAG AND LEAD
    select 
		emp_no,
        salary,
        lag(salary) over w as previous_salary,
        lead(salary) over w as next_salary,
        salary-lag(salary) over w as diff_salary_current_previous,
        lead(salary) over w - salary as diff_salary_next_currrent
	from 
		salaries
	where
		emp_no = 10001
	window w as (order by salary);
    
    select sysdate();
    
    
-- Common Table Expressions------- HOW MANY COMPANY EMPLOYEES RECEIVE HIGHER THAN THE COMPANY AVERAGE SALARY------------------------------

  with cte AS (
  SELECT AVG (salary) as avg_salary from salaries)
  select
  sum(case when s.salary >c.avg_salary then 1 else 0 end) as no_f_salaries_above_avg,
  count(s.salary) as total_no_of_salary_contracts
	from
		salaries s 
			join 
		employees e on s.emp_no = e.emp_no and e.gender = 'f'
			cross join 
            cte c;
            
            select * from salaries s join employees e on s.emp_no = e.emp_no and e.gender = 'f' join cte c; 
   
   -- RETRRIEVE THE highest conatact salary values of all employess hired in 2000 or later
   
  with emp_hired_from_jan_2000 as (
  select * from employees where hire_date > '2000-01-01'
  ),
   highest_contract_salary_value as (
   select e.emp_no, max(salary) from salaries s join emp_hired_from_jan_2000 e on e.emp_no = s.emp_no group by emp_no
   )
   select * from highest_contract_salary_value;
   
   -- CREATE TEMPORARY TABLES
   -- where , and can achieve the same
   
   create temporary table f_highest_salary
   select e.emp_no, max(s.salary) 
   from employees e
   join salaries s on e.emp_no = s.emp_no and e.gender = 'f'
   group by e.emp_NO;
   
   select * from f_highest_salary;
   
   create temporary table dates
   select 
	now() as current_date,
    date_sub(now(), interval '1' month) as a_month_later,
    date_sub(now(), interval '1' year) as a_year_later;
    
    
    -- Compare the number of male managers to the number of female managers from different departments for each year, 
    -- starting from 1990.
    
    SELECT
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year;

-- Compare the average salary of female versus male employees in the entire company until year 2002, 
-- and add a filter allowing you to see that per each department.

SELECT 
    ROUND(AVG(s.salary), 2) as salary,
    e.gender,
    YEAR(de.from_date) AS calender_year,
    d.dept_name
FROM
    t_dept_emp de
        JOIN
    t_employees e ON e.emp_no = de.emp_no
		JOIN
    t_departments d ON d.dept_no = de.dept_no
		 JOIN
    t_salaries s ON s.emp_no = de.emp_no
GROUP BY d.dept_no , e.gender , calender_year
HAVING calender_year <= 2002
ORDER BY d.dept_no;



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
   
   
   
    
    


       

       
       

    




 
 
 
 






        

