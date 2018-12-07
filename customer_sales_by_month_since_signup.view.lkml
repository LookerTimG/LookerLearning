view: customer_sales_by_month_since_signup {
  derived_table: {
    sql: SELECT  u.id AS user_id
      , SUM(oi.sale_price) AS total_monthly_sales
      , (DATE_PART('year', oi.created_at::date) - DATE_PART('year', u.created_at::date)) * 12 + (DATE_PART('month', oi.created_at::date) - DATE_PART('month', u.created_at::date)) AS month_span_signup_to_order
FROM users u
INNER JOIN order_items oi
ON u.id = oi.user_id
GROUP BY (DATE_PART('year', oi.created_at::date) - DATE_PART('year', u.created_at::date)) * 12 + (DATE_PART('month', oi.created_at::date) - DATE_PART('month', u.created_at::date))
        , u.id
      ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id
    hidden = yes ;;
  }

  dimension: months_signup_to_sale {
    description: "The number of months from when the user record was created until the sales record was created"
    primary_key: yes
    type: number
    sql: ${TABLE}.month_span_signup_to_order ;;
  }

  measure: sales_total {
    description: "avg of sales for range"
    type: average
    sql: ${TABLE}.total_monthly_sales ;;
    value_format: "$#,##0.00"
  }
}
