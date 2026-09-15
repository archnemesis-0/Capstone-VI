WITH source AS (

    SELECT *
    FROM {{ source('src', 'RAW_MACHINES') }}

),

cleaned AS (

    SELECT
        TRIM(MACHINE_ID) AS MACHINE_ID,
        TRIM(MACHINE_TYPE) AS MACHINE_TYPE,
        CAPACITY_PER_DAY,
        LAST_MAINTENANCE_DATE,
        TRIM(STATUS) AS STATUS
    FROM source

)

SELECT *
FROM cleaned