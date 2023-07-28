/*
    Using the station status dataset, find the distance in meters of each station
    from Meyerson Hall. Round to the nearest fifty meters.

    Your results should have three columns: station_id, station_geog, and distance.
*/

-- Enter your SQL query here
with meyerson_hall as (
    select st_setsrid(st_makepoint(-75.1925955, 39.9524158), 4326) as geog
)

select
    station_statuses.id as station_id,
    station_statuses.geog as station_geog,
    round(st_distance(station_statuses.geog, meyerson_hall.geog) / 50) * 50 as distance
from indego.station_statuses
cross join meyerson_hall
