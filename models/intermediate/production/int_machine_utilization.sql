WITH production AS (

    SELECT
        MACHINE_ID,

        SUM(QUANTITY) AS TOTAL_PRODUCTION_QUANTITY,

        COUNT(DISTINCT TO_DATE(START_DATE))
            AS PRODUCTION_DAYS

    FROM {{ ref('stg_production_orders') }}

    GROUP BY MACHINE_ID

),

machines AS (

    SELECT
        MACHINE_ID,
        MACHINE_TYPE,
        CAPACITY_PER_DAY,
        LAST_MAINTENANCE_DATE,
        STATUS

    FROM {{ ref('stg_machines') }}

)

SELECT

    m.MACHINE_ID,
    m.MACHINE_TYPE,
    m.CAPACITY_PER_DAY,
    m.LAST_MAINTENANCE_DATE,
    m.STATUS,

    COALESCE(
        p.TOTAL_PRODUCTION_QUANTITY,
        0
    ) AS TOTAL_PRODUCTION_QUANTITY,

    COALESCE(
        p.PRODUCTION_DAYS,
        0
    ) AS PRODUCTION_DAYS,

    CASE
        WHEN p.PRODUCTION_DAYS > 0
        THEN
            p.TOTAL_PRODUCTION_QUANTITY
            / p.PRODUCTION_DAYS
        ELSE 0
    END AS AVERAGE_DAILY_PRODUCTION,

    CASE
        WHEN m.CAPACITY_PER_DAY > 0
             AND p.PRODUCTION_DAYS > 0
        THEN
            (
                (
                    p.TOTAL_PRODUCTION_QUANTITY
                    / p.PRODUCTION_DAYS
                )
                / m.CAPACITY_PER_DAY
            ) * 100
        ELSE 0
    END AS CAPACITY_UTILIZATION_PCT

FROM machines m

LEFT JOIN production p
    ON m.MACHINE_ID = p.MACHINE_ID