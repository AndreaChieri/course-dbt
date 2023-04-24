{{
  config(
    materialized='view'
  )
}}

SELECT
  address_id AS addresses_address_id
  , address
  , zipcode 
  , state
  , country
FROM {{ source('postgres', 'addresses') }}
