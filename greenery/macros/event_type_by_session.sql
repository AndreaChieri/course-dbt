{% macro event_type_by_session() %}

    SELECT events_session_id
        , events_event_type
        , COUNT(events_event_id) AS count_events
    FROM {{ref('stg_events')}}
    GROUP BY events_session_id
        , events_event_type

{% endmacro %}