view: order_items {
  sql_table_name: public.order_items ;;

set: customer_set {
  fields: [
     user_id,
#     order_count,
#     count_tier,
     revenue_tier,
     count,
     repeat_customer,
     avg_days_from_last_order,
     day_from_last_order,
     is_active_customer,
     max_order_date,
     avg_count_of_orders_per_customer,
     number_of_unique_customers,
     count_of_orders,
     status
  ]
}
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
#    hidden: yes
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
    drill_fields: [inventory_items.product_category, inventory_items.product_name]
  }

measure: gross_margin_percent {
  type: number
  sql:  100 * (( ${total_gross_margin_amount} ) / NULLIF(${total_gross_revenue}, 0)) ;;
  value_format: "0\%"
  }

measure: total_cost {
    type: sum
    sql: ${inventory_items.cost} ;;
    label: "Total Cost"
    value_format: "$#,##0.00"
  }

measure: percent_of_total_gross_revenue {
    type: percent_of_total
    sql: ${total_gross_revenue} ;;
    direction: "column"
    value_format: "0.00\%"
  }

  measure: count_of_orders {
    type: count_distinct
    sql: ${order_id} ;;
  }

#   measure: count_tier {
#     type: string
#     sql: CASE WHEN ${count_of_orders} = 1 THEN '1 Order'
#               WHEN ${count_of_orders} = 2 THEN '2 Orders'
#               WHEN ${count_of_orders} BETWEEN 3 and 5 THEN '3-5 Orders'
#               WHEN ${count_of_orders} BETWEEN 6 and 6 THEN '6-9 Orders'
#               ELSE '10+ Orders'
#               END
#               ;;
#   }

  measure: revenue_tier {
    type: string
    sql: CASE WHEN ${total_gross_revenue} < 5.00 THEN '$0.00 - $4.99'
              WHEN ${total_gross_revenue} BETWEEN 5.00 AND 19.99 THEN '$5.00 - $19.99'
              WHEN ${total_gross_revenue} BETWEEN 20.00 AND 19.99 THEN '$5.00 - $19.99'
              WHEN ${total_gross_revenue} BETWEEN 50.00 AND 49.99 THEN '$5.00 - $19.99'
              WHEN ${total_gross_revenue} BETWEEN 100.00 AND 99.99 THEN '$5.00 - $19.99'
              WHEN ${total_gross_revenue} BETWEEN 500.00 AND 999.99 THEN '$5.00 - $19.99'
              ELSE '$1000+'
              END
    ;;
  }

  measure: number_of_unique_customers {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: avg_count_of_orders_per_customer{
    type: number
    sql: ${count} / ${number_of_unique_customers} ;;
    value_format: "0"
  }

  measure: avg_revenue_per_customer{
    type: number
    sql: ${count} / ${number_of_unique_customers} ;;
    value_format: "0"
  }

  measure: min_order_date {
    type: min
    sql: ${created_date} ;;
  }

  measure: max_order_date {
    type: max
    sql: ${created_date} ;;
  }

  measure: is_active_customer {
    type:  yesno
    sql: ${created_date} >= DATEADD(day, -90, GETDATE()) ;;
  }

  measure: day_from_last_order {
    type:  number
    sql: DATEDIFF(day, ${max_order_date}, GETDATE()) ;;
  }

  measure: avg_days_from_last_order{
    type: number
    sql: ${day_from_last_order} / ${number_of_unique_customers} ;;
    value_format: "0"
  }

  measure: repeat_customer {
    type:  yesno
    sql: ${count} > 1 ;;
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
