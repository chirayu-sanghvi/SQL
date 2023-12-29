

1) Query a count of the number of cities in CITY having a Population larger than .
  
select count(*) from city 
where population > 100000;
==================================
2) Query the total population of all cities in CITY where District is California.

select Sum(POPULATION) as TOTAL_POPULATION from city where district = 'California';
====================================
3) Query the average population of all cities in CITY where District is California.

select AVG(POPULATION) from city where district = 'California';
=======================================
4) Query the average population for all cities in CITY, rounded down to the nearest integer

select FLOOR(AVG(POPULATION)) from city;
========================================
5)
