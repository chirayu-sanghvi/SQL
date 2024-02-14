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


