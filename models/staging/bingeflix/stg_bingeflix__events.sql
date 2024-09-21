{{
    config(
        materialized='incremental',
        unique_key='event_id'
    )
}}

WITH source AS (

    SELECT
        session_id,
        created_at,
        user_id,
        event_name,
        event_id
    FROM {{ source('bingeflix', 'events') }}

{{ incremental_where_clause() }}

)

SELECT * FROM source
