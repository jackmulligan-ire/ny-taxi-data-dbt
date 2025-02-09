{{
    config(
        materialized='table'
    )
}}

with green_tripdata as (
    select *
    , 'GREEN' as TYPE_CD
    from {{ ref('stg_green_tripdata') }}
)
, yellow_tripdata as (
    select *
    , 'YELLOW-GREEN' as TYPE_CD
    from {{ ref('stg_yellow_tripdata') }}
)
, dim_zones as (
    select *
    from {{ ref('dim_zones') }}
    where 1 = 1
    and borough != 'Unknown'
)
, all_tripdata as (
    select * from yellow_tripdata
    UNION ALL
    select * from green_tripdata
)
select all_tripdata.tripid, 
    all_tripdata.vendorid, 
    all_tripdata.type_cd,
    all_tripdata.ratecodeid, 
    all_tripdata.pickup_locationid, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    all_tripdata.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    all_tripdata.pickup_datetime, 
    all_tripdata.dropoff_datetime, 
    all_tripdata.store_and_fwd_flag, 
    all_tripdata.passenger_count, 
    all_tripdata.trip_distance, 
    all_tripdata.trip_type, 
    all_tripdata.fare_amount, 
    all_tripdata.extra, 
    all_tripdata.mta_tax, 
    all_tripdata.tip_amount, 
    all_tripdata.tip_ind_cd, 
    all_tripdata.tolls_amount, 
    all_tripdata.tolls_ind_cd,
    all_tripdata.ehail_fee, 
    all_tripdata.improvement_surcharge, 
    all_tripdata.total_amount, 
    all_tripdata.payment_type
from all_tripdata
inner join dim_zones as pickup_zone
on all_tripdata.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on all_tripdata.dropoff_locationid = dropoff_zone.locationid
