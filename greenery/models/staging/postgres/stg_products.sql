{{
  config(
    materialized='view'
  )
}}

SELECT
  product_id AS products_product_id
  , name
  , price 
  , inventory
FROM {{ source('postgres', 'products') }}