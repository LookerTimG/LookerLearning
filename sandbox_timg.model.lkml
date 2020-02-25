connection: "postgres_local"

include: "*.view.lkml"                       # include all views in this project

include: "reorder_by_brand_lookml_test.dashboard"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

# include all the views
include: "*.view"
include: "reorder_by_brand_lookml_test.dashboard"
include: "customer_behavior.dashboard"
datagroup: sandbox_timg_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sandbox_timg_default_datagroup

explore: bsandell_extend {}
explore: bsandell {}

explore: filter_delimit {}

explore: user_1 {
  from: users
}

explore: user_2 {
  from: users
}

explore: users_combine {}

explore: pie_chart_test {}

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

explore: order_patterns {}
#   join: order_days {
#     type: left_outer
#     relationship: many_to_one
#     sql: ${order_patterns.order_id} = ${order_days.order_id}
#     AND ${order_patterns.user_id} = ${order_days.user_id};;
#     view_label: "Order Patterns"
#   }
# }

explore: fashionly_case3 {
  from: order_patterns
  }

explore: fashionly_case3_1 {
  from: order_days
}

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

explore: cohort {
  join: order_items {
    type: inner
    sql_on: ${cohort.user_id} = ${order_items.user_id} ;;
    relationship: one_to_many
    fields: [order_items.customer_set*]
    }
  join: users {
    type: inner
    sql_on: ${cohort.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: customer_sales_by_month_since_signup {}

explore: inventory_items {
  label: "Brand Analysis"
join: order_items {
  type: inner
  relationship: many_to_one
  sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
}
}

explore: order_items_2 {
  always_filter: {
    filters: {
      field: inventory_items_2.product_category
      value: ""
    }
  }
join: inventory_items_2 {
  type: inner
  relationship: many_to_one
  sql_on:  ${order_items_2.inventory_item_id} = ${inventory_items_2.id} ;;
}
}

#explore: cohort {}

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

explore: user_test {}
