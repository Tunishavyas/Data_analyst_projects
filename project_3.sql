create schema db1;
use db1;
select * from mobile;

-- check mobile features and price list
select phone_name,price from mobile;

-- find the price of 5 most expensive phones
select * from mobile order by price desc LIMIT 5;

-- find the price of 5 most cheapest phones
select * from mobile order by price LIMIT 5;

-- List the top 5 samsung phones with price and all features
select * from mobile where brands="Samsung" order by price desc LIMIT 5;

-- Must have android phones list then top 5 high price android phones
select * from mobile where Operating_System_type="Android" order by price desc LIMIT 5;

-- Must have android phones list then top 5 lower price android phones
select * from mobile where Operating_System_type="Android" order by price LIMIT 5;

-- Must have IOS phones list then top high price IOS phones
select * from mobile where Operating_System_type="IOS" order by price desc LIMIT 5;

-- write a query which phone support 5g and also top 5 phone with 5g support
select * from mobile where 5G_Availability="Yes" order by price desc LIMIT 5;

-- Total price of all mobile is to be found with brand name
select brands,sum(price) as total_price from mobile group by brands;
