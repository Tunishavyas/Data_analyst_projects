create schema cars;
use cars;

-- READ DATA--
select * from car_dekho;

-- Total Cars: To get a count of Total Records--
select count(*) from car_dekho; #7927

-- The Manager asked the employee how many cars will be available in 2023 --
select count(*) from car_dekho where year=2023; #6

-- The Manager asked the employee how many cars is available in 2020,2021,2023 --
select count(*) from car_dekho where year=2020; #74
select count(*) from car_dekho where year=2021; #7
select count(*) from car_dekho where year=2022; #7

-- GROUP BY--
select count(*) from car_dekho where year in(2020,2021,2022) group by year;

-- PRINT THE TOTAL OF ALL CARS BY YEAR--
select year,count(*) from car_dekho group by year;

-- HOW MANY DIESEL CARS WILL BE THERE IN 2020--
select count(*) from car_dekho where fuel="diesel" and year=2020; #20

-- HOW MANY PETROL CARS WILL THERE BE IN 2020 --
select count(*) from car_Dekho where fuel= "Petrol" and year=2020; # 51

-- PRINT ALL THE FUEL CARS(PETROL,DIESEL,CNG) BY YEAR --
select fuel,year,count(*) from car_dekho where fuel="Petrol" group by year;
select fuel,year,count(*) from car_dekho where fuel="cng" group by year;
select fuel,year,count(*) from car_dekho where fuel="diesel" group by year;

-- WHICH YEAR HAD MORE THAN 100 CARS  --
select year,count(*) from car_dekho group by year having count(*)>100;

-- ALL CARS COUNT DETAILS BETWEEN 2015 and 2023 --
select count(*) from car_dekho where year between 2015 and 2023; #4124

-- ALL CARS DETAILS BETWEEN 2015 and 2023 --
select * from car_dekho where year between 2015 and 2023;

-- END --