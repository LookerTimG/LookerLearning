connection: "thelook_events_redshift"

# include all the views
include: "*.view"

datagroup: sandbox_timg_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sandbox_timg_default_datagroup

#explore: company_list {}

#explore: distribution_centers {}

#explore: events {
#  join: users {
#    type: left_outer
#    sql_on: ${events.user_id} = ${users.id} ;;
#    relationship: many_to_one
#  }
#}

#explore: inventory_items {
#  join: products {
#    type: left_outer
#    sql_on: ${inventory_items.product_id} = ${products.id} ;;
#    relationship: many_to_one
#  }
#
#  join: distribution_centers {
#    type: left_outer
#    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#    relationship: many_to_one
#  }
#}

explore: fact_order_items {}

explore: brand_fact {}

explore: category_fact {}

explore: order_items {
#  view_name: order_items  order_analysis
  label: "Order Analysis"
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "User Orders"
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
    view_label: ""
  }
}

explore: customer_analysis {
  from: order_items
  fields: [customer_analysis.customer_set*]

  join: users {
    type: left_outer
    sql_on: ${customer_analysis.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "User Orders"
  }
}

explore: cohort_by_userid {
  from: order_items
  fields: [cohort_by_userid.customer_set*]
  join: cohort {
    type: inner
    sql_on: ${cohort_by_userid.id} = ${cohort.user_id} ;;
    relationship: many_to_one
    }
  join: users {
    type: inner
    sql_on: ${cohort.user_id} = ${users.id} ;;
    relationship: one_to_one

  }
}

explore: cohort {}

#  join: products {
#    type: left_outer
#    sql_on: ${inventory_items.product_id} = ${products.id} ;;
#    relationship: many_to_one
#    view_label: ""
#  }


#explore: products {
#  join: distribution_centers {
#    type: left_outer
#    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#    relationship: many_to_one
#  }
#}

#explore: users {}
