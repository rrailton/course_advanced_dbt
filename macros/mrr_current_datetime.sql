{% macro mrr_current_datetime(type='timestamp') %}
    {% if type == 'date' %}
        DATE(CURRENT_TIMESTAMP)
    {% elif type == 'timestamp' %}
        CURRENT_TIMESTAMP
    {% else %}
        {{ exceptions.raise_compiler_error("Invalid type. Must be 'date' or 'timestamp'.") }}
    {% endif %}
{% endmacro %}
