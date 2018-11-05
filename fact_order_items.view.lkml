view: fact_order_items {
  # Or, you could make this view a derived table, like this:
  derived_table: {
     sql:
SELECT COUNT(DISTINCT order_id) AS order_count
      , SUM(sale_price) AS sales_total
      , user_id AS d_user_id
      , CAST(MAX(created_at) AS DATE) as last_order_date
      , CAST(CAST(EXTRACT(YEAR FROM created_at) AS CHAR(4)) || LPAD(CAST(EXTRACT(MONTH FROM created_at) AS CHAR(2)), 2, '0') AS INT) AS year_month
FROM order_items
GROUP BY user_id
        , CAST(CAST(EXTRACT(YEAR FROM created_at) AS CHAR(4)) || LPAD(CAST(EXTRACT(MONTH FROM created_at) AS CHAR(2)), 2, '0') AS INT)
       ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.d_user_id ;;
  }

dimension: last_order_date {
  type: date
  sql: ${TABLE}.last_order_date ;;
  }

  dimension: order_count {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: order_count_tier {
  type: tier
  tiers: [1, 2, 3, 6, 10]
  sql: ${TABLE}.order_count ;;
  style: integer
}

  dimension: sales_amt  {
    type: number
    sql: ${TABLE}.sales_total ;;
    value_format: "$#,##0.00"
  }

  dimension: sales_amt_tier_sort {
    type:  number
    sql: CASE WHEN ${TABLE}.sales_total < 5.00 THEN 1
    WHEN ${TABLE}.sales_total < 20.00 THEN 2
    WHEN ${TABLE}.sales_total < 50.00 THEN 3
    WHEN ${TABLE}.sales_total < 100.00 THEN 4
    WHEN ${TABLE}.sales_total < 500.00 THEN 5
    WHEN ${TABLE}.sales_total < 1000.00 THEN 6
    ELSE 7
    END
    ;;
 #  hidden: yes
  }

  dimension: sales_amt_tier {
    type: string
#    tiers: [4.99, 19.99, 49.99, 99.99, 499.99, 999.99]
    sql: CASE WHEN ${TABLE}.sales_total < 5.00 THEN '$0.00 - $4.99'
              WHEN ${TABLE}.sales_total < 20.00 THEN '$5.00 - $19.99'
              WHEN ${TABLE}.sales_total < 50.00 THEN '$20.00 - $49.99'
              WHEN ${TABLE}.sales_total < 100.00 THEN '$50.00 - $99.99'
              WHEN ${TABLE}.sales_total < 500.00 THEN '$100.00 - $499.99'
              WHEN ${TABLE}.sales_total < 1000.00 THEN '$500.00 - $999.99'
              ELSE '$1000.00 +'
              END
    ;;
    order_by_field: sales_amt_tier_sort
#    style: integer
#    value_format: "$#,##0.00"
  }

dimension: year_month {
  type: number
  sql: ${TABLE}.year_month ;;
}

dimension: year_month_date {
  type: date
  sql: CAST(CAST(${year_month} AS CHAR(4)) || '-' || RIGHT(CAST(${year_month} AS CHAR(6)), 2) || '-01' AS DATE) ;;
}

measure: total_order_count {
  type: sum
  sql: ${order_count} ;;
}

measure: total_customer_count {
  type: count_distinct
  sql: ${user_id} ;;
}

measure: total_customer_spend {
  type: sum
  sql: ${sales_amt} ;;
  value_format: "$#,##0.00"
}

measure: avg_customer_lifetime_spend {
  type: number
  sql: ${total_customer_spend} / ${total_customer_count} ;;
  value_format: "$#,##0.00"
}

measure: avg_order_date {
  type: date
  sql: (TIMESTAMP WITH TIME ZONE 'epoch' + (AVG(extract(epoch from ${last_order_date})))  * INTERVAL '1 second')::DATE ;;
}

}
