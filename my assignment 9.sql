--1)
create proc p1
as select count(st_id) , Dept_Name
from Student s, Department d
where s.Dept_Id = d.Dept_Id
group by Dept_Name

p1
---------------------------------------
--2)
create procedure check_emp @c int
as 

(select count(ESSn) from Works_for
 where pno=100 group by Pno)

 --------------------------------------
 --5)
create trigger t
on department
instead of insert
as
	select 'not allowed to insert into the table'

insert into Department(Dept_Id)
values(100)
--------------------------------------
--6)
alter trigger t1
on Employee
instead of insert
as
	if format(getdate(),'mmmm')='march'
		select 'not allowed'
	else
		insert into Employee
		select * from inserted

insert into Employee(SSN)
values(200)
