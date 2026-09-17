WITH suppliers AS (

    SELECT
        SUPPLIER_ID,
        SUPPLIER_NAME
    FROM {{ ref('stg_suppliers') }}

),

products AS (

    SELECT
        PRODUCT_ID,
        SUPPLIER_ID
    FROM {{ ref('stg_products') }}

),

shipments AS (

    SELECT
        SHIPMENT_ID,
        PRODUCT_ID,
        QUANTITY,
        SHIPMENT_DATE,
        DELIVERY_DATE,
        STATUS
    FROM {{ ref('stg_shipments') }}

),

supplier_shipments AS (

    SELECT
        s.SUPPLIER_ID,
        s.SUPPLIER_NAME,
        sh.SHIPMENT_ID,
        sh.QUANTITY,
        sh.SHIPMENT_DATE,
        sh.DELIVERY_DATE,
        sh.STATUS
    FROM suppliers s
    LEFT JOIN products p
        ON s.SUPPLIER_ID = p.SUPPLIER_ID
    LEFT JOIN shipments sh
        ON p.PRODUCT_ID = sh.PRODUCT_ID

),

performance AS (

    SELECT
        SUPPLIER_ID,
        SUPPLIER_NAME,

        COUNT(DISTINCT SHIPMENT_ID) AS TOTAL_SHIPMENTS,

        COALESCE(SUM(QUANTITY), 0) AS TOTAL_SHIPPED_QUANTITY,

        COUNT(
            DISTINCT CASE
                WHEN UPPER(STATUS) = 'DELIVERED'
                THEN SHIPMENT_ID
            END
        ) AS DELIVERED_SHIPMENTS,

        COUNT(
            DISTINCT CASE
                WHEN UPPER(STATUS) = 'IN TRANSIT'
                THEN SHIPMENT_ID
            END
        ) AS IN_TRANSIT_SHIPMENTS,

        AVG(
            CASE
                WHEN DELIVERY_DATE IS NOT NULL
                     AND SHIPMENT_DATE IS NOT NULL
                     AND DELIVERY_DATE >= SHIPMENT_DATE
                THEN DATEDIFF(
                    'day',
                    SHIPMENT_DATE,
                    DELIVERY_DATE
                )
            END
        ) AS AVERAGE_DELIVERY_DAYS

    FROM supplier_shipments

    GROUP BY
        SUPPLIER_ID,
        SUPPLIER_NAME

)

SELECT
    SUPPLIER_ID,
    SUPPLIER_NAME,
    TOTAL_SHIPMENTS,
    TOTAL_SHIPPED_QUANTITY,
    DELIVERED_SHIPMENTS,
    IN_TRANSIT_SHIPMENTS,
    AVERAGE_DELIVERY_DAYS,

    CASE
        WHEN TOTAL_SHIPMENTS > 0
        THEN (DELIVERED_SHIPMENTS / TOTAL_SHIPMENTS) * 100
        ELSE 0
    END AS DELIVERY_COMPLETION_RATE_PCT

FROM performance