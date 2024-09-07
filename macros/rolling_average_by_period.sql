{% macro rolling_average_by_period(column_name, partition_by, order_by='created_at', preceding_periods='6') %}
    avg( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{ preceding_periods }} PRECEDING AND CURRENT ROW
            )
{% endmacro %}
