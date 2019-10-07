
view: users_combine {
  derived_table: {
    sql:SELECT * FROM ${user_1.SQL_TABLE_NAME}
UNION ALL
SELECT * FROM ${user_2.SQL_TABLE_NAME}
       ;;
  }

  # Define your dimensions and measures here, like this:
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

dimension: latitude {
  type: number
  sql: ${TABLE}.latitude ;;
}

dimension: longitude {
  type: number
  sql: ${TABLE}.longitude ;;
}

dimension: state {
  type: string
  sql: ${TABLE}.state ;;
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

measure: count {
  type: count
  drill_fields: [id, first_name, last_name, events.count, order_items.count]
  label: "Count of Customers"
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

}
