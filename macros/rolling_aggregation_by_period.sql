{% macro rolling_aggregation_by_period(
    column_name,
    partition_by,
    order_by='created_at',
    periods=7,
    agg_func='avg'
) %}
    {{ agg_func }}( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{ periods - 1 }} PRECEDING AND CURRENT ROW
            )
{% endmacro %}
