/*
    Using the shapes.txt file from GTFS bus feed, find the two routes with the
    longest trips. In the final query, give the trip_headsign that corresponds
    to the shape_id of this route and the length of the trip.
*/

with

septa_bus_shapes as (
    select
        shape_id,
        st_makeline(
            st_makepoint(shape_pt_lon, shape_pt_lat)
            order by shape_pt_sequence
        )::geography as shape_geog
    from septa.bus_shapes
    group by shape_id
),

septa_bus_trips_with_shape as (
    select
        trip.route_id,
        trip.trip_headsign,
        shape.shape_geog,
        st_length(shape.shape_geog) as shape_length
    from septa.bus_trips as trip
    inner join septa_bus_shapes as shape
        on trip.shape_id = shape.shape_id
),

septa_bus_trips_with_ordered_shapes as (
    select
        *,
        row_number() over (
            partition by route_id
            order by shape_length desc
        ) as shape_length_order
    from septa_bus_trips_with_shape
),

septa_bus_route_with_longest_trip as (
    select
        route.route_short_name,
        trip.trip_headsign,
        trip.shape_geog,
        trip.shape_length
    from septa.bus_routes as route
    inner join septa_bus_trips_with_ordered_shapes as trip
        on route.route_id = trip.route_id
    where trip.shape_length_order = 1
)

select
    route_short_name,
    trip_headsign,
    shape_geog,
    shape_length
from septa_bus_route_with_longest_trip
order by shape_length desc
limit 2
