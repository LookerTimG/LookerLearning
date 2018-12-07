
view: filter_delimit {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:SELECT
        '"' || u1.last_name || ', ' || u2.last_name || '"' AS test_val
        FROM users u1
        INNER JOIN users u2
        ON u1.id = u2.id+1
        LIMIT 10
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: test_val {
    type: string
    sql: ${TABLE}.test_val ;;
    link: {
      label: "My Link"
      url: "https://profservices.dev.looker.com/dashboards/84?last_name={{ value | url_encode }}"
    }


  }

}
