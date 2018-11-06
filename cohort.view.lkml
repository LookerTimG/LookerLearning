view: cohort {
  derived_table: {
    sql:id AS user_id
        , ((GETDATE()::date - users.created_at::date)) / 30 AS months_prior
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

  dimension: months_prior {
    type: number
    sql: ${TABLE}.months_prior ;;
  }

    filter: months_to_select {
      description: "Months how many months backwards to the desired month"
      type: number
      suggest_explore: cohort_by_userid
      suggest_dimension: cohort.months_prior
    }
}
