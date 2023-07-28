/*
    What is the average distance (rounded to the nearest km) of all stations
    from Meyerson Hall? Your result should have a single record with a single
    column named avg_distance_km.
*/

-- Enter your SQL query here
with meyerson_hall as (
    select st_setsrid(st_makepoint(-75.1925955, 39.9524158), 4326) as geog
)

select round(avg(st_distance(meyerson_hall.geog, station_statuses.geog)) / 1000) as avg_distance_km
from indego.station_statuses
cross join meyerson_hall
