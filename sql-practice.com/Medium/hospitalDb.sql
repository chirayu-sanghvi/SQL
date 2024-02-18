-- 1. Show unique birth years from patients and order them by ascending.
  SELECT distinct year(birth_date) from patients order by birth_date;

-- 2. Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
  SELECT first_name from patients group by first_name having count(first_name) = 1;

-- 3. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
  SELECT  patient_id ,first_name from patients where first_name like 's%s' and Len(first_name) > 5;

-- 4.Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
  SELECT  patient_id, first_name, last_name from patients p join admissions a using(patient_id) where diagnosis = 'Dementia'; 
-- OR
  SELECT
    patient_id,
    first_name,
    last_name
  FROM patients
  WHERE patient_id IN (
      SELECT patient_id
      FROM admissions
      WHERE diagnosis = 'Dementia'
    );

-- 5. Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
SELECT  first_name from patients order by len(first_name) , first_name ASC;

-- 6. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
  SELECT 
    (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
    (SELECT count(*) FROM patients WHERE gender='F') AS female_count;
-- OR
  SELECT 
    SUM(Gender = 'M') as male_count, 
    SUM(Gender = 'F') AS female_count
  FROM patients
-- OR
  select 
    sum(case when gender = 'M' then 1 end) as male_count,
    sum(case when gender = 'F' then 1 end) as female_count 
  from patients;

-- 7. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
-- Show results ordered ascending by allergies then by first_name then by last_name.
  SELECT first_name, last_name, allergies
  from patients
  where allergies in ('Penicillin','Morphine')
  order by allergies, first_name, last_name;

-- 8. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
  SELECT
    patient_id,
    diagnosis
  FROM admissions
  GROUP BY
    patient_id,
    diagnosis
  HAVING COUNT(*) > 1;

-- 9. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
  SELECT
    city,
    COUNT(*) AS num_patients
  FROM patients
  GROUP BY city
  ORDER BY num_patients DESC, city asc;

-- 10. Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
  SELECT first_name, last_name, 'Patient' as role FROM patients
      union all
  select first_name, last_name, 'Doctor' from doctors;

-- 11. Show all allergies ordered by popularity. Remove NULL values from query.
  SELECT
    allergies,
    COUNT(*) AS total_diagnosis
  FROM patients
  WHERE
    allergies IS NOT NULL
  GROUP BY allergies
  ORDER BY total_diagnosis DESC

-- 12. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
  select first_name, last_name, birth_date from patients where year(birth_date) between 1970 and 1979 order by birth_date;

-- 13. 
