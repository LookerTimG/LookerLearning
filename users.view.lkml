view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_date ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count, user_data.count]
#    hidden: yes
  label: "User ID"
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_group {
    type: tier
    tiers: [15, 25, 35, 50, 65]
    sql: ${TABLE}.age ;;
    style: integer
  }



  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

#dimension: from_ca_or_ny {
#  type: yesno
#  sql: ${TABLE}.state = 'California' OR ${TABLE}.state = 'New York' ;;
#}

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
    drill_fields: [user_details*]
  }

  dimension: current_month {
    type: yesno
    sql: EXTRACT(MONTH FROM GETDATE())=EXTRACT(MONTH FROM ${created_date}) AND EXTRACT(YEAR FROM GETDATE())=EXTRACT(YEAR FROM ${created_date}) ;;
  }

  dimension: prior_month_to_date {
    type: yesno
    sql: EXTRACT(MONTH FROM DATEADD(MONTH, -1, GETDATE())) = EXTRACT(MONTH FROM ${created_date})
    AND
    EXTRACT(YEAR FROM DATEADD(MONTH, -1, GETDATE())) = EXTRACT(YEAR FROM ${created_date})
    AND
    EXTRACT(DAY FROM GETDATE()) >= EXTRACT(DAY FROM ${created_date})
    ;;
  }

  dimension: new_customer {
    type: yesno
    sql: ${created_date} >= DATEADD(DAY, -90, GETDATE()) ;;
    label: "New Customer in Prior 90 Days"
  }

  dimension: days_since_signup {
    type: number
    sql: GETDATE()::date - ${TABLE}.created_at::date ;;
    value_format: "0"
  }

  dimension: months_since_signup {
    type:  number
    sql: (GETDATE()::date - ${TABLE}.created_at::date) / 30 ;;
    value_format: "0"
  }

  measure: avg_days_since_signup {
    type: average
    sql: GETDATE()::date - ${TABLE}.created_at::date ;;
    value_format: "0"
  }

  measure: avg_months_since_signup {
    type:  average
    sql: (GETDATE()::date - ${TABLE}.created_at::date) / 30 ;;
    value_format: "0"
  }

  measure: count_items_returned {
    type: count_distinct
    filters: {
      field: order_items.status
      value: "Returned"
      }
    sql: ${order_items.id} ;;
    label: "Count of Items Returned"
  }

  measure: count_users_with_returns {
    type: count_distinct
    filters: {
      field: order_items.status
      value: "Returned"
    }
    sql: ${order_items.user_id} ;;
    label: "Count of Customers with Returns"
  }

  measure: percent_users_with_returns {
    type: number
    sql: 100.000 * ${count_users_with_returns} / ${count};;
    label: "Percent of Customers with Returns"
    value_format: "0\%"
  }

  measure: count_items_sold {
    type: count_distinct
    sql: ${order_items.id} ;;
    label: "Count of Items Sold"
    hidden: yes
  }

  measure: item_return_rate {
    type: number
    sql: 100.000 * ${count_items_returned} / ${count_items_sold};;
    label: "Item Return Rate"
    value_format: "0.0\%"
  }

  measure: average_user_spend {
    type: number
    sql: SUM(${order_items.sale_price}) / ${count} ;;
    value_format: "$#,##0.00"
    label: "Average Customer Spend"
    drill_fields: [user_details*]
  }

  measure: current_month_count {
    type: count
    filters: {
      field: current_month
      value: "Yes"
    }
  }

  measure: prior_month_to_date_count {
    type: count
    filters: {
      field: prior_month_to_date
      value: "Yes"
    }
  }

  measure: new_customer_total_revenue {
    type: sum
    filters: {
      field: new_customer
      value: "Yes"
    }
    sql: ${order_items.sale_price} ;;
    sql_distinct_key: ${order_items.id} ;;
    value_format: "$#,##0.00"
  }

  measure: old_customer_total_revenue {
    type: sum
    filters: {
      field: new_customer
      value: "No"
    }
    sql: ${order_items.sale_price} ;;
    sql_distinct_key: ${order_items.id} ;;
    value_format: "$#,##0.00"
  }

  measure: count_new_customers {
    type: count
    filters: {
      field: new_customer
      value: "Yes"
    }
    drill_fields: [user_details*]
  }

  set: user_details {
    fields: [age_group, gender, count]
  }

  measure: average_gross_margin {
    type: number
    sql: ${order_items.gross_margin_percent} ;;
    value_format: "0.0\%"
    drill_fields: [inventory_items.brand, inventory_items.product_category]
  }
}
