# Week 1 Project Submission

## Task 1

### Setup

[`gitpod.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/.gitpod.yml)
[`.sqlfluff`](https://github.com/rrailton/course_advanced_dbt/blob/main/.sqlfluff)
[`dbt_project.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/dbt_project.yml)
[`packages.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/packages.yml)
[`Pipfile`](https://github.com/rrailton/course_advanced_dbt/blob/main/Pipfile)

- Setup was pretty smooth, also set up the project evaluator, on-run-end hook and sqlfluff
- Took me a while to figure out how to push to remote due to my email privacy settings in github, solved this by modifying the `gitpod.yml` file by adding a `gitConfig user.email`

## Task 2

### Docs Blocks

[`docs_bingeflix.md`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/docs/docs_bingeflix.md)

- Added table docs blocks for all the Bingeflix sources and populated downstream
- Added column docs blocks for events and populated downstream

### Bonus Task

[`dbt_project.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/dbt_project.yml)

- Hid the nodes for dbt project evaluator models
- Changed the node colors for staging, intermediate and marts models

## Task 3

### dbt_project_evaluator

[`docs_ads_platform.md`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/docs/docs_ads_platform.md)
[`fct_events.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/marts/core/fct_events.yml)
[`fct_mrr.sql & fct_mrr.yml`](https://github.com/rrailton/course_advanced_dbt/tree/main/models/marts/finance)
[`dbt_project_evaluator_exceptions.csv`](https://github.com/rrailton/course_advanced_dbt/blob/main/seeds/dbt_project_evaluator_exceptions.csv)
[`source_ads_platform.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/staging/ads_platform/source_ads_platform.yml)
[`source_bingeflix.yml`](https://github.com/rrailton/course_advanced_dbt/blob/main/models/staging/bingeflix/source_bingeflix.yml)

- After running the project evaluator there were 8 warnings:
  - Fixed the 4 documentation warnings & 2 tests warnings:
    - Added `docs_ads_platform.md`, `fct_events.yml` and `source_ads_platform.yml`
      - Added a `dbt_utils.unique_combination_of_columns` test in `source_ads_platform.yml` to mimic the surrogate key downstream
  - Fixed the 1 structure warning:
    - Renamed `mrr.sql` and `mrr.yml` files to `fct_mrr.sql` and `fct_mrr.yml` and updated references
    - Also decided to rename `int_sessions_pivoted_to_event_names` to `int_session_events`
  - Fixed the 1 dag warning:
    - Added `stg_bingeflix__events` to `dbt_project_evaluator_exceptions.csv`
- Ran the project evaluator again and got source freshness warnings
  - Added freshness properties to source yml files

## Task 4

### SQLfluff

[`.sqlfluff`](https://github.com/rrailton/course_advanced_dbt/blob/main/.sqlfluff)
[`.sqlfluffignore`](https://github.com/rrailton/course_advanced_dbt/blob/main/.sqlfluffignore)

- Added capitalization config in `.sqlfluff` to make identifiers, keywords, functions, literals and datatypes uppercase
- Added `tests` to `.sqlfluffignore`
- Ran sqlfluff fix
