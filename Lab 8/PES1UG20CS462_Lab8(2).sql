DELIMITER $$
CREATE procedure upd_age(IN U_ID varchar(30), IN DOB DATE)
BEGIN
DECLARE age_new int;
SET age_new = FLOOR(DATEDIFF(NOW(),DOB)/365);
UPDATE train_user set age = age_new where user_id = U_ID;
END;$$
DELIMITER ;
CALL upd_age('ADM_001','1989-04-14');

SELECT * FROM train_user WHERE user_id='ADM_001';
