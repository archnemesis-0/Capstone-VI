SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    SUPPLIER_ID,
    PRICE,
    WEIGHT_KG,
    CREATED_AT
FROM {{ ref('stg_products') }}