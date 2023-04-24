{{
    config(
        materialized='table'
    )
}}

WITH raw_events AS (
    SELECT *
    FROM {{ ref('stg_events') }}
)

, order_id_expanded AS (
    SELECT events_session_id
        , events_user_id
        , events_created_at
        , events_product_id
        , events_event_type
        , last_value(events_order_id) OVER (PARTITION BY events_session_id ORDER BY events_created_at ASC) AS events_order_id
    FROM raw_events
)

, page_views AS (
SELECT *
FROM order_id_expanded
WHERE events_event_type = 'page_view'
)

SELECT *
FROM page_views