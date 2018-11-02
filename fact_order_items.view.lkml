view: fact_order_items {
  # Or, you could make this view a derived table, like this:
  derived_table: {
     sql:
#    WITH D1 AS
# (
SELECT COUNT(DISTINCT order_id) AS order_count
      , SUM(sale_price) AS sales_total
      , user_id AS d_user_id
FROM order_items
GROUP BY user_id
# )
# SELECT        order_count
# --               , COUNT(*) as order_count
#                , d_user_id
#               , CASE WHEN order_count = 1 THEN 1
#               WHEN order_count = 2 THEN 2
#               WHEN order_count BETWEEN 3 and 5 THEN 3
#               WHEN order_count BETWEEN 6 and 6 THEN 4
#               ELSE 5
#               END as sort_order
# FROM D1
# GROUP BY d_user_id
#         , order_count
#         , CASE WHEN order_count = 1 THEN 1
#               WHEN order_count = 2 THEN 2
#               WHEN order_count BETWEEN 3 and 5 THEN 3
#               WHEN order_count BETWEEN 6 and 6 THEN 4
#               ELSE 5
#               END;
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.d_user_id ;;
  }

  dimension: order_count {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.order_count ;;
  }

dimension: sales_amt  {
  type: number
  sql: ${TABLE}.sales_total ;;
  value_format: "$#,##0.00"
}

dimension: order_count_tier {
  type: tier
  tiers: [1, 2, 5, 9, 10]
  sql: ${order_count} ;;
  style: interval
}

measure: total_order_count {
  type: sum
  sql: ${order_count} ;;
}

}
