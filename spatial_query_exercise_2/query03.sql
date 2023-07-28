with

parcels_with_closest_bus_stop as (
    select
        parcel.address as parcel_address,
        parcel.geog as parcel_geog,
        bus_stop.stop_name as stop_name,
        bus_stop.geog as stop_geog,
        st_distance(parcel.geog, bus_stop.geog) as distance
    from phl.pwd_parcels as parcel
    cross join lateral (
        select
            bus_stop.stop_name,
            bus_stop.geog
        from septa.bus_stops as bus_stop
        order by parcel.geog <-> bus_stop.geog
        limit 1
    ) as bus_stop
)

select *
from parcels_with_closest_bus_stop
order by distance desc
