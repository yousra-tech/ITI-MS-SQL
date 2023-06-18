--1)
create view v1
as select St_Fname, St_Lname, Crs_Name
from Student s, Stud_Course sc, Course c
where s.St_Id=sc.St_Id
and sc.Crs_Id=c.Crs_Id
and grade > 50

select * from v1
---------------------------------------------
--2)-----5t
create view v2 
with encryption
as select Ins_Name, top_name
from Instructor i, Topic t, Course c, Ins_Course ic
where t.Top_Id=c.Top_Id
and c.Crs_Id=ic.Crs_Id
and ic.Ins_Id = i.Ins_Id

select * from v2
-------------------------------------------
--3)
create view v3
as select Ins_Name,Dept_Name
from Instructor i, Department d 
where i.Dept_Id=d.Dept_Id
and Dept_Name in('SD','Java')

select * from v3
------------------------------------------
--4)
create view v4
as select * from Student
where St_Address in ('cairo','alex')
with check option
-----------------------------------------
--5)
use Company_SD
create view v5 
as select Pname, count(ssn) as empnum_proj
from Project p, Employee e
where p.Dnum=e.Dno
group by Pname

select * from v5
---------------------------------------
--6)
create clustered index i1
on department(manager_hiredate) --Cannot create more than one clustered index
----------------------------------------
--7)
create unique index i2  --duplicate key was found, unique applied on old and new data
on student(st_age)
-----------------------------------------
--8)---aaa
merge into lasttransaction t
using dailytransaction s
on t.id = s.id
when matched then
	update set t.amount=l.amount

when not matched then
	insert values(t.id,t.amount)
-------------------------------------
--9)
declare c1 cursor
for select salary from employee
for update

declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
	begin 
		if @sal>=3000
			update employee
				set salary=@sal*1.20
			where current of c1
		else if @sal<3000
			update employee
				set salary=@sal*1.10
			where current of c1
		fetch c1 into @sal
	end
close c1
deallocate c1
------------------------------------------
--10)--join 1 
declare c1 cursor
for select d.dept_id, dept_name, ins_name 
	from department d, instructor i
	where d.dept_id = i.dept_id
	and d.dept_manager = i.ins_id
for read only      

declare @dep_id int, @dep_name varchar(30), @manager_name varchar(30)
open c1   
fetch c1 into @dep_id, @dep_name ,@manager_name
while @@FETCH_STATUS=0
	begin
		select @dep_name, @manager_name
		fetch c1 into @dep_id, @dep_name, @manager_name 
	end
close c1
deallocate c1
------------------------------------
--11)
declare c1 cursor
for select distinct st_fname from Student 
    where st_fname is not null
for read only

declare @name varchar(20),@all_names varchar(300)=''
open c1
fetch c1 into @name
while @@FETCH_STATUS=0
	begin
		set @all_names=concat(@all_names,',',@name)
		fetch c1 into @name
	end
select @all_names
close c1
deallocate c1
---------------------------------------------------
--Part2
--1)
create view v_clerk
as select empno, projectno, enter_date
from works_on w, project p 
where w.projectno = p.projectno 
and job='clerk'
-------------------------------------------------
--2)
create view v_without_budget
as select * from project
where budget is null
-------------------------------------------------
--3)
create view v_count
as select projectname, count(job)
from works_on w, project p 
where w.projectno = p.projectno 
group by projectname
-----------------------------------------------
--4)
create view v_project_p2
as select empno
from works_on w, project p 
where w.projectno = p.projectno 
and projectno = 2
------------------------------------------------
--5)
create view v_project_p2
as select empno
from works_on w, project p 
where w.projectno = p.projectno 
and projectno in (1,2)
----------------------------------------------------
--6)
drop view v_clerk,v_count
---------------------------------------------------
--7)
create view v5
as select empno, lname
from employee e, department d
where e.deptno = d.deptno
and deptno=2
-----------------------------------------
--8)
create view v6
as select empno, lname
from employee e, department d
where e.deptno = d.deptno
and lname like '%j%'
------------------------------------------
--9)
create view v_dept
as select deptno, deptname
from department
--------------------------------------------
--10)
insert into v_dept (deptno, deptname)
values(4, 'Development')
----------------------------------------------
--11)
create view v_2006_check
as select empno, projectno, enter_date
from employee e, works_on w
where e.empno = w.empno
and enter_date between '1/1/2006' and '12/1/2006'