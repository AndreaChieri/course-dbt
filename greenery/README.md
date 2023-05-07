Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices








save for later
{% macro conversion_rate(dimension_1) %}

{% if {{dimension_1}}::str IS NULL %}
    WITH by_session AS (
        SELECT events_session_id
            , MAX(view_became_order) AS order_bool
        FROM {{ref('stg_events')}}
        GROUP BY 1
    )

    SELECT SUM(CASE WHEN order_bool = TRUE THEN 1 ELSE 0 END) / COUNT(events_session_id) AS conversion_rate
    FROM by_session

{% else %}
    WITH by_session_dimension_1 AS (
        SELECT events_session_id
            , {{dimension_1}}
            , MAX(view_became_order) AS order_bool
        FROM {{ref('stg_events')}}
        GROUP BY 1,2
    )

    SELECT {{dimension_1}}
    , SUM(CASE WHEN order_bool = TRUE THEN 1 ELSE 0 END) / COUNT(events_session_id) AS conversion_rate
    , SUM(CASE WHEN order_bool = TRUE THEN 1 ELSE 0 END) as num
    , COUNT(events_session_id) as den
    FROM by_session_product
    GROUP BY 1
    ORDER BY 2 DESC
{% endif %}

{% endmacro %}