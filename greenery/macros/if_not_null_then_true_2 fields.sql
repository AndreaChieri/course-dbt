{% macro if_not_null_then_true_2_fields(field1,field2) %}

CASE WHEN {{field1}} IS NOT NULL AND {{field2}} IS NOT NULL THEN TRUE ELSE FALSE END

{% endmacro %}