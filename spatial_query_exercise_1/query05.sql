/*
    What is the longest duration trip across the two quarters? Your result shoud
    have a single row with a single column named max_duration.
*/

-- Enter your SQL query here
with all_trips as (
    select *
    from indego.trips_2021_q3

    union all

    select *
    from indego.trips_2022_q3
)

select max(duration) as max_duration
from all_trips
