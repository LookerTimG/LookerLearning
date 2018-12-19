view: inventory_items_2 {
  sql_table_name: public.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
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

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category;;
  }

  dimension: product_category_filtered {
    type: string
    sql: CASE WHEN {% condition category_select %} ${product_category} {% endcondition %}
    THEN ${TABLE}.product_category
    ELSE 'All Others' END ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

   dimension: brand_comparison {
    type: string
    sql: CASE
      WHEN {% condition brand_select %} ${product_brand} {% endcondition %}
        THEN 'FEATURED ' || ${product_brand}
      ELSE ${product_brand}
    END ;;
  }

  dimension: all_other_to_brand_comparison {
    type: string
    sql: CASE
      WHEN {% condition brand_select %} ${product_brand} {% endcondition %}
        THEN  ${product_brand}
      ELSE 'All Others'
    END ;;
  }

  measure: count {
    type: count
    drill_fields: [id, product_name, order_items.count]
  }

  measure: target_sum{
    type: sum
    sql: CASE WHEN ${TABLE}.product_category = {% condition category_select %} ${product_category} {% endcondition %}
      THEN ${order_items_2.sale_price} ELSE 0 END ;;
  }

  measure: non_target_sum{
    type: sum
    sql: CASE WHEN ${TABLE}.product_category != {% condition category_select %} ${product_category} {% endcondition %}
      THEN ${order_items_2.sale_price} ELSE 0 END ;;
  }


  filter: brand_select {
    type: string
    suggest_dimension: inventory_items_2.product_brand
  }

  filter: category_select {
    type: string
    suggest_dimension: inventory_items_2.product_category
  }
}
