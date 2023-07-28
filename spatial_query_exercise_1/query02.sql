/*
    What is the percent change in trips in Q3 2022 as compared to Q3 2021?

    Using only the tables from Q3 2021 and Q3 2022 (i.e. not directly using the
    number calculated in the previous question), find the percent change of
    number of trips in Q3 2022 as compared to 2021. Round your answer to two
    decimal places.
*/


with

trips_2022 as (
    select count(*) as cnt
    from indego.trips_2022_q3
),

trips_2021 as (
    select count(*) as cnt
    from indego.trips_2021_q3
)

select round(100.0 * (trips_2022.cnt - trips_2021.cnt) / trips_2021.cnt, 2) as perc_change
from trips_2022
cross join trips_2021
