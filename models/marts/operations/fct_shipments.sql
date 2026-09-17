SELECT
    SHIPMENT_ID,
    PRODUCT_ID,
    WAREHOUSE_ID,
    QUANTITY,
    SHIPMENT_DATE,
    DELIVERY_DATE,
    STATUS,

    DATEDIFF(
        'day',
        SHIPMENT_DATE,
        DELIVERY_DATE
    ) AS DELIVERY_DAYS

FROM {{ ref('stg_shipments') }}