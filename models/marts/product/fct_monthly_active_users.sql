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
        {{ rolling_average_by_period(
            'active_user_count',
            'date_year || date_quarter',
            'date_month',
            '2'
        ) }} AS avg_quarterly_active_users
    FROM monthly_active_users
    ORDER BY 1
)

SELECT * FROM final
