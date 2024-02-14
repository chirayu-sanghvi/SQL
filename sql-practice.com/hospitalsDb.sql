/*
PATIENT TABLE SCHEMA

primary key icon	patient_id	INT
first_name	TEXT
last_name	TEXT
gender	CHAR(1)
birth_date	DATE
city	TEXT
primary key icon	province_id	CHAR(2)
allergies	TEXT
height	INT
weight	INT
*/


-- 1) Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

-- 2) Show first name and last name concatinated into one column to show their full name.
SELECT Concat(first_name, " ", last_name) as fullname from  patients;

-- 3) Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'
SELECT
  first_name,
  last_name,
  province_name
FROM patients
  JOIN province_names ON province_names.province_id = patients.province_id;
-- province_name is a new table whose schema is as follows (province_id, province_names)

-- 4) Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

-- OR
SELECT count(*) from patients where birth_date like '2010%';

-- 5) Show the first_name, last_name, and height of the patient with the greatest height.
SELECT
  first_name,
  last_name,
  MAX(height) AS height
FROM patients;

-- OR
select first_name, last_name, height from patients where height >= (select max(height) from patients); 

-- 6) Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000
select * from patients where patient_id in (1,45,534,879,1000);

/*
======================================= admissions Table Schema =================================================
primary key icon	patient_id	INT
admission_date	DATE
discharge_date	DATE
diagnosis	TEXT
primary key icon	attending_doctor_id	INT
*/

-- 7) Show the total number of admissions
select count(*) from admissions;



