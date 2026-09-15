SELECT
    MACHINE_ID,
    MACHINE_TYPE,
    CAPACITY_PER_DAY,
    LAST_MAINTENANCE_DATE,
    STATUS

FROM {{ ref('stg_machines') }}