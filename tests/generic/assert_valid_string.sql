-- This returns records where the column_name contains 'string', using ILIKE makes this test case insensitive

{% test assert_valid_string(model, column_name, string) %}

SELECT *
FROM {{ model }}
WHERE {{ column_name }} ILIKE '%{{ string }}%'

{% endtest %}
