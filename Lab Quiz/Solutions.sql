--- SET 1
--- 1)
SELECT h_locality, COUNT(hospital_id)
FROM hospital NATURAL JOIN hospital_request
GROUP BY h_locality
ORDER BY hospital_id;

--- 2)
DELIMITER $$
CREATE OR REPLACE TRIGGER prevent_insert
  BEFORE INSERT ON patient
  FOR EACH ROW
BEGIN
  IF NEW.locality="Devanahalli" THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Area is not servicable';
  END IF;
END; $$
DELIMITER ;

INSERT INTO `Patient` (`patient_id`, `patient_name`, `patient_surname`, `gender`, `blood_group`, `contact`, `street`, `house_number`, `locality`, `rt_id`, `date_registration`) 
VALUES ('P0025', 'Kavya ', 'Gandhi', 'F', 'AB+', '1122334455', 'MG road', '10', 'Majestic', 440, '2022-11-01');

INSERT INTO `Patient` (`patient_id`, `patient_name`, `patient_surname`, `gender`, `blood_group`, `contact`, `street`, `house_number`, `locality`, `rt_id`, `date_registration`) 
VALUES ('P0025', 'Kavya ', 'Gandhi', 'F', 'AB+', '1122334455', 'MG road', '10', 'Devanahalli', 440, '2022-11-01');

--- SET 2
--- 1)
SELECT patient.patient_name, patient.patient_id, patient.blood_group, requests.blood_group
FROM patient 
JOIN patient_request 
ON patient.patient_id = patient_request.patient_id 
JOIN requests 
ON patient_request.request_id = requests.request_id
WHERE patient.blood_group != requests.blood_group;

--- 2)
DELIMITER $$
CREATE OR REPLACE FUNCTION myfunc(bg varchar(3))
RETURNS varchar(20)
DETERMINISTIC
BEGIN
    DECLARE msg varchar(20);
    IF bg="O+" OR bg="O-" THEN
        SET msg="Universal Donor";
    ELSE
        SET msg="Regular Donor";
    END IF;
    RETURN msg;
END; $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE donor_type()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE d_id VARCHAR(100);
    DECLARE d_name VARCHAR(100);
    DECLARE d_surname VARCHAR(100);
    DECLARE d_gender VARCHAR(100);
    DECLARE blood_group VARCHAR(100);
    DECLARE contact_no VARCHAR(100);
    DECLARE d_street VARCHAR(100);
    DECLARE d_house_number VARCHAR(100);
    DECLARE d_locality VARCHAR(100);
    DECLARE d_age VARCHAR(100);
    DECLARE d_disease VARCHAR(100);
    DECLARE id_blood VARCHAR(100);
    DECLARE bloodGroup_Blood VARCHAR(100);
    DECLARE id_rt VARCHAR(100);
    DECLARE date_register VARCHAR(100);
    DECLARE cur CURSOR FOR SELECT * FROM donor;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    label: LOOP
        IF done = 1 THEN LEAVE label;
        END IF;
        FETCH cur INTO d_id, d_name, d_surname, d_gender, blood_group, contact_no, d_street, d_house_number, d_locality, d_age, d_disease, id_blood, bloodGroup_Blood, id_rt, date_register;
        SELECT blood_group, myfunc(blood_group) AS donor_type;
    END LOOP;
    CLOSE cur;
END; $$
DELIMITER ;

CALL donor_type();

--- SET 3
--- 1)
SELECT ta_name, COUNT(bu_id) AS units
FROM technical_analyst NATURAL JOIN technical_analyst_blood
GROUP BY ta_id
ORDER BY units;


--- 2)
DELIMITER $$
CREATE OR REPLACE TRIGGER prevent_extra
  BEFORE INSERT ON blood_bank
  FOR EACH ROW
BEGIN
  IF NEW.bb_locality IN (SELECT bb_locality FROM blood_bank) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Requires statutory permission';
  END IF;
END; $$
DELIMITER ;

INSERT INTO `Blood_Bank` (`bb_id`, `bb_name`, `bb_street`, `bb_building_no`, `bb_locality`) 
VALUES (1004, 'Red Cross Blood Bank', 'MG Road', 121, 'Whitefield');

INSERT INTO `Blood_Bank` (`bb_id`, `bb_name`, `bb_street`, `bb_building_no`, `bb_locality`) 
VALUES (1005, 'Red Cross Blood Bank', 'MG Road', 121, 'Whitefield');

--- SET 4
--- 1)
SELECT * FROM
(SELECT blood_group, COUNT(request_id) AS num_requests
FROM requests
GROUP BY blood_group) t1
NATURAL JOIN 
(SELECT blood_group, COUNT(d_id) AS num_donors
FROM donor
GROUP BY blood_group) t2
ORDER BY num_requests;

--- 2)
DELIMITER $$
CREATE OR REPLACE FUNCTION health(disease VARCHAR(50))
RETURNS VARCHAR(4)
DETERMINISTIC
BEGIN
 DECLARE msg varchar(4);
 IF disease = "NIL" OR disease = "Nil" THEN
   SET msg = "Good";
 ELSE
   SET msg ="Fair";
 END IF;
 RETURN msg;
END; $$ 
DELIMITER ;

SELECT d_name, d_disease, health(d_disease) AS result FROM donor;