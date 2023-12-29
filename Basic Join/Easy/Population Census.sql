Question Link: https://www.hackerrank.com/challenges/asian-population/problem

prompt: Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

  ===================

Solution:

select sum(city.population) from city join country on city.countrycode = country.code where country.continent = 'Asia';


======================================================================================================
2) Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

Solution:

select city.name from city join country on city.countrycode = country.code where country.continent = 'Africa';

  
