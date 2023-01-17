DELIMITER $$
CREATE TRIGGER max_4_cmpts
BEFORE INSERT
ON compartment FOR EACH ROW
BEGIN
DECLARE err_msg VARCHAR(255);
SET err_msg = ('More than 4 compartments are not available');
IF NEW.availability > 4 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = err_msg;
END IF;
END $$
DELIMITER ;
