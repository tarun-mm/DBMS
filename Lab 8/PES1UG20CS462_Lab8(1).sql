DELIMITER $$
CREATE FUNCTION no_of_tckts(P_ID varchar(255))
RETURNS varchar(255)
DETERMINISTIC
BEGIN
DECLARE out varchar(255);
DECLARE tickets int;
SELECT count(pnr) into tickets
FROM ticket
WHERE passenger_id = P_ID AND MONTH(travel_date) = MONTH(NOW()) AND
YEAR(travel_date) = YEAR(NOW());
IF tickets > 3 THEN
SET out = 'cannot purchase tickets current limit is over”';
ELSE
SET out = 'can purchase tickets';
END IF;
RETURN out;
END; $$
DELIMITER ;

SELECT number_of_tickets('ADM_001') from ticket;
