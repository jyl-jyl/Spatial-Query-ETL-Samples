/*
    How many trips started on one day and ended on a different day? Your result
    should have one column named trip_year, one column named trip_quarter, and
    one column named num_trips.
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
where start_time::date != end_time::date
group by trip_year, trip_quarter
