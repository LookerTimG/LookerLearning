view: category_fact {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: WITH c2 AS
(SELECT oi.user_id
      , ii.product_id
      , COUNT(DISTINCT oi.order_id)  AS order_count
FROM order_items oi
INNER JOIN inventory_items ii
ON oi.inventory_item_id = ii.id
GROUP BY oi.user_id
    , ii.product_id
)
SELECT ii.product_category
        , SUM(c2.order_count) -1 AS reorder_count_category
FROM c2
INNER JOIN inventory_items ii
ON c2.product_id = ii.product_id
GROUP BY ii.product_category
      ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  measure: count_reorders {
    type: sum
    sql: ${TABLE}.reorder_count_category ;;
  }
}
