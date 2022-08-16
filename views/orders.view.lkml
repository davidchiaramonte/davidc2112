view: orders {
  sql_table_name: `orders.orders`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
    description: "SOME DESCRIPTION HERE"
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  parameter: select_timeframe_extended {
    type: unquoted
    allowed_value: {
      value: "year"
    }
    allowed_value: {
      value: "month"
    }
    allowed_value: {
      value: "week"
    }
    allowed_value: {
      value: "quarter"
    }
    allowed_value: {
      value: "preyear"
    }
  }

  dimension: label_test {
    type: string
    sql: ${TABLE}.status ;;
    label: "Sales {% if select_timeframe_extended._parameter_value == 'year' %}
                  {{ 'now' | date: '%Y' }}
                  {% elsif select_timeframe_extended._parameter_value == 'month' %}
                  {{ 'now' | date: '%b %Y' }}
                  {% elsif select_timeframe_extended._parameter_value == 'week' %}
                  Week {{ 'now' | date: '%W %Y' }}
                  {% elsif select_timeframe_extended._parameter_value == 'quarter' %}
                    {% assign month = 'now' | date: '%m' %}
                        {% if month == '01' or month == '02' or month == '03' %}Q1
                        {% elsif month == '04' or month == '05' or month == '06' %}Q2
                        {% elsif month == '07' or month == '08' or month == '09' %}Q3
                        {% else %}Q4
                        {% endif %}
                    {{ 'now' | date: '%Y' }}
                  {% elsif select_timeframe_extended._parameter_value == 'preyear' %}
                  {{ 'now' | date: '%Y' | minus:1 }}
                  {% endif %}"
  }

  dimension: numerator {
    type: number
    sql: 2578 ;;
  }

  dimension: denominator {
    type: number
    sql: 1000 ;;
  }

  measure: commission_cp_cohort {
    type: sum
    group_label: "Commissions Net - Cohort"
    group_item_label: "Comm Net - CP - Cohort"
    label: "Commissions (Cancelled)"
    description: "The net sum of commissions for the cohort for the current period"
    view_label: "Adv Benchmarking"
    value_format_name: decimal_0
    sql: ${user_id} ;;
    filters: [status: "cancelled"]
    html:
    {{rendered_value}}
    <br>
    <br>
    Commissions YoY
    <br>
    {{status._rendered_value}};;
  }

  measure: commission_cp_cohort_2 {
    type: sum
    group_label: "Commissions Net - Cohort"
    group_item_label: "Comm Net - CP - Cohort"
    label: "Commissions (Complete)"
    description: "The net sum of commissions for the cohort for the current period"
    view_label: "Adv Benchmarking"
    value_format_name: decimal_0
    sql: ${user_id} ;;
    filters: [status: "complete"]
    html:
    {{rendered_value}}
    <br>
    <br>
    Commissions YoY
    <br>
    {{status._rendered_value}};;
  }

  measure: negative_test {
    type: max
    sql: ${numerator}/${denominator}*-1;;
    value_format_name: percent_2
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count]
  }
}
