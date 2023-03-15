select * from Project1.dbo.Data1

select * from Project1.dbo.Data2

--Number of rows into our datasets

select COUNT(*) from Project1..Data1
select COUNT(*) from Project1..Data2

--Dataset for jharkhand and Bihar
use Project1
select * from data1 where state in('jharkhand','bihar')

--population of india

select * from Project1..Data2

select sum(population) as population from Project1..Data2

--avg growth 

select avg(growth)*100 as avg_growth from Project1..Data1;

select state,avg(growth)*100 as avg_growth from Project1..Data1 group by State;

--avg sex ratio

select state,avg(sex_ratio)as avg_sex_ratio from Project1..Data1 group by State

select state,round(avg(sex_ratio),0)as avg_sex_ratio from Project1..Data1 group by State order by avg_sex_ratio desc;

--avg literacy rate

select state,round(avg(Literacy),0)as avg_literacy_ratio from Project1..Data1 group by State order by avg_literacy_ratio desc;

select state,round(avg(Literacy),0)as avg_literacy_ratio from Project1..Data1 group by State having round(avg(literacy),0)>90 order by avg_literacy_ratio desc;

--Top 3 state showing highest growth ratio

select top 3 state,avg(growth)*100 as avg_growth from Project1..Data1 group by State order by avg_growth desc;

--bottom 3 state showing lowest sex ratio

select top 3 state,round(avg(sex_ratio),0)as avg_sex_ratio from Project1..Data1 group by State order by avg_sex_ratio asc;


--Top and Bottom  3 States in literacy

drop table if exists #topstates;
create table #topstates
(state nvarchar(255),
topstate float
)
insert into #topstates
select state,round(avg(literacy),0)as avg_literacy_ratio from Project1..Data1 group by State order by avg_literacy_ratio desc;

select * from #topstates order by #topstates.topstate desc;
select top 3 * from #topstates order by #topstates.topstate desc;



drop table if exists #bottomstates;
create table #bottomstates
(state nvarchar(255),
bottomstate float
)
insert into #bottomstates
select state,round(avg(literacy),0)as avg_literacy_ratio from Project1..Data1 group by State order by avg_literacy_ratio desc;

select * from #bottomstates order by #bottomstates.bottomstate asc;
select top 3 * from #bottomstates order by #bottomstates.bottomstate asc;

--union operator
select * from(
select top 3 * from #topstates order by #topstates.topstate desc)a

union

select * from (
select top 3 * from #bottomstates order by #bottomstates.bottomstate asc)b;


--States starting with letter a

select distinct State from Project1..Data1 where State like 'a%'

--Joining both Tables

select a.district,a.state,a.sex_ratio,b.population from Project1..Data1 a inner join Project1..Data2 b on a.District=b.District