-- Name : Tarun M
-- SRN : PES1UG20CS462
-- Section : H

-- 1. Find the average distance between subsequent stations for every train
select train_no, avg(distance) as AVG_DIST from route_info group by train_no;

-- 2. Find the average distance between subsequent stations for every train and display them in
-- descending order of distance
select train_no, avg(distance) as AVG_DIST from route_info group by train_no order by AVG_DIST  desc;

-- 3.Display the list of train numbers and the total distance traveled by each in descending
-- order of the distance traveled
select train_no, sum(distance) as total_distance from route_info group by train_no order by total_distance desc;

-- 4. List those trains that have maximum and minimum number compartments and also
-- display number of compartments they have. (2 queries one to find max and other to find
-- min)
select train_number, count(compartment_no) as MAX_COMPARTMENT from compartment group by train_number order by MAX_COMPARTMENT desc limit 1;
select train_number, count(compartment_no) as MIN_COMPARTMENT from compartment group by train_number order by MIN_COMPARTMENT asc limit 1;

-- 5. Display the number of phone numbers corresponding to the user_id(s) ADM_001,
-- USR_006, USR_10
select user_id, count(phone_no) as NO_PHONE from user_phone where user_id in ("ADM_001", "USR_006", "USR_010") group by user_id;

-- 6. Find the average fare per km for each train type specified and display the train type and
-- corresponding average fare per km as ‘Avg_Fare’ in decreasing order of Avg_Fare
select Train_Type, avg(fare_per_km) as AVG_FARE_PER_KM from fare group by Train_Type order by AVG_FARE_PER_KM desc;

-- 7. Retrieve all details of the oldest passenger.
select * from ticket_passenger where age = (select max(age) from ticket_passenger);

-- 8. Count the number of passengers whose name consists of ‘Ullal’. (Hint: Use the LIKE
-- operator)
select count(*) as NO_OF_PEOPLE from ticket_passenger where name like "%Ullal%";
