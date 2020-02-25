view: user_test {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
#    hidden: yes
    label: "User ID"
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

#   dimension: email {
#     type: string
#     label: "{% 'yes' == 'yes' %}
#             yes
#             {% else %}
#             no
#             {% endif %}
#             "
# #     hidden: {% 'yes' == 'yes' %}
# #             yes
# #             {% else %}
# #             no
# #             {% endif %}
# #     sql: ${TABLE}.email ;;
#   }

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

  dimension: created_at {
    type: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: shipped_at {
    type: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: returned_at {
    type: date
    sql: ${TABLE}.returned_at ;;
  }

  measure: count {
    type: count
  }

  measure: distinct_created_at {
    type: count_distinct
    sql: ${created_at} ;;
  }

  measure: distinct_shipped_at {
    type: count_distinct
    sql: ${shipped_at} ;;
  }

  measure: distinct_returned_at {
    type: count_distinct
    sql: ${returned_at} ;;
  }

}
