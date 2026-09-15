WITH source AS (

    SELECT *
    FROM {{ source('src', 'RAW_SUPPLIERS') }}

),

cleaned AS (

    SELECT
        TRIM(SUPPLIER_ID) AS SUPPLIER_ID,
        TRIM(NAME) AS SUPPLIER_NAME,
        TRIM(CONTACT_EMAIL) AS CONTACT_EMAIL,
        TRIM(CONTACT_PHONE) AS CONTACT_PHONE,
        UPDATED_AT
    FROM source

)

SELECT *
FROM cleaned