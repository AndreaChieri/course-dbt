{{
  config(
    materialized='view'
  )
}}

SELECT
  order_id AS orders_order_id
  , user_id AS orders_user_id
  , promo_id AS orders_promo_id
  , address_id AS orders_address_id
  , created_at AS orders_created_at
  , order_cost AS orders_order_cost
  , shipping_cost AS orders_shipping_cost
  , order_total AS orders_order_total
  , tracking_id AS orders_tracking_id
  , shipping_service AS orders_shipping_service
  , estimated_delivery_at AS orders_estimated_delivery_at
  , delivered_at AS orders_delivered_at
  , status AS orders_status
FROM {{ source('postgres', 'orders') }}