{% snapshot machine_scd %}

{{
    config(
        target_schema='MARTS',
        unique_key='MACHINE_ID',
        strategy='check',
        check_cols=[
            'MACHINE_TYPE',
            'CAPACITY_PER_DAY',
            'LAST_MAINTENANCE_DATE',
            'STATUS'
        ]
    )
}}

SELECT
    MACHINE_ID,
    MACHINE_TYPE,
    CAPACITY_PER_DAY,
    LAST_MAINTENANCE_DATE,
    STATUS

FROM {{ ref('stg_machines') }}

{% endsnapshot %}