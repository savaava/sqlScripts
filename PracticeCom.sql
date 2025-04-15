/* Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table. */
SELECT p.patient_id,first_name,last_name 
	FROM patients p JOIN admissions a ON p.patient_id=a.patient_id
    WHERE diagnosis='Dementia'

SELECT p.patient_id,first_name,last_name 
	FROM patients p, admissions a
    WHERE diagnosis='Dementia' AND p.patient_id=a.patient_id


/* Display every patient's first_name.
Order the list by the length of each name and then by alphabetically. */
SELECT first_name 
	FROM patients
	ORDER BY LENGTH(first_name),first_name


/* Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row. */
select SUM(gender='M') male_count, SUM(gender='F') female_count
	FROM patients

select 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
from patients