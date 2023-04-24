{{
    config(
        materialized='table'
    )
}}

WITH int_product__page_views_with_order_id AS (
    SELECT *
    FROM {{ ref('int_product__page_views_with_order_id') }}
)

, int_product__orders_with_order_items AS (
    SELECT *
    FROM {{ ref('int_product__orders_with_order_items') }}
)

, dim_users AS (
    SELECT *
    FROM {{ ref('dim_core__users') }}
)

SELECT pv.*
    , u.*
    , CASE WHEN o.orders_order_id IS NOT NULL AND o.order_items_product_id IS NOT NULL THEN TRUE ELSE FALSE END view_became_order
FROM int_product__page_views_with_order_id AS pv
LEFT JOIN int_product__orders_with_order_items AS o ON
    pv.events_order_id = o.orders_order_id
    AND pv.events_product_id = o.order_items_product_id
LEFT JOIN stg_users AS u ON
    pv.events_user_id = u.users_user_id