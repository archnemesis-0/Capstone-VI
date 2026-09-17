WITH inventory AS (

    SELECT
        INVENTORY_ID,
        PRODUCT_ID,
        WAREHOUSE_ID,
        QUANTITY,
        REORDER_LEVEL,
        LAST_UPDATED
    FROM {{ ref('stg_inventory') }}

),

alerts AS (

    SELECT
        INVENTORY_ID,
        PRODUCT_ID,
        WAREHOUSE_ID,
        QUANTITY,
        REORDER_LEVEL,
        LAST_UPDATED,

        QUANTITY - REORDER_LEVEL AS STOCK_BUFFER,

        CASE
            WHEN QUANTITY < REORDER_LEVEL
            THEN 1
            ELSE 0
        END AS IS_LOW_STOCK,

        CASE
            WHEN QUANTITY > (REORDER_LEVEL * 2)
            THEN 1
            ELSE 0
        END AS IS_OVERSTOCK,

        CASE
            WHEN QUANTITY < REORDER_LEVEL
                THEN 'LOW_STOCK'

            WHEN QUANTITY > (REORDER_LEVEL * 2)
                THEN 'OVERSTOCK'

            ELSE 'NORMAL'
        END AS INVENTORY_STATUS

    FROM inventory

)

SELECT *
FROM alerts