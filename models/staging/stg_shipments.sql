WITH source AS (

    SELECT *
    FROM {{ source('src', 'RAW_SHIPMENTS') }}

),

cleaned AS (

    SELECT
        TRIM(SHIPMENT_ID) AS SHIPMENT_ID,
        TRIM(PRODUCT_ID) AS PRODUCT_ID,
        TRIM(WAREHOUSE_ID) AS WAREHOUSE_ID,
        QUANTITY,
        TO_DATE(SHIPMENT_DATE) AS SHIPMENT_DATE,
        TO_DATE(DELIVERY_DATE) AS DELIVERY_DATE,
        TRIM(STATUS) AS STATUS
    FROM source

)

SELECT *
FROM cleaned