# Week 3 Project Submission

## Task 1

### Identify a few redundant tests that can be removed

[`fct_events.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/core/fct_events.yml)
[`dim_users.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/core/dim_users.yml)
[`dim_subscriptions.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/core/dim_subscriptions.yml)
[`READ_ME.md`](https://github.com/rrailton/course_advanced_dbt/blob/main/README.md)

1. Identify and remove at least 3 redundant tests from the project
   - Removed non-null tests in `fct_events.yml`
      - Left tests on primary key
   - Removed non-null tests in `dim_users.yml`
      - Left tests on `current_age`, `age_at_aquisition`, primary key and join key
   - Removed non_null tests in `dim_subscriptions.yml`
      - Left tests on primary key and join key
2. Provide a short explanation in your project submission for how/why you identified which tests to remove
   - I removed non-null tests in core models because they are already present in staging tables
   - I used the lineage view (power user for dbt extension) and opened models and yml side by side in vscode to compare the sql logic and tests
3. Update the testing conventions listed in the `READ_ME.md` file to document the new testing conventions the BingeFlix team should use
   - I added section about not creating duplicate test on models when they are present in staging models and only need to test where there are transformations

## Task 2

### Write a custom generic test to replace a redundant singular test

[`assert_valid_string.sql`](https://github.com/rrailton/course_advanced_dbt/blob/main/tests/generic/assert_valid_string.sql)
[`stg_bingeflix__events.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/staging/bingeflix/stg_bingeflix__events.yml)

- Created `assert_valid_string.sql`
- Applied it to `stg_bingeflix__events`

## Task 3

### Write a unit test to verify the logic of a transformation

[`dim_users.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/core/dim_users.yml)

- Added unit test `test_age_is_correct` to `dim_users.yml`

## Task 4

### Practice writing a more complex unit test, to confirm MRR is calculated correctly

[`mrr_current_datetime.sql`](https://github.com/rrailton/course_advanced_dbt/blob/main/macros/mrr_current_datetime.sql)
[`mrr_current_datetime.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/macros/mrr_current_datetime.yml)
[`fct_mrr.sql`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/finance/fct_mrr.sql)
[`fct_mrr.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/finance/fct_mrr.yml)

- Created `mrr_current_datetime.sql` macro to replace `CURRENT_DATE` in `fct_mrr.sql`
- Added the macro calls to `fct_mrr.sql`
- Created the unit test `mrr_calculation_is_correct` in `fct_mrr.yml`
  - Added a macro override config to the new unit test to hardcode the date for the test
