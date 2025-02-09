{% macro get_tolls_ind_cd(tolls_amount) -%}

case
    when tolls_amount > 0 then 1
    else 0
end

{%- endmacro %}