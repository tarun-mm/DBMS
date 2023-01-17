--1

create view t as (Select passenger_id,count(pnr) as count,travel_date from ticket_590 group by passenger_id );
select * from t;
DELIMITER $$
CREATE FUNCTION validate_pass(passenger_id varchar(50))
RETURNS VARCHAR(50)
DETERMINISTIC

BEGIN
	declare ticket int;
    declare d date;
    DECLARE VALUE varchar(50);
	select count into  ticket from t where t.passenger_id=passenger_id;
	
	
	IF ticket>3 then
		set VALUE="Cannot purchase tickets Current limit is over";
    ELSE     
		set VALUE ="Can Purchase ticket";	
  end if;
  return value;      
  
END;
$$
DELIMITER ;

select DISTINCT passenger_id,validate_pass(passenger_id) as validate,count(pnr) as no_of_tickets from ticket_590 group by passenger_id;

--2
DELIMITER $$
CREATE procedure updatecurrentage()
BEGIN
DECLARE c DATE;
SELECT sysdate() into c;
update train_user_590
SET age=year(c)-year(dob);
END;$$
DELIMITER ;

call updatecurrentage();
select * from train_user_590;