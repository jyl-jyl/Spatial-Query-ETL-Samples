/*
    What is the average duration of a trip for 2022? Round to two decimal
    places and name your field avg_duration.
*/

-- Enter your SQL query here
select round(avg(duration), 2) as avg_duration
from indego.trips_2022_q3
