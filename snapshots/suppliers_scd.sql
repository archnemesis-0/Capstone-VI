{% snapshot supplier_scd %}

{{
    config(
        target_schema='MARTS',
        unique_key='SUPPLIER_ID',
        strategy='check',
        check_cols=[
            'SUPPLIER_NAME',
            'CONTACT_EMAIL',
            'CONTACT_PHONE'
        ]
    )
}}

SELECT
    SUPPLIER_ID,
    SUPPLIER_NAME,
    CONTACT_EMAIL,
    CONTACT_PHONE,
    UPDATED_AT
FROM {{ ref('stg_suppliers') }}

{% endsnapshot %}