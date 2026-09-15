SELECT
    SUPPLIER_ID,
    SUPPLIER_NAME,
    CONTACT_EMAIL,
    CONTACT_PHONE,
    UPDATED_AT
FROM {{ ref('stg_suppliers') }}