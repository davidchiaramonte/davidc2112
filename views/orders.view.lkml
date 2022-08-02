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

  dimension: numerator {
    type: number
    sql: 2578 ;;
  }

  dimension: denominator {
    type: number
    sql: 1000 ;;
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
