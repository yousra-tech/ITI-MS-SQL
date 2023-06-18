--1))
select SalesOrderID, ShipDate
from sales.SalesOrderHeader
where ShipDate between '7/28/2002'and '7/29/2014'

--2))
select ProductID, Name
from [Production].[Product]
where StandardCost < 110

--3))
select ProductID, Name
from [Production].[Product]
where Weight is not null

--4))
select ProductID, Name
from [Production].[Product]
where Color in ('Silver', 'Black', 'Red')

--5))
select ProductID, Name
from [Production].[Product]
where name like 'B%'

--6))
update [Production].[ProductDescription]
set Description = 'Chromoly steel_High of defects'
where ProductDescriptionID = 3

select ProductDescriptionID, Description
from [Production].[ProductDescription]
where Description like '%[_]%'

--7))
select sum(totaldue), OrderDate
from sales.SalesOrderHeader
where OrderDate between '7/1/2001' and '7/31/2014'
group by OrderDate

--8))
select distinct(HireDate)
from [HumanResources].[Employee]

--9))
select avg(distinct(ListPrice))
from [Production].[Product]

--10))
select 'The' + Name + ' ' + 'is only!' + ' ' + convert(varchar(20), ListPrice)
from [Production].[Product]
where ListPrice between 100 and 120
order by ListPrice

--11))
--a)
select Name, rowguid, SalesPersonID, Demographics 
into store_Archive
from [Sales].[Store] 

select count(*) from store_Archive ---> 701 rows

--b)
select Name, rowguid, SalesPersonID, Demographics 
into store_Archive_new
from [Sales].[Store] 
where 1 = 2   ---to copy just the structure


--12))
select getdate()
union select convert(varchar(50),getdate())
union select cast( getdate() as varchar(50)) 
union select format(getdate(),'ddd MMM yy')