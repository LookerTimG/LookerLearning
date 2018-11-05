view: inventory_items {
  sql_table_name: public.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    label: "cost_inventory_items"
    hidden: yes
  }

#  dimension_group: created {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.created_at ;;
#  }

#   dimension: product_brand {
#     type: string
#     sql: ${TABLE}.product_brand ;;
# #     hidden: yes
#   view_label: "Order Items"
#   }
  dimension: brand {
    type: string
    sql: ${TABLE}.product_brand  ;;
    drill_fields: [inventory_items.product_category, inventory_items.product_name]
    link: {
      label: "Google"
      url: "https://www.google.com/search?q={{ value }}"
    }
    link: {
      label: "Facebook"
      url: "https://www.facebook.com/search/top/?q={{ value }}"
    }
    view_label: "Order Items"
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

#  dimension: product_department {
#    type: string
#    sql: ${TABLE}.product_department ;;
#  }

#  dimension: product_distribution_center_id {
#    type: number
#    sql: ${TABLE}.product_distribution_center_id ;;
#  }

  dimension: product_id {
    type: number
    hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

#  dimension: product_retail_price {
#    type: number
#    sql: ${TABLE}.product_retail_price ;;
#  }

#  dimension: product_sku {
#    type: string
#    sql: ${TABLE}.product_sku ;;
#  }

#  dimension_group: sold {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.sold_at ;;
#  }

  measure: count {
    type: count
    drill_fields: [id, products.id, products.name, order_items.count]
    label: "count_inventory_items"
    hidden: yes
  }

  measure: cost_total {
    type: sum
    sql: ${cost} ;;
    label: "cost_total"
    hidden:  yes
  }

measure: brand_distinct_count {
  type: count_distinct
  sql: ${brand} ;;
  view_label: "Order Items"
}

measure: category_distinct_count {
  type: count_distinct
  sql: ${product_category} ;;
  view_label: "Order Items"
}

}
