WITH source AS (

    SELECT *
    FROM {{ source('src', 'RAW_PRODUCTION_ORDERS') }}

),

cleaned AS (

    SELECT
        TRIM(PRODUCTION_ORDER_ID) AS PRODUCTION_ORDER_ID,
        TRIM(PRODUCT_ID) AS PRODUCT_ID,
        TRIM(MACHINE_ID) AS MACHINE_ID,
        QUANTITY,
        START_DATE,
        END_DATE,
        TRIM(STATUS) AS STATUS
    FROM source

)

SELECT *
FROM cleaned