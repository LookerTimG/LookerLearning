view: order_patterns {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT oi.user_id
  , oi.created_at::DATE
  , oi.order_id
  , ROW_NUMBER() OVER ( PARTITION BY user_id ORDER BY order_id) AS order_sequence
FROM order_items oi
GROUP BY oi.user_id
  , oi.order_id
  , oi.created_at::DATE
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_id {
    description: "Unique ID for each order"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_sequence {
    description: "Sequence of the order on a per user basis"
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [day_of_month,month,date]
  }

#   dimension: days_between_orders {
#     description: "The number of sequential days between a customers orders"
#     type: number
#     sql: ${TABLE}.days_between_orders ;;
#   }

  dimension: is_first_purchase {
    description: "Flag field designating if an order is their first purchase"
    type: yesno
    sql: ${order_sequence} = 1 ;;
  }

  dimension: has_multiple_orders {
    description: "Flag field designating if an the user has ordered more than once"
    type: yesno
    sql: ${order_sequence} > 1 ;;
  }

  measure: count {
    description: "count of rows"
    type: count
  }

#   measure: avg_days_between_orders {
#     description: "The average number of days between orders for the same user"
#     type: average
#     sql: ${days_between_orders} ;;
#   }

#   measure: sixty_day_purchase_rate {
#     description: "Flag field indicating if a user ordered again withing 60 days"
#     type: yesno
#     sql: ${days_between_orders} <= 60 ;;
#   }

}
