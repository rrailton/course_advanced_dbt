{% macro trunc_month(date_field) %}
    DATE_TRUNC('month', {{ date_field }})
{% endmacro %}
