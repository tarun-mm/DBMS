-- DBMS WEEK-5

-- Name: Tarun M
-- SRN: PES1UG20CS462
-- Sec: H

-- 1a

CREATE VIEW compute_price AS 
SELECT Ticket.PNR, Ticket.Train_No, Ticket.Departure, Ticket.Arrival, Route_Info.Distance, Fare.fare_per_km FROM 
Ticket, Route_Info, Fare WHERE (Ticket.Train_No = Route_Info.Train_No AND Ticket.Departure = Route_Info.From_Station_Name AND 
Ticket.Arrival = Route_Info.To_Station_Name AND Fare.Train_Type=Ticket.Train_Type AND 
Fare.Compartment_Type =Ticket.Compartment_type);

-- 1b

CREATE VIEW passenger_num AS select PNR, count(PNR) as numbers from Ticket_Passenger group by PNR;

-- 1c

UPDATE Payment_Info AS p INNER JOIN compute_price AS cs ON p.PNR = cs.PNR INNER JOIN passenger_num AS pn ON cs.PNR = pn.PNR SET p.Price = cs.Distance * cs.Fare_Per_KM * pn.numbers;

-- 2

SELECT train_no,from_station_name,to_station_name,distance from route_info where to_station_no-from_station_no=1 order by train_no;

-- 3

select route_info.train_no from route_info inner join compartment on route_info.train_no = compartment.train_number where compartment.availability > 10 and from_station_name = "bengaluru" and to_station_name = "chennai";

-- 4

select name from ticket_passenger inner join payment_info on ticket_passenger.pnr = payment_info.pnr where price > 500;

-- 5

select firstname, lastname, dob, pnr from train_user left join ticket on user_id = passenger_id;

-- 6

select firstname, lastname, dob from train_user left join ticket on user_id = passenger_id where user_id not in (select passenger_id from ticket);

-- 7

select pnr, train_no, travel_date, firstname, lastname from ticket right join train_user on user_id = passenger_id;

-- 8

select passenger_id,ticket.train_no,train_name from ticket RIGHT OUTER JOIN train on ticket.train_no=train.train_no;

-- 9

SELECT t1.train_no,t1.train_name from train as t1, (select distinct t2.train_no from route_info as t2,(select distinct train_no from ticket where departure_time!="20:30:00") as t3 where (t2.train_no=t3.train_no) and (t2.Distance>100)) as t2 where (t1.train_no=t2.train_no) and (t1.Destination!="Mangaluru");

-- 10
select distinct passenger_id from ticket join payment_info on ticket.pnr=payment_info.pnr where payment_info.price>(select avg(price) from payment_info);