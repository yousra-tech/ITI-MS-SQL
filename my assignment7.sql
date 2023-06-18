--1)--creation:
create function getdates(@date date)
returns varchar(20)
--function body
	begin
		declare @m varchar(20)
		select @m =DATENAME(month, @date)
		return @m
	end
--calling:
select dbo.getdates('3/21/2023')
--------------------------------------------------
--2)
alter function num(@n1 int,@n2 int) --n1<n2
returns @t table(nums int)
as
	begin
		while @n1<@n2-1
			begin
			set @n1+=1   --assign
			insert into @t 
			select @n1
			end
	return
	end

select * from num(1,5)
-----------------------------------------------------
--3)
alter function getnum(@id int)
returns table
as return
	(select Dept_Name, st_fname, st_lname 
	 from Student s, Department d
	 where s.Dept_Id = d.Dept_Id and St_Id=@id)

select * from getnum(1)
-------------------------------------------------------
--4)
alter function mess(@id int)
returns varchar(50)
begin
	declare @m varchar(50)
	declare @fname varchar(50)=(select st_fname from Student where St_Id=@id)
	declare @lname varchar(50)=(select st_lname from Student where St_Id=@id)

	if @fname is null and @lname is null
	select @m = 'first name and last name are null'
	else
	if @fname is null
	select @m = 'first name is null'
	else
	if @lname is null
	select @m = 'last name is null'
	else
	select @m = 'first name and last name are not null'
	return @m
end

select dbo.mess(13)
--------------------------------------------------------------
--5)
create function dep(@id int)
returns table
as return 
(select Dept_Name,Ins_Name,Manager_hiredate 
 from Department d , Instructor i 
  where @id=Ins_Id and d.Dept_Manager = i.Ins_Id)

select * from dbo.dep(10)
--------------------------------------------------------------
--6)
alter function studnames(@format nvarchar(50))
returns @t table(student_name nvarchar(50))
as
begin
	if @format='first name'
		insert  into @t
		select isnull(st_fname,' ')
		from student
	else
	if @format='last name'
		insert  into @t
		select isnull(st_lname,' ')
		from student
	else
	if @format='full name'
		insert @t
		select isnull(st_fname,' ')+' '+isnull(st_lname,' ') 
		from student
return
end

select * from studnames('first name')
select * from studnames('last name')
select * from studnames('full name')
------------------------------------------------
--7)
select St_Id, left(St_Fname,len(st_fname)-1)
from Student
------------------------------------------------
--8)
delete from Stud_Course
where st_id in 
(select s.st_id 
 from Student s, Stud_Course sc, Department d
 where s.St_Id=Stud_Course.St_Id
 and s.Dept_Id=d.Dept_Id
 and d.Dept_Name='SD')
 --------------------------------------------------
 --Bonus
 --1)
 create table SimpleDemo  
(Node hierarchyid primary key clustered not null,
[Node Level] int not null,
[Geographical Name] nvarchar(30) not null,  
[Geographical Type] nvarchar(9) null);
 
insert SimpleDemo  
values
-- second level data 
('/1/1/',2,'China','Country')
,('/1/2/',2,'Japan','Country')
,('/1/3/',2,'South Korea','Country')
,('/2/1/',2,'South Africa','Country')
,('/2/2/',2,'Egypt','Country')
,('/3/1/',2,'Australia','Country')
 
-- first level data
,('/1/',1,'Asia','Continent')
,('/2/',1,'Africa','Continent')
,('/3/',1,'Oceania','Continent')
 
-- third level data
,('/1/1/1/',3,'Beijing','City')
,('/1/2/1/',3,'Tokyo','City')
,('/1/3/1/',3,'Seoul','City')
,('/2/1/1/',3,'Pretoria','City')
,('/2/2/1/',3,'Cairo','City')
,('/3/1/1/',3,'Canberra','City')
 
-- root level data
,('/',0,'Earth', 'Planet')  
------------------------------------------------------
 --2)
declare @id int =3000
while @id<=6000
	begin
		insert into Student(St_Id,St_Fname,St_Lname)
		values(@id,'jane','smith')
		set @id+=1
	end

select count (*) from Student

