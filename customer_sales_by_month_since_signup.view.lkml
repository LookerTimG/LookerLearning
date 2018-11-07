view: customer_sales_by_month_since_signup {
  derived_table: {
    sql: SELECT u.id as user_id
      , SUM(oi.sale_price) AS total_monthly_sales
      , (DATE_PART('year', oi.created_at::date) - DATE_PART('year', u.created_at::date)) * 12 + (DATE_PART('month', oi.created_at::date) - DATE_PART('month', u.created_at::date)) AS month_span_signup_to_order
FROM users u
INNER JOIN order_items oi
ON u.id = oi.user_id
GROUP BY u.id
          , (DATE_PART('year', oi.created_at::date) - DATE_PART('year', u.created_at::date)) * 12 + (DATE_PART('month', oi.created_at::date) - DATE_PART('month', u.created_at::date))
      ;;
  }

  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: months_signup_to_sale {
    description: "The number of months from when the user record was created until the sales record was created"
    type: number
    sql: ${TABLE}.month_span_signup_to_order ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    sql: CAST(${user_id} AS varchar(10)) || CAST(${months_signup_to_sale} AS VARCHAR(6)) ;;
  }

  measure: sales_total {
    description: "sum of sales for range"
    type: sum
    sql: ${TABLE}.total_monthly_sales ;;
  }
}
