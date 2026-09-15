WITH production AS (

    SELECT *
    FROM {{ ref('stg_production_orders') }}

),

metrics AS (

    SELECT
        PRODUCTION_ORDER_ID,
        PRODUCT_ID,
        MACHINE_ID,
        QUANTITY,
        START_DATE,
        END_DATE,
        STATUS,

        -- Production date and month
        TO_DATE(START_DATE) AS PRODUCTION_DATE,
        DATE_TRUNC('MONTH', START_DATE) AS PRODUCTION_MONTH,

        -- Duration of the production order
        DATEDIFF(
            'hour',
            START_DATE,
            END_DATE
        ) AS PRODUCTION_DURATION_HOURS,

        -- Production rate
        CASE
            WHEN DATEDIFF('hour', START_DATE, END_DATE) > 0
            THEN
                QUANTITY /
                DATEDIFF('hour', START_DATE, END_DATE)
            ELSE NULL
        END AS PRODUCTION_RATE_PER_HOUR,

        -- Completion flag
        CASE
            WHEN UPPER(STATUS) = 'COMPLETED'
            THEN 1
            ELSE 0
        END AS IS_COMPLETED,

        -- Status flags
        CASE
            WHEN UPPER(STATUS) = 'IN PROGRESS'
            THEN 1
            ELSE 0
        END AS IS_IN_PROGRESS,

        CASE
            WHEN UPPER(STATUS) = 'CANCELLED'
            THEN 1
            ELSE 0
        END AS IS_CANCELLED

    FROM production

)

SELECT *
FROM metrics