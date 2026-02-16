--1-
--SELECT * FROM bookings.aircrafts_data

--2-
/*
SELECT aircraft_code,
model
FROM bookings.aircrafts_data
*/

--3-
/*
SELECT 
model, range
FROM bookings.aircrafts_data
WHERE range < 5000
*/

--4-
--SELECT * FROM bookings.tickets WHERE ticket_no = 8290

/*
SELECT book_ref, passenger_id, passenger_name 
FROM bookings.tickets 
WHERE passenger_name LIKE 'V%'
OR passenger_name LIKE 'E%'
*/

/*
SELECT count(ticket_no)
FROM bookings.tickets 
WHERE passenger_name LIKE 'V%'
OR passenger_name LIKE 'E%'
*/

--5-
/*
SELECT flight_no, scheduled_departure, scheduled_arrival,
departure_airport, arrival_airport
FROM bookings.flights
WHERE departure_airport='DME'
AND scheduled_departure between '2017-08-31' and '2017-09-01' 
*/

/*
SELECT *
FROM bookings.flights
WHERE departure_airport='LED'
AND arrival_airport LIKE 'O%'
*/

--6-
/*
SELECT flight_no, scheduled_departure, scheduled_arrival,
departure_airport, arrival_airport
FROM bookings.flights
WHERE departure_airport='DME'
AND arrival_airport IN ('LED','KZN')
AND scheduled_departure between '2017-08-31' and '2017-09-01' 
ORDER BY scheduled_departure
*/

--7_1-
/*
SELECT 
--flight_no, scheduled_departure, scheduled_arrival,actual_departure,actual_arrival
COUNT(flight_no)
FROM bookings.flights
WHERE departure_airport='DME'
AND actual_departure IS NULL
*/

--7_2-
/*
SELECT 
flight_no, 
scheduled_departure, 
scheduled_arrival,
actual_departure,
actual_arrival
FROM bookings.flights
WHERE departure_airport='DME'
AND actual_departure IS NULL
*/


--7_3-

/*
SELECT 
flight_no, 
scheduled_departure, 
scheduled_arrival,
COALESCE(actual_departure,'9999-12-31') as actual,
COALESCE(actual_arrival,'9999-12-31') as n
FROM bookings.flights
WHERE departure_airport='DME'
AND actual_departure IS NOT NULL
AND actual_arrival IS NULL
*/

--7_4-

/*
SELECT 
flight_no, 
scheduled_departure, 
scheduled_arrival,
COALESCE(actual_departure,'9999-12-31') as "Actual departure",
COALESCE(actual_arrival,'9999-12-31') "Actual arrival" 
FROM bookings.flights
WHERE departure_airport='DME'
AND arrival_airport='KZN'
*/

--7_5-
/*
SELECT 
flight_no, 
scheduled_departure, 
scheduled_arrival,
COALESCE(actual_departure::varchar,'CANCELED') as "Actual departure"
FROM bookings.flights
WHERE departure_airport='DME'
AND arrival_airport='KZN'
*/

--8_1-
/*
SELECT  
scheduled_departure,
flight_no,
departure_airport,
arrival_airport
FROM bookings.flights
WHERE departure_airport='DME'
ORDER BY arrival_airport
*/

--8_2-
/*
SELECT  
scheduled_departure,
flight_no,
departure_airport,
arrival_airport
FROM bookings.flights
WHERE departure_airport='DME'
ORDER BY arrival_airport DESC, scheduled_departure 
*/

--9-
/*
SELECT  DISTINCT  
departure_airport,
arrival_airport
FROM bookings.flights
--WHERE departure_airport='DME'
ORDER BY 1 DESC,2
*/



--10-
/*
SELECT  scheduled_departure,
'from ' || departure_airport::varchar || 
' to ' || arrival_airport::varchar as Destination,
status
FROM bookings.flights
*/

--11-
/*
SELECT
--*
COUNT(*)
--DISTINCT  fare_conditions
FROM bookings.ticket_flights
--WHERE fare_conditions="Economy";
*/

/*
SELECT  
SUM(amount) as Summary,
COUNT(*) as "Число полётов",
SUM(amount)/COUNT(*) as "Среднее",
AVG(amount) as Average
FROM bookings.ticket_flights
WHERE fare_conditions='Economy';
--WHERE fare_conditions='Business';
--WHERE fare_conditions='Comfort';
*/

/*
SELECT  
COUNT(*) as "Число полётов"
FROM bookings.ticket_flights
--WHERE fare_conditions='Economy';
--WHERE fare_conditions='Business';
WHERE fare_conditions='Comfort';
*/

--12_1---
/*
SELECT
--actual_arrival
COUNT(actual_arrival) as "Число полётов"
FROM bookings.flights
--WHERE actual_arrival IS NULL
WHERE actual_arrival::date = '2017-06-12'
--WHERE COALESCE(actual_arrival::date,'2017-06-12')='2017-06-12';
*/

--12_2---
/*
SELECT
--COUNT(actual_arrival)
COUNT(*) 
FROM bookings.flights
--WHERE actual_arrival IS NULL
--WHERE actual_arrival::date = '2017-06-12'
WHERE COALESCE(actual_arrival::date,'2017-06-12')='2017-06-12';
*/

--12_3---
/*
SELECT
--actual_arrival
COUNT(DISTINCT actual_arrival)
FROM bookings.flights
--ORDER BY actual_arrival
WHERE 
--actual_arrival::date = '2017-05-17' 
--or 
actual_arrival::varchar is NULL;
*/

--13---
/*
SELECT
--departure_airport
COUNT(actual_arrival)
FROM bookings.flights
*/

--14---
/*
SELECT
departure_airport,
COUNT(actual_arrival)
FROM bookings.flights
GROUP BY departure_airport
ORDER BY COUNT(actual_arrival) DESC
*/

--15---
/*
SELECT
departure_airport,
COUNT(actual_arrival)
FROM bookings.flights
GROUP BY departure_airport
HAVING COUNT(actual_arrival) < 50
ORDER BY COUNT(actual_arrival) DESC
--WHERE 
--actual_arrival::date = '2017-05-17' 
--or 
--actual_arrival::varchar is NULL;
*/

--16_1---
/*
SELECT
departure_airport,
--arrival_airport,
COUNT(actual_arrival)
FROM bookings.flights
GROUP BY departure_airport
HAVING COUNT(actual_arrival) > 300
ORDER BY COUNT(actual_arrival) DESC
*/

/*
SELECT
departure_airport,
arrival_airport,
COUNT(actual_arrival)
FROM bookings.flights
GROUP BY ROLLUP (departure_airport, arrival_airport)
HAVING COUNT(actual_arrival) > 300
--ORDER BY COUNT(actual_arrival) DESC
*/

--16_2---
--/*
SELECT
departure_airport,
arrival_airport,
COUNT(actual_arrival)
FROM bookings.flights
--GROUP BY ROLLUP (departure_airport, arrival_airport)
GROUP BY CUBE (departure_airport, arrival_airport)
HAVING COUNT(actual_arrival) > 300
--*/
