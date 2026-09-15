{% snapshot product_scd %}

{{
    config(
        target_schema='MARTS',
        unique_key='PRODUCT_ID',
        strategy='check',
        check_cols=[
            'PRODUCT_NAME',
            'CATEGORY',
            'SUPPLIER_ID',
            'PRICE',
            'WEIGHT_KG'
        ]
    )
}}

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    SUPPLIER_ID,
    PRICE,
    WEIGHT_KG,
    CREATED_AT
FROM {{ ref('stg_products') }}

{% endsnapshot %}