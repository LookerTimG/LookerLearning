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

explore: order_items {
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

#  join: products {
#    type: left_outer
#    sql_on: ${inventory_items.product_id} = ${products.id} ;;
#    relationship: many_to_one
#    view_label: ""
#  }
}

#explore: products {
#  join: distribution_centers {
#    type: left_outer
#    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#    relationship: many_to_one
#  }
#}

#explore: users {}
