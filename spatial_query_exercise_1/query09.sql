/*
    List all the passholder types and number of trips for each across all years.

    In other words, in one query, give a list of all `passholder_type` options
    and the number of trips taken by `passholder_type`. Your results should have
    two columns: `passholder_type` and `num_trips`.
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
    passholder_type,
    count(*) as num_trips
from all_trips
group by passholder_type;
