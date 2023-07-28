/*
    How many stations are within 1km of Meyerson Hall? Your query should have a
    single record with a single attribute, the number of stations
    (num_stations).
*/

-- Enter your SQL query here
with meyerson_hall as (
    select st_setsrid(st_makepoint(-75.1925955, 39.9524158), 4326) as geog
)

select count(*) as num_stations
from indego.station_statuses
cross join meyerson_hall
where st_distance(meyerson_hall.geog, station_statuses.geog) < 1000
