How many users do we have? --> 130 unique users
    SELECT COUNT(DISTINCT user_id)
    FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.stg_users


On average, how many orders do we receive per hour? --> 7.53 orders per hours

    WITH min_max_count_created_at AS (
        SELECT MIN(created_at) AS min_created_at
            , MAX(created_at) AS max_created_at
            , COUNT(DISTINCT order_id) AS count_orders
        FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.stg_orders
    )

    SELECT min_created_at, max_created_at, count_orders
        , (EXTRACT(EPOCH FROM max_created_at) - EXTRACT(EPOCH FROM min_created_at))/3600 AS hours
        , count_orders / ((EXTRACT(EPOCH FROM max_created_at) - EXTRACT(EPOCH FROM min_created_at))/3600) AS average_orders_per_hours
    FROM min_max_count_created_at

On average, how long does an order take from being placed to being delivered? --> 3.89 days
    SELECT AVG(EXTRACT(EPOCH FROM delivered_at)- EXTRACT(EPOCH FROM created_at))/3600/24 AS avg_order_lt
    FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.stg_orders
    WHERE delivered_at IS NOT NULL

How many users have only made one purchase? Two purchases? Three+ purchases? --> 1 order: 25 users. 2 orders: 28 users. 3+ orders: 71 users.

    WITH count_orders_by_user AS (
        SELECT user_id
            , COUNT(order_id) AS count_orders
        FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.stg_orders
        group by user_id
    )

    , count_orders_by_user_adjusted_3plus AS (
        SELECT user_id
            , CASE WHEN count_orders>2 THEN '3+' ELSE CAST(count_orders AS STRING) END AS count_orders_grouped
        FROM count_orders_by_user
    )

    SELECT count_orders_grouped
        , count(user_id) AS count_of_users
    FROM count_orders_by_user_adjusted_3plus
    GROUP BY count_orders_grouped
    ORDER BY count_orders_grouped ASC

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour? 00> 10.13 sessions per hour
    WITH min_max_count_created_at AS (
        SELECT MIN(created_at) AS min_created_at
            , MAX(created_at) AS max_created_at
            , COUNT(DISTINCT session_id) AS count_sessions
        FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.stg_events
    )

    SELECT min_created_at, max_created_at, count_sessions
        , (EXTRACT(EPOCH FROM max_created_at) - EXTRACT(EPOCH FROM min_created_at))/3600 AS hours
        , count_sessions / ((EXTRACT(EPOCH FROM max_created_at) - EXTRACT(EPOCH FROM min_created_at))/3600) AS average_sessions_per_hours
    FROM min_max_count_created_at

