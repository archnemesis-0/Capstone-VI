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
        TO_DATE(START_DATE) AS START_DATE,
        TO_DATE(END_DATE) AS END_DATE,
        TRIM(STATUS) AS STATUS
    FROM source

)

SELECT *
FROM cleaned