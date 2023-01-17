DELIMITER $$
CREATE procedure upda_age(IN U_ID varchar(30), IN DOB DATE)
BEGIN
DECLARE new_age int; 
SET new_age = FLOOR(DATEDIFF(CURRENT_DATE,DOB)/365);
UPDATE train_user set Age = new_age where User_ID = U_ID;
END;$$
DELIMITER ;

SELECT * from train_user WHERE User_ID='ADM_001' ;
CALL upda_age('ADM_001','1989-04-14');
SELECT * from train_user WHERE User_ID='ADM_001' ;