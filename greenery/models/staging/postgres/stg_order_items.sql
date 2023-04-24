{{
  config(
    materialized='view'
  )
}}

SELECT
  order_id AS order_items_order_id
  , product_id AS order_items_product_id
  , quantity AS order_items_quantity
FROM {{ source('postgres', 'order_items') }}
