{{
    config(
        materialized='table'
    )
}}

WITH raw_orders AS (
    SELECT orders_order_id
    FROM {{ ref('stg_orders') }}
)

, raw_order_items AS (
    SELECT order_items_order_id
        , order_items_product_id
    FROM {{ ref('stg_order_items') }}
)

SELECT orders_order_id
    , order_items_product_id
FROM raw_orders AS o
LEFT JOIN raw_order_items AS oi
    ON o.orders_order_id = oi.order_items_order_id