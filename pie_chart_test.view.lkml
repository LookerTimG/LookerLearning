view: pie_chart_test {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT 99 as A
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: test {
    type: number
    sql: ${TABLE}.a ;;
  }

  measure: a {
    type: number
    sql: 2 ;;
  }

  measure: b {
    type: number
    sql: 5 ;;
  }

  measure: c {
    type: number
    sql: 7 ;;
  }

  measure: d {
    type: number
    sql: 2 ;;
  }

  measure: e {
    type: number
    sql: 9 ;;
  }

  measure: f {
    type: number
    sql: 5 ;;
  }


}
