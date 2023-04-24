{% test ts_before_another_ts(model, column_name, timestamp_after) %}


   select *
   from {{ model }}
   where {{ timestamp_before }} <= {{ timestamp_after }}


{% endtest %}
