SELECT
    INVENTORY_ID,
    PRODUCT_ID,
    WAREHOUSE_ID,
    QUANTITY,
    REORDER_LEVEL,
    LAST_UPDATED,

    STOCK_BUFFER,
    IS_LOW_STOCK,
    IS_OVERSTOCK,
    INVENTORY_STATUS

FROM {{ ref('int_inventory_alerts') }}