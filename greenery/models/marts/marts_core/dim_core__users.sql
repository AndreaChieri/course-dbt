{{
    config(
        materialized='table'
    )
}}

SELECT u.*
    , a.address
    , a.zipcode
    , a.state
    , a.country
FROM stg_users u
LEFT JOIN stg_addresses a
    ON u.users_address_id = a.addresses_address_id