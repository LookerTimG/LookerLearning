view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "order_items_id"
    hidden: yes
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

  dimension_group: delivered {
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
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
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
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "Order Status"
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    label: "Count of Order Items"
  }

measure: total_sales_price  {
  type: sum
  sql: ${sale_price} ;;
  value_format: "$#,##0.00"
  }

  measure: average_sales_price  {
    type: average
    sql: ${sale_price} ;;
    value_format: "$#,##0.00"
  }

  measure: cumulative_total_sales {
    type: running_total
    sql: ${total_sales_price} ;;
    value_format: "$#,##0.00"
  }

  measure: total_gross_revenue {
    type: sum
    sql: CASE WHEN ${status} NOT IN ('Cancelled', 'Returned')
     THEN ${sale_price}
     ELSE 0
     END ;;
    value_format: "$#,##0.00"
  }

  measure: total_gross_margin_amount {
    type: sum
    filters: {
      field: status
      value: "Complete"
    }
    sql: ${sale_price} - ${inventory_items.cost} ;;
    value_format: "$#,##0.00"
  }

  measure: average_gross_margin {
    type: average
    filters: {
      field: status
      value: "Complete"
    }
    sql: ${sale_price} - ${inventory_items.cost} ;;
    value_format: "$#,##0.00"
  }

measure: gross_margin_percent {
  type: number
  sql:  100 * (( ${total_gross_margin_amount} ) / ${total_gross_revenue}) ;;
  value_format: "0\%"
  }

measure: total_cost {
    type: sum
    sql: ${inventory_items.cost} ;;
    label: "Total Cost"
    value_format: "$#,##0.00"
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
