/*
Task 1
*/

load data infile "compartment.csv" into table compartment columns terminated by ',' optionally enclosed by "" escaped by "" lines terminated by '\n' ignore 1 lines;

select * from compartment;

update train_user set age = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), DOB)), '%Y')+0;

SELECT * FROM TRAIN_USER;

SELECT * FROM ROUTE_INFO WHERE DISTANCE BETWEEN 70 AND 150;

SELECT * FROM ROUTE_INFO WHERE ((from_station_name="Chennai" AND to_station_name="Sholingur") OR (from_station_name="Sholingur" AND to_station_name="Chennai"));
 
SELECT * FROM TRAIN WHERE NOT TRAIN_TYPE = "Mail";
 
SELECT train_no,train_name,departure,departure_time FROM Train NATURAL JOIN Ticket WHERE departure="Chennai" AND departure_time>"8:00:00";
 
SELECT * FROM Train_user WHERE dob >= "1980-01-01" AND dob < "1990-01-01";
 
SELECT user_id,firstname,lastname from Train_user WHERE dob >= "1980-01-01" AND dob < "1990-01-01";
 
SELECT user_id,firstname,lastname from Train_user WHERE LEFT(firstname, 1)='S';
 
SELECT availability FROM Compartment WHERE compartment_type="I Class" AND train_number=62621;
 
SELECT pnr, transaction_no FROM Payment_info WHERE bank="UNION BANK";

/*
Task 2
*/
CREATE USER TARUNM@localhost IDENTIFIED BY '789244';

GRANT INSERT, UPDATE ON TABLE COMPARTMENT TO TARUNM@localhost;

REVOKE SELECT, UPDATE, DELETE ON COMPARTMENT FROM TARUNM@localhost;

SAVEPOINT S1;

SELECT * FROM FARE;

UPDATE FARE SET fare_per_km=4 where train_type='Fast';

SELECT * FROM FARE;

ROLLBACK TO S1;

SELECT * FROM FARE;