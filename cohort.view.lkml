view: cohort {
  derived_table: {
    sql:id AS user_id
        FROM users
      where created_at {% condition months_to_select %} ((GETDATE()::date - users.created_at::date)) / 30 {% endcondition %}
      ;;
  }

  dimension: user_id {
    primary_key: yes
    hidden: yes
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

    filter: months_to_select {
      description: "Months how many months backwards to the desired month"
      type: number
      suggest_explore: users
      suggest_dimension: users.created_date
    }
}
