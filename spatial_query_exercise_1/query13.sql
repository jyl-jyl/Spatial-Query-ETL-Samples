/*
    Which station is furthest from Meyerson Hall?

    Your query should return only one line, and only give the station id
    (station_id), station name (station_name), and distance (distance) from
    Meyerson Hall, rounded to the nearest 50 meters.
*/

-- Enter your SQL query here
with meyerson_hall as (
    select st_setsrid(st_makepoint(-75.1925955, 39.9524158), 4326) as geog
)

select
    station_statuses.id as station_id,
    station_statuses.name as station_name,
    round(st_distance(meyerson_hall.geog, station_statuses.geog) / 50) * 50 as distance
from indego.station_statuses
cross join meyerson_hall
order by distance desc
limit 1
