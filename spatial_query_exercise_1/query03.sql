/*
    What is the average duration of a trip for 2021? Round to two decimal
    places.
*/

-- Enter your SQL query here
select round(avg(duration), 2) as avg_duration
from indego.trips_2021_q3
