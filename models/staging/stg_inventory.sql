WITH source AS (

    SELECT *
    FROM {{ source('src', 'RAW_INVENTORY') }}

),

cleaned AS (

    SELECT
        TRIM(INVENTORY_ID) AS INVENTORY_ID,
        TRIM(PRODUCT_ID) AS PRODUCT_ID,
        TRIM(WAREHOUSE_ID) AS WAREHOUSE_ID,
        QUANTITY,
        REORDER_LEVEL,
        LAST_UPDATED
    FROM source

)

SELECT *
FROM cleaned