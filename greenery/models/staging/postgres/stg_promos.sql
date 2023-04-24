{{
  config(
    materialized='view'
  )
}}

SELECT
  promo_id AS promos_promo_id
  , discount
  , status 
FROM {{ source('postgres', 'promos') }}