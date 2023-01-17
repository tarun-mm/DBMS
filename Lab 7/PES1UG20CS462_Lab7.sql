/*
INSERT INTO ticket (PNR, Train_No, Travel_date, Passenger_id, arrival_time, departure_time, Train_Type, compartment_type, compartment_No, arrival, departure) VALUES ('PNR021', 62621, '2021-10-22', 'USR_008', '20:30:00', '16:00:00', 'Superfast', 'I Class', 'F01', 'Chennai', 'Bengaluru' ); 
UPDATE train SET source = trim(source), destination = trim(destination);
*/

/* 
1. Find the list of passengers (user_id, user_type First name and last name)
who have travelled from Bengaluru to Chennai during the month of Oct 2021 
and Aug 2022.
*/
SELECT user_id, user_type, firstname, lastname FROM train_user, ticket WHERE user_id = passenger_id AND (travel_date >= "2021-10-01" AND travel_date <= "2021-10-31") AND (departure = "Bengaluru" AND arrival = "Chennai") 
UNION 
SELECT user_id, user_type, firstname, lastname FROM train_user, ticket WHERE user_id = passenger_id AND (travel_date >= "2022-08-01" AND travel_date <= "2022-08-31") AND (departure = "Bengaluru" AND arrival = "Chennai");

/*
2. Find the list of passengers (user_id, user_type First name and last name)
who have travelled from Bengaluru to Chennai during the month of Oct 2021
and also during Aug 2022. 
*/
SELECT user_id, user_type, firstname, lastname FROM train_user, ticket WHERE user_id = passenger_id AND (travel_date >= "2021-10-01" AND travel_date <= "2021-10-31") AND (departure = "Bengaluru" AND arrival = "Chennai")
INTERSECT 
SELECT user_id, user_type, firstname, lastname FROM train_user, ticket WHERE user_id = passenger_id AND (travel_date >= "2022-08-01" AND travel_date <= "2022-08-31") AND (departure = "Bengaluru" AND arrival = "Chennai");

/*
3. Find the list of passengers (user_id, user_type First name and last name)
who have travelled from Bengaluru to Chennai during the month of Aug 2022
and not in Oct 2021. 
*/
SELECT user_id, user_type, firstname, lastname FROM train_user, ticket WHERE (user_id = passenger_id AND (travel_date >= "2022-08-01" AND travel_date <= "2022-08-31") AND (departure = "Bengaluru" AND arrival = "Chennai"))
UNION
(SELECT user_id, user_type, firstname, lastname from train_user, ticket WHERE user_id = passenger_id AND (travel_date NOT BETWEEN "2021-10-01" AND "2021-10-31") AND (departure = "Bengaluru" AND arrival = "Chennai"));

/*
4. Find the list of passengers (user_id, user_type, First name and last name)
who have travelled from Bengaluru to Chennai and returned to Bengaluru within
a week.
*/
SELECT U.user_id, U.user_type, U.firstname, U.lastname FROM train_user AS U, ticket AS T WHERE U.user_id = T.passenger_id AND (T.departure = "Bengaluru" AND T.arrival = "Chennai") AND 
EXISTS 
(SELECT U1.user_id, U1.user_type, U1.firstname, U1.lastname FROM train_user AS U1, ticket AS T1 WHERE U1.user_id = T1.passenger_id AND (T1.departure = "Chennai" AND T1.arrival = "Bengaluru") AND (T1.travel_date BETWEEN T.travel_date AND DATE_ADD(T.travel_date, INTERVAL 7 DAY)));

/* 
5. Find the list of passengers (user_id, user_type, First name and last name)
who have travelled from Bengaluru to Chennai and did not return to Bengaluru
(in other words, only one way travel from Bengaluru to Chennai). 
*/
SELECT U.user_id, U.user_type, U.firstname, U.lastname FROM ticket as T, train_user as U
WHERE T.passenger_id = U.user_id AND T.departure = 'Bengaluru' AND T.Arrival = 'Chennai'
AND NOT EXISTS (SELECT pnr FROM ticket AS T1 WHERE (T.passenger_id = T1.passenger_id AND T1.arrival = 'Bengaluru' AND T1.departure = 'Chennai'));
