view: brand_fact {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: WITH c1 AS
      (SELECT oi.user_id
            , ii.product_id
            , COUNT(DISTINCT oi.order_id) AS order_count
      FROM order_items oi
      INNER JOIN inventory_items ii
      ON oi.inventory_item_id = ii.id
      GROUP BY oi.user_id
          , ii.product_id
      )

      SELECT ii.product_brand
              , SUM(c1.order_count) - 1 AS reorder_count_brand
      FROM c1
      INNER JOIN inventory_items ii
      ON c1.product_id = ii.product_id
      GROUP BY ii.product_brand
            ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: constant_test {
    type: number
    sql: .39 ;;
  }

  measure: count_reorders {
    type: sum
    sql: ${TABLE}.reorder_count_brand ;;
#     html: <a href="https://profservices.dev.looker.com/" target="_self" title="Click for a Detailed Look"> {{rendered_value}} </a> ;;
#     Opens in a new tab
    link: {
      label: "Link Test Absolute"
      url: "https://profservices.dev.looker.com/looks/107?toggle=dat,pik"
    }
#     Opens in the same tab
    link: {
      label: "Link Test Relative"
      url: "/looks/107?toggle=dat,pik"
    }
  }
}
