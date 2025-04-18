/* Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table. */
SELECT p.patient_id,first_name,last_name 
	FROM patients p JOIN admissions a ON p.patient_id=a.patient_id
    WHERE diagnosis='Dementia'

-- Prodotto cartesiano completo tra le tabelle, senza filtrare 
SELECT p.patient_id,first_name,last_name 
	FROM patients p, admissions a
    WHERE p.patient_id=a.patient_id AND diagnosis='Dementia'

-- Nidificata semplice:
SELECT patient_id,first_name,last_name
	FROM patients 
    WHERE patient_id IN (
    	select a.patient_id FROM admissions a WHERE diagnosis='Dementia'	
    );



/* Display every patient's first_name.
Order the list by the length of each name and then by alphabetically. */
SELECT first_name 
	FROM patients
	ORDER BY LENGTH(first_name),first_name



/* Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row. */
SELECT * FROM (
	(SELECT Count(*) FROM patients WHERE gender='M') AS male_count,
  	(SELECT Count(*) FROM patients WHERE gender='F') AS female_count
);

select SUM(gender='M') male_count, SUM(gender='F') female_count
	FROM patients

select 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
from patients


/* Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't
include their name in the output list. If only 1 person is named 'Leo' then include them in the output. */
SELECT first_name 
	FROM patients
    GROUP BY first_name
    HAVING (COUNT(*)=1);

-- nidificata complessa
SELECT p1.first_name 
	FROM patients p1
    WHERE 1 = (
    	SELECT COUNT(*) FROM patients p2 WHERE p1.first_name=p2.first_name
    ) 
	ORDER BY p1.first_name;

SELECT first_name
	FROM (
      SELECT first_name, count(first_name) occurrencies
	  	FROM patients
    	GROUP BY first_name
  	)
	WHERE occurrencies = 1



/* Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.
Show results ordered ascending by allergies then by first_name then by last_name. */
SELECT first_name,last_name,allergies
	FROM patients
    WHERE allergies IN ('Penicillin','Morphine')
    ORDER BY allergies,first_name,last_name ASC;



/* Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */
SELECT patient_id, diagnosis
	FROM admissions
    GROUP BY patient_id,diagnosis
    HAVING (COUNT(*)>1)
    ORDER BY patient_id;



/* Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending. */
select city, COUNT(*) num_patients
	FROM patients
    GROUP BY city
    ORDER BY num_patients DESC, city ASC;



/* Show all allergies ordered by popularity. Remove NULL values from query. */
SELECT allergies, COUNT(*) total_diagnosis
	FROM patients
    WHERE allergies IS NOT NULL
    GROUP BY allergies
    ORDER BY total_diagnosis DESC;



/* Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade.
 Sort the list starting from the earliest birth_date. */
SELECT first_name,last_name,birth_date
	FROM patients
    WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
    ORDER BY birth_date;



/* We want to display each patient's full name in a single column.
Their last_name in all upper letters must appear first, then first_name in all lower case letters.
Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane */
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) new_name_format
	FROM patients
    ORDER BY first_name DESC;

SELECT UPPER(last_name) || ',' || LOWER(first_name) new_name_format
	FROM patients
	ORDER BY first_name DESC;



/* Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000. */
SELECT province_id, sum(height) total_heigh
	from patients
    GROUP BY province_id
    HAVING (total_heigh >= 7000);



/* Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' */
SELECT (MAX(weight)-MIN(weight)) weight_delta
	FROM patients
    WHERE last_name='Maroni';



/* Show all of the days of the month (1-31) and how many admission_dates occurred on that day.
 Sort by the day with most admissions to least admissions. */
SELECT DAY(admission_date) day_number, COUNT(*) number_of_admissions
	FROM admissions
    GROUP BY day_number
    ORDER BY number_of_admissions DESC;



/* Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters. */
SELECT patient_id, attending_doctor_id, diagnosis
	FROM admissions
    WHERE (patient_id%2!=0 AND attending_doctor_id IN (1,5,19))
       OR (attending_doctor_id LIKE '%2%' AND LEN(patient_id)=3)

SELECT patient_id, attending_doctor_id, diagnosis
	FROM admissions
    WHERE patient_id%2!=0 AND attending_doctor_id IN (1,5,19)
UNION 
SELECT patient_id, attending_doctor_id, diagnosis
	FROM admissions
    where attending_doctor_id LIKE '%2%' AND LEN(patient_id)=3



/* Show all columns for patient_id 542's most recent admission_date. */
SELECT * 
	FROM admissions
    GROUP BY patient_id
    HAVING (patient_id=542 and MAX(admission_date));

SELECT * 
	FROM admissions
    WHERE patient_id=542 
    GROUP BY patient_id
    HAVING (admission_date=MAX(admission_date));

SELECT * 
	FROM admissions a1
    WHERE a1.patient_id=542 AND a1.admission_date = (
    	SELECT MAX(a2.admission_date) FROM admissions a2
      		WHERE a2.patient_id=542
    );



/* Show first_name, last_name, and the total number of admissions attended for each doctor. */
SELECT first_name, last_name, count(*) admissions_total
	FROM doctors d JOIN admissions a ON d.doctor_id=a.attending_doctor_id
    GROUP BY d.doctor_id
    ORDER BY admissions_total DESC;

-- JOIN implicita
SELECT first_name, last_name, count(*) admissions_total
	FROM doctors d, admissions a 
    WHERE d.doctor_id=a.attending_doctor_id
    GROUP BY d.doctor_id
    ORDER BY admissions_total DESC;



/* For each doctor, display their id, full name, and the first and last admission date they attended. */
SELECT 
	doctor_id,
    CONCAT(first_name, ' ', last_name) full_name,
    MIN(admission_date) first_admission_date,
    MAX(admission_date) last_admission_date
    
	FROM doctors d JOIN admissions a ON d.doctor_id=a.attending_doctor_id
	GROUP BY doctor_id;



/* Display the total amount of patients for each province. Order by descending. */
SELECT province_name, COUNT(*) total_patients
	FROM province_names pr JOIN patients pa USING(province_id)
    GROUP BY province_id
    ORDER BY total_patients DESC;



/* For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name
who diagnosed their problem. */
SELECT 
	CONCAT(p.first_name, ' ', p.last_name) patient_full_name,
    diagnosis,
    CONCAT(d.first_name, ' ', d.last_name) doctor_full_name

	FROM admissions a
    	JOIN patients p USING(patient_id)
        join doctors d ON a.attending_doctor_id=d.doctor_id



/* display the first name, last name and number of duplicate patients based on their first name and last name.
Ex: A patient with an identical name can be considered a duplicate. */
SELECT first_name,last_name,COUNT(*) duplicates
	FROM patients
    GROUP BY first_name,last_name
    having duplicates>1;



/* Display patient's full name,
height in the units feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.
- Convert CM to feet by dividing by 30.48.
- Convert KG to pounds by multiplying by 2.205. */
SELECT
	CONCAT(first_name, ' ', last_name) patient_full_name,
    ROUND(height/30.48, 1) height_feet,
    ROUND(weight*2.205) weight_pounds,
    birth_date,
	'MALE' gender

	FROM patients
    WHERE gender='M'
UNION
SELECT 
	CONCAT(first_name, ' ', last_name) patient_full_name,
    ROUND(height/30.48, 1) height_feet,
    ROUND(weight*2.205) weight_pounds,
    birth_date,
    'FEMALE' gender
	
	FROM patients
    WHERE gender='F'

-- con CASE
SELECT
    concat(first_name, ' ', last_name) patient_full_name, 
    ROUND(height / 30.48, 1) height_feet, 
    ROUND(weight * 2.205, 0) weight_pounds,
	CASE 
		WHEN gender='M' THEN 'MALE'
		WHEN gender='F' THEN 'FEMALE' 
	END gender
	
    FROM patients



/* Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table.
(Their patient_id does not exist in any admissions.patient_id rows.) 
4 implementazioni: */
SELECT p.patient_id, first_name, last_name
	FROM patients p 
    where p.patient_id NOT IN (
    	SELECT a.patient_id FROM admissions a 
      		WHERE a.patient_id IS NOT NULL 
    );

SELECT p.patient_id, first_name, last_name
	FROM patients p 
    where NOT exists (
    	SELECT * FROM admissions a 
      		WHERE p.patient_id=a.patient_id
    );

SELECT p.patient_id, first_name, last_name
	FROM patients p LEFT JOIN admissions a ON p.patient_id=a.patient_id
    WHERE a.patient_id IS NULL

SELECT patient_id, first_name, last_name
	FROM patients
EXCEPT 
SELECT p.patient_id, first_name, last_name
	FROM patients p JOIN admissions a using(patient_id)



/* Display a single row with max_visits, min_visits, average_visits
where the maximum, minimum and average number of admissions per day is calculated.
Average is rounded to 2 decimal places. */
SELECT 
	MAX(num_visits) max_visits,
    MIN(num_visits) min_visits,
    ROUND(AVG(num_visits),2) average_visits
    
	FROM (
    	SELECT COUNT(*) num_visits
      		FROM admissions
      		group by admission_date
    );