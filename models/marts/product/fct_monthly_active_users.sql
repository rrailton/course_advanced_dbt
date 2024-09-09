WITH

monthly_active_users AS (
    SELECT
        DATE_TRUNC('month', date_week) AS date_month,
        DATE_PART('quarter', date_week) AS date_quarter,
        DATE_PART('year', date_week) AS date_year,
        COUNT(DISTINCT user_id) AS active_user_count
    FROM {{ ref('fct_active_users') }}
    GROUP BY 1, 2, 3
),

final AS (
    SELECT
        date_month,
        active_user_count,
        {{ rolling_aggregation_by_period(
            column_name='active_user_count',
            partition_by='date_year || date_quarter',
            order_by='date_month',
            periods=3
        ) }} AS avg_quarterly_active_users
    FROM monthly_active_users
    ORDER BY 1
)

SELECT * FROM final
