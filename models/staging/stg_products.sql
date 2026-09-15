WITH source AS (

    SELECT *
    FROM {{ source('src', 'RAW_PRODUCTS') }}

),

cleaned AS (

    SELECT
        TRIM(PRODUCT_ID) AS PRODUCT_ID,
        TRIM(NAME) AS PRODUCT_NAME,
        TRIM(CATEGORY) AS CATEGORY,
        SUPPLIER_ID,
        PRICE,
        WEIGHT_KG,
        CREATED_AT
    FROM source

)

SELECT *
FROM cleaned