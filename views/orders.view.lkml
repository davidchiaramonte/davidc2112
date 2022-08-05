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

  dimension: label_test {
    type: string
    sql: ${TABLE}.status ;;
    label: "{{ _user_attributes['name'] }}"
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
    label: "Commissions"
    description: "The net sum of commissions for the cohort for the current period"
    value_format_name: decimal_0
    sql: ${user_id} ;;
    #filters: [date_in_timeframe: "yes", series: "Cohort"]
    html:
    {{rendered_value}}
    <br>
    <br>
    Commissions YoY
    <br>
    {{id._rendered_value}};;
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
