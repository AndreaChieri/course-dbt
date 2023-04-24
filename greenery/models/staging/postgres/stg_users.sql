{{
  config(
    materialized='view'
  )
}}

SELECT
  user_id AS users_user_id
  , first_name 
  , last_name
  , email
  , phone_number
  , created_at
  , updated_at
  , address_id AS users_address_id
FROM {{ source('postgres', 'users') }}