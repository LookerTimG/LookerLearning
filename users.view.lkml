view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    hidden: yes
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    hidden: yes
  }

#  dimension: latitude {
#    type: number
#    sql: ${TABLE}.latitude ;;
#  }

#  dimension: longitude {
#    type: number
#    sql: ${TABLE}.longitude ;;
#  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

#dimension: from_ca_or_ny {
#  type: yesno
#  sql: ${TABLE}.state = 'California' OR ${TABLE}.state = 'New York' ;;
#}

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
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

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
    label: "Count of Customers"
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

}
