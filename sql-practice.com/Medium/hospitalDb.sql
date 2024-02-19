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

-- 19. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
  select concat(p.first_name," ",p.last_name) as patient_name, a.diagnosis, concat(d.first_name," ",d.last_name) as doctor_name
  from patients p join admissions a using(patient_id) join doctors d on a.attending_doctor_id = d.doctor_id;

-- OR
  SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) as patient_name,
    diagnosis,
    CONCAT(doctors.first_name,' ',doctors.last_name) as doctor_name
  FROM patients
    JOIN admissions ON admissions.patient_id = patients.patient_id
    JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id;

-- 20. Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.
  select first_name, last_name, count(*) as adminssion_total from doctors join admissions on doctors.doctor_id = admissions.attending_doctor_id group by doctor_id;
-- OR
  SELECT
  first_name,
  last_name,
  count(*) as admissions_total
  from admissions a
    join doctors ph on ph.doctor_id = a.attending_doctor_id
  group by attending_doctor_id

-- 21. For each doctor, display their id, full name, and the first and last admission date they attended.
  select doctor_id, concat(first_name," ", last_name) as full_name, Min(admission_date), Max(admission_date)
  from doctors d join admissions a on d.doctor_id = a.attending_doctor_id group by doctor_id;
-- OR
  select
  doctor_id,
  first_name || ' ' || last_name as full_name,
  min(admission_date) as first_admission_date,
  max(admission_date) as last_admission_date
  from admissions a
    join doctors ph on a.attending_doctor_id = ph.doctor_id
  group by doctor_id;

-- 22. Display the total amount of patients for each province. Order by descending.
  select province_name, count(*) patient_count from patients join province_names using(province_id) group by province_name order by patient_count desc;

-- OR
  SELECT
  province_name,
  COUNT(*) as patient_count
  FROM patients pa
    join province_names pr on pr.province_id = pa.province_id
  group by pr.province_id
  order by patient_count desc;

-- 23. display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.
  select first_name, last_name, count(*) as num_of_duplicates from patients group by first_name,last_name having count(*) > 1;

/*
-- 24. Display patient's full name,
height in the units feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.
*/
  select first_name || " " || last_name, Round(height/30.48, 1), round(weight*2.205, 0), birth_date,
  case 
  	when gender='M' Then 'MALE'
      when gender='F' then 'FEMALE'
  END AS gender_type
  from patients;

-- OR 
  select
      concat(first_name, ' ', last_name) AS 'patient_name', 
      ROUND(height / 30.48, 1) as 'height "Feet"', 
      ROUND(weight * 2.205, 0) AS 'weight "Pounds"', birth_date,
  CASE
  	WHEN gender = 'M' THEN 'MALE' 
    ELSE 'FEMALE' 
  END AS 'gender_type'
  from patients

-- 25. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
  select patient_id, first_name, last_name from patients Left outer join admissions using(patient_id) where admissions.patient_id is NULL;

-- OR
  SELECT
  patients.patient_id,
  first_name,
  last_name
  from patients
  where patients.patient_id not in (
      select admissions.patient_id
      from admissions
  )
