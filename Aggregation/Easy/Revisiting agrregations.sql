CITY table

  Field          Type
  ID            NUMBER
  NAME          VARCHAR2(17)
  COUNTRYCODE   VARCHAR2(3)
  DISTRICT      VARCHAR2(20)
  POPULATION    NUMBER

  ========================================================================
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
5) Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN

select sum(POPULATION) from city where countrycode = 'jpn';
========================================
6) Query the difference between the maximum and minimum populations in CITY.

  select Max(population) - Min(population) from city;
=========================================

  
