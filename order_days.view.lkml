view: order_days {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:SELECT c1.user_id AS user1
  , C1.order_id as order1
  , DATEDIFF(day, C1.created_at, C2.created_at) AS days_between_orders
FROM (SELECT oi.user_id
  , oi.created_at::DATE
  , oi.order_id
  , ROW_NUMBER() OVER ( PARTITION BY user_id ORDER BY order_id) AS order_sequence
FROM order_items oi
GROUP BY oi.user_id
  , oi.created_at::DATE
  , oi.order_id) AS C1
LEFT OUTER JOIN (SELECT oi.user_id
  , oi.created_at::DATE
  , oi.order_id
  , ROW_NUMBER() OVER ( PARTITION BY user_id ORDER BY order_id) AS order_sequence
FROM order_items oi
GROUP BY oi.user_id
  , oi.created_at::DATE
  , oi.order_id) AS C2
ON C1.user_id = C2.user_id
WHERE C1.order_id = C2.order_id
AND C1.Order_Sequence + 1 = C2.order_sequence
AND DATEDIFF(day, C1.created_at, C2.created_at) > 0
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
#    hidden: yes
  }

  dimension: order_id {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.order_id ;;
#    hidden: yes
  }

  dimension: order_sequence {
    description: "index of order in users purchase path"
    type: number
    sql: ${TABLE}.order_sequence ;;
    hidden: yes
  }

  dimension: days_between_orders {
    description: "The number of days between each users purchases"
    type: number
    sql: ${TABLE}.days_between_orders ;;
  }

  dimension: repeat_60_day_purchase {
    type: yesno
    sql: ${days_between_orders} >= 60 ;;
  }

  dimension_group: created_at {
    description: "The date the order was created"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
    hidden: yes
  }

  measure: avg_days_between_orders {
    type:  average
    sql: ${TABLE}.days_between_orders ;;
  }

}
