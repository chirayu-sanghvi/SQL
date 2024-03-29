Question Link: https://www.hackerrank.com/challenges/the-blunder/problem

Prompt: Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.
=======================================================================================================================

Solution: 

SELECT ROUND(AVG(Salary)) - ROUND(AVG(REPLACE(Salary,0,""))) FROM EMPLOYEES
