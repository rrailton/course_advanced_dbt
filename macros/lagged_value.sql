{% macro lagged_value(field_name, partition_by, order_by, default_value=None) %}
    COALESCE(
        LAG({{ field_name }}) OVER (
            PARTITION BY {{ partition_by }}
            ORDER BY {{ order_by }}
        ),
        {{ default_value }}
    )
{% endmacro %}
