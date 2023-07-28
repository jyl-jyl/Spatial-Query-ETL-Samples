/*
    How many trips in each quarter were shorter than 10 minutes? Your result
    should have two records with three columns, one for the year (named
    `trip_year`), one for the quarter (named `trip_quarter`), and one for the
    number of trips (named `num_trips`).
*/

-- Enter your SQL query here
with all_trips as (
    select *
    from indego.trips_2021_q3

    union all

    select *
    from indego.trips_2022_q3
)

select
    extract(year from start_time) as trip_year,
    extract(quarter from start_time) as trip_quarter,
    count(*) as num_trips
from all_trips
where duration < 10
group by trip_year, trip_quarter
