{{
  config(
    materialized='view'
  )
}}

SELECT
  event_id AS events_event_id
  , session_id AS events_session_id
  , user_id AS events_user_id
  , page_url AS events_page_url
  , created_at AS events_created_at
  , event_type AS events_event_type
  , order_id AS events_order_id
  , product_id AS events_product_id
FROM {{ source('postgres', 'events') }}
