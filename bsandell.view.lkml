view: bsandell {
  sql_table_name: public.bsandell ;;

  dimension: car_id {
    type: number
    sql: ${TABLE}.car_id ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_time ;;
  }

  dimension: number_of_pit_crew_members {
    type: number
    sql: ${TABLE}.number_of_pit_crew_members ;;
  }

  dimension: pitstop_id {
    label: "My New Label"
    description: "This is the id number of the pit stop for a given car."
    type: number
    sql: ${TABLE}.pitstop_id ;;
  }

#   dimension: racer_id {
#     type: number
#     sql: ${TABLE}.racer_id ;;
#   }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,fiscal_quarter
    ]
    sql: ${TABLE}.start_time ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
