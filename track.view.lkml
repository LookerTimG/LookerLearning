view: track {
  sql_table_name: public.track ;;

  dimension: department {
#     html: <font color=red>{{value}}</font> ;;
    link: {
      url: "/looks/10?&f[track.department]={{track.department._value | url_encode }}"
      label: "This dept only"
    }
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: dept_group_id {
    type: number
    sql: ${TABLE}.dept_group_id ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension_group: local_transaction {
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
    convert_tz: no
    datatype: date
    sql: ${TABLE}.local_transaction_time ;;
  }

  dimension_group: local_transaction_end {
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
    convert_tz: no
    datatype: date
    sql: ${local_transaction_raw}  + INTERVAL '60 seconds' ;;
  }

  dimension: minute_duration_my_calc {
    type: number
    sql: minutes_diff * 60 + DATE_PART('minute', ${local_transaction_end_raw} - ${local_transaction_raw} ) ;;
  }

  dimension_group: duration_by_group {
    type: duration
    sql_start: ${local_transaction_raw} ;;
    sql_end: ${local_transaction_end_raw} ;;
  }



  dimension: location_name {
    type: string
    sql: ${TABLE}.location_name ;;
  }

  dimension: mobile_device_id {
    type: string
    sql: ${TABLE}.mobile_device_id ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }

  measure: count {
    type: count
    drill_fields: [location_name]
  }

  measure: list {
    type: string
    sql: RIGHT(string_agg(${mobile_device_id}, ','), 25) ;;
  }

  measure: list_2 {
    type: list
    list_field: mobile_device_id
    html: {{ rendered_value }} | truncate: 30 }} ;;
  }

}
