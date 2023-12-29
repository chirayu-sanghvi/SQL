Station Table:

  

1) Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of  decimal places.

select round(sum(LAT_N),2), round(sum(LONG_W),2)
from station;
===============================================================
2) Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than . Truncate your answer to  decimal places.

select Round(sum(lat_n),4) from station 
where lat_n > 38.7880 and lat_n < 137.2345;
================================================================
3) Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to  decimal places.

select truncate(max(lat_n),4) from station where lat_n < 137.2345;
=================================================================
4) Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to  decimal places.

select round(long_w,4) from station where lat_n = (select max(lat_n) from station where lat_n < 137.2345);
==================================================================
5) Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to  decimal places.

select round(min(lat_n), 4) from station where lat_n > 38.7780;
===================================================================
6) Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than . Round your answer to  decimal places.

  select round(long_w,4) from station where lat_n = (select min(lat_n) from station where lat_n > 38.7780);
