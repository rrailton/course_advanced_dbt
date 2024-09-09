# Week 2 Project Submission

## Task 1 & Task 2

### Install pre-commit, add SQLFluff and dbt-checkpoint to pre-commit

[`Pipfile`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/Pipfile)
[`.pre-commit-config.yaml`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/.pre-commit-config.yaml)
[`dim_users.yml`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/models/marts/core/dim_users.yml)

- Installed pre-commit
- Added hooks to config:
  - pre-commit-hooks
  - SQLFluff hooks
    - Modified a file to add a leading comma to check the hook was working
  - dbt_checkpoint hooks
    - Added additional check-model-tags hook
    - Fixed check-model-has-all-columns by adding missing columns to the `dim_users.yml`

## Task 3

### Generalize a custom macro

[`rolling_average_7_periods.sql`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/rolling_average_7_periods.sql)
[`rolling_aggregation_by_period.sql`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/rolling_aggregation_by_period.sql)
[`rolling_aggregation_by_period.yml`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/rolling_aggregation_by_period.yml)
[`fct_monthly_active_users.sql`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/models/marts/product/fct_monthly_active_users.sql)
[`fct_monthly_active_users.yml`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/models/marts/product/fct_monthly_active_users.yml)

- Copied and generalized the `rolling_average_7_periods.sql` macro, creating `rolling_aggregation_by_period.sql`
  - Created `rolling_aggregation_by_period.yml` for new macro
- Created new model `fct_monthly_active_users.sql` to apply the new generalized macro
  - Created `fct_monthly_active_users.yml` for new model

## Task 4

### Write a custom macro to improve another part of the codebase

[`add_months.sql`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/add_months.sql)
[`add_months.yml`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/add_months.yml)
[`trunc_month.sql`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/trunc_month.sql)
[`trunc_month.yml`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/trunc_month.yml)
[`lagged_value.sql`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/lagged_value.sql)
[`lagged_value.yml`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/macros/lagged_value.yml)
[`fct_mrr.sql`](https://github.com/rrailton/course_advanced_dbt/blob/project/main/models/marts/finance/fct_mrr.sql)

- Added three new macros `add_months.sql`, `trunc_month.sql` and `lagged_value.sql` with yml files
- Applied the new macros to `fct_mrr.sql`
