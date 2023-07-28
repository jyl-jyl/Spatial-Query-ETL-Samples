#!/bin/env bash

set -e
set -x

SCRIPTDIR=$(readlink -f $(dirname $0))
DATADIR=$(readlink -f $(dirname $0)/../__data__)
mkdir -p ${DATADIR}

# Download and unzip trip data
curl -L https://bicycletransit.wpenginepowered.com/wp-content/uploads/2022/12/indego-trips-2022-q3.zip > ${DATADIR}/indego-trips-2022-q3.zip
unzip -o ${DATADIR}/indego-trips-2022-q3.zip -d ${DATADIR}

curl -L https://bicycletransit.wpenginepowered.com/wp-content/uploads/2021/10/indego-trips-2021-q3.zip > ${DATADIR}/indego-trips-2021-q3.zip
unzip -o ${DATADIR}/indego-trips-2021-q3.zip -d ${DATADIR}

# Create database and initialize table structure
PGPASSWORD=postgres createdb \
  -h localhost \
  -p 5432 \
  -U postgres \
  musa_509
PGPASSWORD=postgres psql \
  -h localhost \
  -p 5432 \
  -U postgres \
  -d musa_509 \
  -f "${SCRIPTDIR}/create_trip_tables.sql"

# Load trip data into database
PGPASSWORD=postgres psql \
  -h localhost \
  -p 5432 \
  -U postgres \
  -d musa_509 \
  -c "\copy indego.trips_2021_q3 FROM '${DATADIR}/indego-trips-2021-q3.csv' DELIMITER ',' CSV HEADER;"
PGPASSWORD=postgres psql \
  -h localhost \
  -p 5432 \
  -U postgres \
  -d musa_509 \
  -c "\copy indego.trips_2022_q3 FROM '${DATADIR}/indego-trips-2022-q3.csv' DELIMITER ',' CSV HEADER;"

# Download and load station data into database
curl -L http://www.rideindego.com/stations/json/ > ${DATADIR}/indego-station-statuses.geojson
ogr2ogr \
  -f "PostgreSQL" \
  -nln "indego.station_statuses" \
  -lco "OVERWRITE=yes" \
  -lco "GEOM_TYPE=geography" \
  -lco "GEOMETRY_NAME=geog" \
  PG:"host=localhost port=5432 dbname=musa_509 user=postgres password=postgres" \
  ${DATADIR}/indego-station-statuses.geojson
