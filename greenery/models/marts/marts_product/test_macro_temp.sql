{{
    config(
        materialized='view'
    )
}}

{{event_type_by_session()}}