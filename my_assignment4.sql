use Company_SD

--1a)) --use union
select Dependent_name, Sex
from Dependent 
where Sex='f'
intersect 
select Fname, Sex
from employee 
where Sex='f'

--1b))
select Dependent_name, Sex
from Dependent 
where Sex='m'
intersect 
select Fname, Sex
from employee 
where Sex='m'

--2))
select p.Pname, sum(Hours) as [total hours per week]
from Project p inner join Works_for w
on p.Pnumber = w.Pno
group by Pname

--3))
select d.*
from Departments d
inner join Employee
on Dno = Dnum
where SSN = (select min(ssn) from Employee)


--4))
select Dname, max(salary) as max, min(salary) as min, avg(salary) as avg
from Departments d
inner join Employee e
on d.Dnum = e.Dno
group by Dname

--5))emp&depart
select m.Fname, m.Lname
from Employee e, Employee m ----
where e.SSN = m.Superssn

and m.SSN not in (
select ESSN
from Dependent)

--6))
select Dnum, Dname, COUNT(ssn) as emp_no
from Departments 
inner join Employee 
on Dnum =Dno
group by Dnum, Dname
having avg(salary) < (select avg(salary)from Employee)

--7)) join with works for
select Fname, Lname, Pname
from Employee 
inner join Project
on Dno =Dnum
order by Dno, Fname, Lname

--8)) result appear reversly 3000-3600
select max(salary) as max
from Employee
union all
select max(salary)   
from Employee 
where Salary != (select max(salary) 
from Employee)


--9))
select Fname + ' ' + Lname 
from Employee
intersect
select Dependent_name
from Dependent

--10)) 
select SSN, Fname, Lname
from Employee
where exists 
(select * from Employee inner join Dependent on SSN = ESSN) --no join

--11))
insert into Departments
values('DEPT IT', 100, 112233, '1/11/2006')

--12))
--a)
update Departments
set MGRSSN = 968574
where Dnum = 100

--b)
update Departments
set MGRSSN = 102672 
where Dnum = 20

--C)
update Employee 
set Superssn = 102672
where SSN = 102660

--13))
delete from Dependent
where ESSN = 223344

update Departments
set MGRSSN = 102672
where MGRSSN = 223344

update Employee
set Superssn = 102672
where Superssn = 223344

delete from  Works_for
where ESSN = 223344

delete from Employee
where SSN = 223344

--14))
update Employee
set Salary = Salary * 1.30
where SSN =
			(select essn from Works_for 
			 inner join Project
			 on Pno = Pnumber
			 where Pname = 'al rabwah')
 





 

 








