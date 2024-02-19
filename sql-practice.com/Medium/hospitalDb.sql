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

-- 13. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
-- Separate the last_name and first_name with a comma. Order the list by the first_name in decending order. EX: SMITH,jane
  select concat(upper(last_name),",",lower(first_name)) as new_name_format from patients order by first_name desc;

-- OR
  SELECT
    UPPER(last_name) || ',' || LOWER(first_name) AS new_name_format
  FROM patients
  ORDER BY first_name DESC;

-- 14. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
  select province_id, sum(height) as sum_height from patients group by province_id having sum_height >= 7000;
-- OR
  select * from (select province_id, SUM(height) as sum_height FROM patients group by province_id) where sum_height >= 7000;

-- 15. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
  select Max(weight) - MIn(weight) as weight_data from patients where last_name='Maroni';

-- 16. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
  select day(admission_date) as day_number , count(*) as number_of_admissions from admissions group by day(admission_date) order by number_of_admissions desc;

-- 17. Show all columns for patient_id 542's most recent admission_date.
  select * from admissions where patient_id = 542 order by admission_date desc limit 1;

-- 18. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
  SELECT
    patient_id,
    attending_doctor_id,
    diagnosis
  FROM admissions
  WHERE
    (
      attending_doctor_id IN (1, 5, 19)
      AND patient_id % 2 != 0
    )
    OR 
    (
      attending_doctor_id LIKE '%2%'
      AND len(patient_id) = 3
    )


