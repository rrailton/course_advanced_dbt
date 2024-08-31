
# Bingeflix Docs

This file contains documentation for Bingeflix data sources.

{% docs source_bingeflix %}
This source contains tables from the Bingeflix production database.
{% enddocs %}

## Events

This section contains documentation from the Bingeflix Events table.

{% docs table_bingeflix__events %}
This table contains information about the behavioral events of users while they interact with the Bingeflix platform.
{% enddocs %}

{% docs bingeflix_events_column_session_id %}
The unique identifier of the session in the Bingeflix application.
{% enddocs %}

{% docs bingeflix_events_column_created_at %}
When the event was logged.
{% enddocs %}

{% docs bingeflix_events_column_event_name %}
The name of the event.
{% enddocs %}

{% docs bingeflix_events_column_event_id %}
The unique identifier of the event.
{% enddocs %}

## Subscription Plans

This section contains documentation from the Bingeflix Subscription Plans table.

{% docs table_bingeflix__subscription_plans %}
This table contains information about various subscription plans available on Bingeflix.
{% enddocs %}

## Subscriptions

This section contains documentation from the Bingeflix Subscriptions table.

{% docs table_bingeflix__subscriptions %}
This model contains information about Bingeflix subscriptions.
{% enddocs %}

## Users

This section contains documentation from the Bingeflix Users table.

{% docs table_bingeflix__users %}
This is table contains information about Bingeflix users.
{% enddocs %}

{% docs bingeflix_users_column_user_id %}
The unique identifier of the Bingeflix user.
{% enddocs %}
