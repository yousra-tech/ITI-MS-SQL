--1))
select count(St_Age)
from Student

--2))
select distinct(Ins_Name)
from Instructor

--3))
select st_id,
isnull(St_Fname, ' ') + ' ' + isnull(St_Lname, ' ') as full_name,
isnull(dept_name, ' ')
from Student s, Department d
where s.Dept_Id = d.Dept_Id

--4))
select Ins_Name, Dept_Name
from Instructor i
left outer join Department d
on i.Dept_Id = d.Dept_Id

--5))
select St_Fname + St_Fname as full_name, Crs_Name
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id
inner join Course c
on sc.Crs_Id = c.Crs_Id
where Grade is not null 

--6))
select count(crs_id) as no_of_courses, Top_Name
from Course c
inner join Topic t
on c.Top_Id = t.Top_Id
group by top_name

--7))
select max(salary) as max, min(salary) as min
from Instructor

--8))
select * from Instructor
where Salary < (select avg(salary) from Instructor)

--9))
select Dept_Name
from Department d
inner join Instructor i
on d.Dept_Id = i.Dept_Id
where Salary = (select min(salary) from Instructor)

--10))
select distinct top(2) salary
from Instructor
order by salary desc

/*select * from
(select salary,
 DENSE_RANK() over(order by salary desc) as max_salaries
from Instructor) as new_table
where max_salaries <= 2 */

--11))
select Ins_Name, coalesce(convert(varchar(10),Salary), 'bonus') as salary
from Instructor

--12))
select avg(salary) from Instructor as avg

--13))
select stud.St_Fname, sup.*
from Student stud, Student sup
where stud.St_super = sup.St_Id

--14))
select Salary, dept_id
from
(select salary, dept_id,
 DENSE_RANK() over(partition by dept_id order by salary desc) as max_salaries
from Instructor where Salary is not null) as new_table
where max_salaries <= 2 

--15))
select * from
(select *,
 DENSE_RANK() over(partition by dept_id order by newid()) as rank
from student) as new_table
where rank = 1