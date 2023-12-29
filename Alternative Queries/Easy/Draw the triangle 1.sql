P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20).

====================================================================================
Solution:


/*
Enter your query here.
*/
SELECT REPEAT('* ', 20 - number) AS pattern
FROM (
  SELECT  0 AS number UNION 
  SELECT  1 UNION 
  SELECT  2 UNION 
  SELECT  3 UNION 
  SELECT  4 UNION 
  SELECT  5 UNION 
  SELECT  6 UNION 
  SELECT  7 UNION 
  SELECT  8 UNION 
  SELECT  9 UNION 
  SELECT 10 UNION 
  SELECT 11 UNION 
  SELECT 12 UNION 
  SELECT 13 UNION 
  SELECT 14 UNION 
  SELECT 15 UNION 
  SELECT 16 UNION 
  SELECT 17 UNION 
  SELECT 18 UNION 
  SELECT 19 UNION 
  SELECT 20
) AS numbers;
