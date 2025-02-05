with 

source as (

    select * from {{ source('staging', 'YELLOW_TRIP_DATA_2024_09') }}

),

renamed as (

    select
        vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count,
        trip_distance,
        ratecodeid,
        store_and_fwd_flag,
        pulocationid,
        dolocationid,
        payment_type,
        fare_amount,
        {{ dbt_utils.width_bucket('fare_amount', 0, 1400, 10) }} as fare_amount_buckets,
        extra,
        mta_tax,
        tip_amount,
        {{ get_tip_ind_cd('tip_amount') }} as tip_ind_cd,
        tolls_amount,
        {{ get_tolls_ind_cd('tolls_amount')}} as toll_ind_cd,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee

    from source

)

select * from renamed
