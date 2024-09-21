# Week 4 Project Submission

## Task 1

### Create an incremental model and where clause macro

[`stg_bingeflix__events.sql`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/staging/bingeflix/stg_bingeflix__events.sql)
[`incremental_where_clause.sql`](https://github.com/rrailton/course_advanced_dbt/blob/main/macros/incremental_where_clause.sql)
[`incremental_where_clause.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/macros/incremental_where_clause.yml)

- Updated `stg_bingeflix__events.sql` to be incremental
- Created `incremental_where_clause.sql` macro with a lookback window and added the macro call to the incremental model

## Task 2

### Add dbt-snowflake-monitoring package to monitor Snowflake costs

[`packages.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/packages.yml)
[`dbt_project.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/dbt_project.yml)

- Installed `dbt_snowflake_monitoring` package and added dispatch and query-comment config to the `dbt_project.yml`

### Cost Queries & Results

#### 1. top_5_costliest_queries_last_30_days query

```sql
with
max_date as (
    select max(date(end_time)) as date
    from dev.dbt_user.query_history_enriched -- replace user with your user name
)
select
    md5(query_history_enriched.query_text_no_comments) as query_signature,
    any_value(query_history_enriched.query_text) as query_text,
    sum(query_history_enriched.query_cost) as total_cost_last_30d,
    total_cost_last_30d*12 as estimated_annual_cost,
    max_by(warehouse_name, start_time) as latest_warehouse_name,
    max_by(warehouse_size, start_time) as latest_warehouse_size,
    max_by(query_id, start_time) as latest_query_id,
    avg(execution_time_s) as avg_execution_time_s,
    count(*) as num_executions
from dev.dbt_user.query_history_enriched AS query_history_enriched -- replace user with your user name
cross join max_date
where
    query_history_enriched.start_time >= dateadd('day', -30, max_date.date)
    and query_history_enriched.start_time < max_date.date -- don't include partial day of data
    and user_name like '%richard%' -- replace with your name
group by 1
order by total_cost_last_30d desc
limit 5
```

#### 1. top_5_costliest_queries_last_30_days results (first row)

| QUERY_SIGNATURE       | QUERY_TEXT                                                                                                               | TOTAL_COST_LAST_30D | ESTIMATED_ANNUAL_COST | LATEST_WAREHOUSE_NAME | LATEST_WAREHOUSE_SIZE | LATEST_QUERY_ID                       | AVG_EXECUTION_TIME_S | NUM_EXECUTIONS |
|-----------------------|--------------------------------------------------------------------------------------------------------------------------|---------------------|-----------------------|-----------------------|-----------------------|---------------------------------------|----------------------|----------------|
| b630f73010fa83ac3f56669d7450d5a6 | select count(*) as failures, count(*) != 0 as should_warn, count(*) != 0 as should_error from ( select surrogate_key as unique_field, count(*) as n_records from dev.dbt_user_finance.fct_mrr where surrogate_key is not null group by surrogate_key having count(*) > 1 ) dbt_internal_test | 0.2087975541        | 2.50557065            | TRANSFORMING           | X-Small               | 01b70ffd-0000-8d68-0000-625900d53a7a | 2.636571428571        | 14             |

#### 2. top_5_costliest_models_last_30_days query

```sql
with
max_date as (
    select max(date(end_time)) as date
    from dev.dbt_user.dbt_queries -- replace user with your user name
)
select
    dbt_queries.dbt_node_id,
    sum(dbt_queries.query_cost) as total_cost_last_30d,
    total_cost_last_30d*12 as estimated_annual_cost
from dev.dbt_user.dbt_queries AS dbt_queries -- replace user with your user name
cross join max_date
where
    dbt_queries.start_time >= dateadd('day', -30, max_date.date)
    and dbt_queries.start_time &lt; max_date.date -- don't include partial day of data
    and dbt_node_id like 'model.advanced_dbt%'
    and dbt_node_id is not null
group by 1
order by total_cost_last_30d desc
limit 5
```

#### 2. top_5_costliest_models_last_30_days results

| DBT_NODE_ID | TOTAL_COST_LAST_30D | ESTIMATED_ANNUAL_COST |
| --- | --- | --- |
| model.advanced_dbt.stg_bingeflix_events | 0.02244873258 | 0.2693847909 |
| model.advanced_dbt.dim_dates | 0.007993502428 | 0.09592202914 |
| model.advanced_dbt.mrr | 0.0002385179228 | 0.002862215074 |
| model.advanced_dbt.dim_users | 0.00006404637037 | 0.0007685564444 |
| model.advanced_dbt.int_sessionized_events | 0.00004849053358 | 0.0005818864029 |

#### 3. daily_cost_costliest_model_last_30_days query

```sql
with
max_date as (
    select max(date(end_time)) as date
    from dev.dbt_user.dbt_queries -- replace user with your user name
),

costliest_model_last_30_days as (
    select
        dbt_queries.dbt_node_id,
        sum(dbt_queries.query_cost) as total_cost_last_30d,
        total_cost_last_30d*12 as estimated_annual_cost
    from dev.dbt_user.dbt_queries AS dbt_queries -- replace user with your user name
    cross join max_date
    where
        dbt_queries.start_time >= dateadd('day', -30, max_date.date)
        and dbt_queries.start_time &lt; max_date.date -- don't include partial day of data
        and dbt_node_id like 'model.advanced_dbt%'
        and dbt_node_id is not null
    group by 1
    order by total_cost_last_30d desc
    limit 1
)

select
    dbt_node_id,
    date(start_time) as date,
    sum(query_cost) as cost
from dev.dbt_user.dbt_queries -- replace user with your user name
where dbt_node_id = (select dbt_node_id from costliest_model_last_30_days)
group by 1,2
order by 2 desc
```

#### 3. daily_cost_costliest_model_last_30_days results

| DBT_NODE_ID | DATE | COST |
| --- | --- | --- |
| model.advanced_dbt.stg_bingeflix_events | 2024-09-04 | 0.02244873258 |
| model.advanced_dbt.stg_bingeflix_events | 2024-08-09 | 0.004101631373 |
| model.advanced_dbt.stg_bingeflix_events | 2024-02-04 | 0.003684686962 |
| model.advanced_dbt.stg_bingeflix_events | 2023-12-28 | 0.01014243657 |

## Task 3

### Refactor `mrr.sql` to proactively avoid a modelneck

[`fact_mrr.sql`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/finance/fct_mrr.sql)
[`fact_mrr.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/finance/fct_mrr.yml)
[`int_subscription_periods.sql`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/intermediate/int_subscription_periods.sql)
[`int_subscription_periods.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/intermediate/int_subscription_periods.yml)

- Refactored `fct_mrr.sql` by creating `int_subscription_periods.sql` and updating references in `fct_mrr.sql`
- Updated unit test `mrr_calculation_is_correct` in `fact_mrr.yml` to work with `int_subscription_periods`
