{% macro get_tip_ind_cd(tip_amount) -%}

case
    when tip_amount > 0 then 1
    else 0
end

{%- endmacro %}