-- Select everything from sales table

select * from sales;

-- Show just a few columns from sales table

select SaleDate, Amount, Customers from sales;
select Amount, Customers, GeoID from sales;

-- Adding a calculated column with SQL

Select SaleDate, Amount, Boxes, Amount / boxes  from sales;

-- Naming a field with AS in SQL

Select SaleDate, Amount, Boxes, Amount / boxes as 'Amount per box'  from sales;

-- Using WHERE Clause in SQL

select * from sales
where amount > 10000;

-- Showing sales data where amount is greater than 10,000 by descending order
select * from sales
where amount > 10000
order by amount desc;

-- Showing sales data where geography is g1 by product ID &
-- descending order of amounts

select * from sales
where geoid='g1'
order by PID, Amount desc;

-- Working with dates in SQL

Select * from sales
where amount > 10000 and SaleDate >= '2022-01-01';

-- Using year() function to select all data in a specific year

select SaleDate, Amount from sales
where amount > 10000 and year(SaleDate) = 2022
order by amount desc;

-- BETWEEN condition in SQL with < & > operators

select * from sales
where boxes >0 and boxes <=50;

-- Using the between operator in SQL

select * from sales
where boxes between 0 and 50;

-- Using weekday() function in SQL

select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of week'
from sales
where weekday(SaleDate) = 4;

-- Working with People table

select * from people;

-- OR operator in SQL

select * from people
where team = 'Delish' or team = 'Jucies';

-- IN operator in SQL

select * from people
where team in ('Delish','Jucies');

-- LIKE operator in SQL

select * from people
where salesperson like 'B%';

select * from people
where salesperson like '%B%';

select * from sales;

-- Using CASE to create branching logic in SQL

select 	SaleDate, Amount,
		case 	when amount < 1000 then 'Under 1k'
				when amount < 5000 then 'Under 5k'
                when amount < 10000 then 'Under 10k'
			else '10k or more'
		end as 'Amount category'
from sales;

-- GROUP BY in SQL

select team, count(*) from people
group by team;

-- Joining table to extract sales date and Person name with amount

select s.saleDate,s.amount,p.Salesperson
from sales s
join people p on p.SPID=s.SPID;

-- Extract Product Name selling in the shipment
select s.saleDate,s.amount,pr.product
from sales s
left join products pr on pr.pid=s.pid;

-- Product Name and person Name
select s.saleDate,s.amount,p.Salesperson,pr.product,p.team
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.pid=s.pid
where s.amount<500
and p.team='Delish';

-- people from india and new zealand
select s.saleDate,s.amount,p.Salesperson,pr.product,p.team
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.pid=s.pid
join geo g on g.GeoID=s.GeoID
where s.amount<500
and p.team=''
and g.geo in('New Zealand', 'India');

--  Group by
select geoid,sum(amount)
from sales
group by Geoid;

-- show the name of the country
select g.geo,sum(amount)
from sales s
join geo g on s.geoid=s.geoid
group by g.geo;

-- get the data from people and product table
select pr.category,p.team,sum(boxes),sum(amount)
from sales s
join people p on p.spid=s.spid
join products pr on pr.pid=s.pid
where p.team <> ''
group by pr.category,p.team
order by pr.category,p.team;

-- total amounts by top 10 products
select pr.product,sum(s.amount) as total_amount
from sales s
join products pr on pr.pid=s.pid
group by pr.product
order by total_amount desc LIMIT 10;

-- Practise
-- Print details of shipments (sales) where amounts are > 2,000 and boxes are <100
select * from sales where amount>2000 and boxes<100;

-- How many shipments (sales) each of the sales persons had in the month of January 2022
select p.Salesperson, count(*)
from sales s
join people p on s.spid = p.spid
where s.SaleDate between ‘2022-1-1’ and ‘2022-1-31’
group by p.Salesperson;

-- Which product sells more boxes? Milk Bars or Eclairs
select pr.product,count(s.boxes) as count_of_boxes
from sales s
join products pr on pr.pid=s.pid
where pr.Product in ('Milk Bars', 'Eclairs')
group by pr.product;

-- Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select pr.product,count(s.boxes) as count_of_boxes
from sales s
join products pr on pr.pid=s.pid
where pr.Product in ('Milk Bars', 'Eclairs') and s.SaleDate between ‘2022-2-1’ and ‘2022-2-7’
group by pr.product;

-- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?

select *,
case when weekday(saledate)=2 then 'Wednesday_Shipment'
else ' '
end as 'W_Shipment'
from sales
where customers < 100 and boxes < 100;
 
 -- What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022
 select p.pid,p.Salesperson, count(s.spid)
from sales s
join people p on s.spid = p.spid
where s.SaleDate between ‘2022-1-1’ and ‘2022-1-7’
group by p.pid
having count(s.spid)>=1;

select distinct p.Salesperson
from sales s
join people p on p.spid = s.SPID
where s.SaleDate between ‘2022-01-01’ and ‘2022-01-07’;

-- Which salespersons did not make any shipments in the first 7 days of January 2022
select p.salesperson
from people p
where p.spid not in
(select distinct s.spid from sales s where s.SaleDate between ‘2022-01-01’ and ‘2022-01-07’);

 -- How many times we shipped more than 1,000 boxes in each month
select year(saledate) ‘Year’, month(saledate) ‘Month’, count(spid) as '1K_shipped'
from sales
where boxes>1000
group by year(saledate), month(saledate)