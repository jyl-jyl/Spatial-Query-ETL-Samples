/*
    Give the five most popular starting stations across all years between 7am
    and 9:59am. Your result should have 5 records with four columns, one for the
    station id (named `station_id`), one for the point geography of the station
    (named `station_geog`), and one for the number of trips that started at that
    station (named `num_trips`).
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
    start_station as station_id,
    st_setsrid(st_makepoint(start_lon, start_lat), 4326)::geography as station_geog,
    count(*) as num_trips
from all_trips
where extract(hour from start_time) between 7 and 9
group by station_id, station_geog
order by num_trips desc
limit 5
