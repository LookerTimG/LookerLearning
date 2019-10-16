- dashboard: reorder_by_brand_lookml_test
  title: Reorder by Brand LookML Test
  layout: newspaper
  elements:
  - title: Reorder by Brand
    name: Reorder by Brand
    model: sandbox_timg
    explore: brand_fact
    type: table
    fields: [brand_fact.brand, brand_fact.count_reorders]
    sorts: [brand_fact.brand]
    limit: 500
    query_timezone: America/Denver
    row: 0
    col: 0
    width: 8
    height: 6
