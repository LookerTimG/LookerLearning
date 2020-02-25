- dashboard: customer_behavior
  title: Customer Behavior
  layout: newspaper
  elements:
  - title: Orders per Customer
    name: Orders per Customer
    model: sandbox_timg
    explore: fact_order_items
    type: looker_column
    fields: [fact_order_items.order_count_tier, fact_order_items.total_order_count]
    filters:
      fact_order_items.order_count_tier: "-Below 1"
    sorts: [fact_order_items.order_count_tier]
    limit: 500
    query_timezone: America/Denver
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      fact_order_items.total_order_count: "#2ca25f"
    series_labels:
      fact_order_items.total_order_count: Order Count
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: fact_order_items.total_order_count,
            name: Order Count, axisId: fact_order_items.total_order_count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: custom, tickDensityCustom: '100',
        type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Orders per Customer
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Customer Lifetime Sales
    name: Customer Lifetime Sales
    model: sandbox_timg
    explore: fact_order_items
    type: looker_bar
    fields: [fact_order_items.sales_amt_tier, fact_order_items.total_customer_count]
    fill_fields: [fact_order_items.sales_amt_tier]
    sorts: [fact_order_items.sales_amt_tier]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: Customer Count, orientation: bottom, series: [{id: fact_order_items.total_customer_count,
            name: Fact Order Items Total Customer Count, axisId: fact_order_items.total_customer_count}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 100, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Order Amount Tier
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 0
    col: 16
    width: 8
    height: 6
  - title: Average Lifetime Customer Spend
    name: Average Lifetime Customer Spend
    model: sandbox_timg
    explore: fact_order_items
    type: single_value
    fields: [fact_order_items.avg_customer_lifetime_spend]
    limit: 500
    query_timezone: user_timezone
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 8
    width: 8
    height: 6
  - title: Sales Tiers Monthly Spend Prior Month
    name: Sales Tiers Monthly Spend Prior Month
    model: sandbox_timg
    explore: fact_order_items
    type: looker_column
    fields: [fact_order_items.year_month_date, fact_order_items.sales_amt_tier_sort,
      fact_order_items.sales_amt_tier, fact_order_items.total_customer_spend]
    filters:
      fact_order_items.year_month_date: 2 months
    sorts: [fact_order_items.sales_amt_tier_sort]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axes: [{label: Total Customer Spend, orientation: left, series: [{id: fact_order_items.total_customer_spend,
            name: Fact Order Items Total Customer Spend, axisId: fact_order_items.total_customer_spend}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 100, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Order Amount Tier
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [fact_order_items.year_month_date, fact_order_items.sales_amt_tier_sort]
    listen: {}
    row: 6
    col: 0
    width: 8
    height: 6
  - title: Avg Last Usage Date Prior 6 Months by Revenue Tier
    name: Avg Last Usage Date Prior 6 Months by Revenue Tier
    model: sandbox_timg
    explore: fact_order_items
    type: table
    fields: [fact_order_items.sales_amt_tier, fact_order_items.sales_amt_tier_sort,
      fact_order_items.avg_order_date]
    filters:
      fact_order_items.year_month_date: 6 months
    sorts: [fact_order_items.sales_amt_tier_sort]
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      fact_order_items.sales_amt_tier: Order Amount Tier
      fact_order_items.avg_order_date: Avg Last Order Date
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: Avg Last Order Date, orientation: bottom, series: [{id: fact_order_items.avg_order_date,
            name: Fact Order Items Avg Order Date, axisId: fact_order_items.avg_order_date}],
        showLabels: true, showValues: true, maxValue: 2020, minValue: 2018, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 100, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Order Sales Tier
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [fact_order_items.sales_amt_tier_sort]
    listen: {}
    row: 6
    col: 8
    width: 8
    height: 6
  - title: Customer Reorder Count by Brand
    name: Customer Reorder Count by Brand
    model: sandbox_timg
    explore: brand_fact
    type: table
    fields: [brand_fact.brand, brand_fact.count_reorders]
    sorts: [brand_fact.count_reorders 0, brand_fact.brand]
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      brand_fact.brand: Brand
      brand_fact.count_reorders: Times Reordered
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen: {}
    row: 6
    col: 16
    width: 8
    height: 6
  - title: Customer Reorder Count by Category
    name: Customer Reorder Count by Category
    model: sandbox_timg
    explore: category_fact
    type: table
    fields: [category_fact.category, category_fact.count_reorders]
    sorts: [category_fact.count_reorders 0, category_fact.category]
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      category_fact.category: Category
      category_fact.count_reorders: Times Reordered
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen: {}
    row: 12
    col: 0
    width: 8
    height: 6
  - title: Sales by Month Since Signup
    name: Sales by Month Since Signup
    model: sandbox_timg
    explore: customer_sales_by_month_since_signup
    type: looker_line
    fields: [customer_sales_by_month_since_signup.months_signup_to_sale, customer_sales_by_month_since_signup.sales_total]
    sorts: [customer_sales_by_month_since_signup.months_signup_to_sale]
    limit: 500
    query_timezone: America/Denver
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      customer_sales_by_month_since_signup.sales_total: "#2ca25f"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: Average Sales per Month, orientation: left, series: [{id: customer_sales_by_month_since_signup.sales_total,
            name: Customer Sales By Month Since Signup Sales Total, axisId: customer_sales_by_month_since_signup.sales_total}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Months Since Signup
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 12
    col: 8
    width: 8
    height: 6
  - title: Number of customers starting in a month vs number of active customers
    name: Number of customers starting in a month vs number of active customers
    model: sandbox_timg
    explore: cohort
    type: looker_column
    fields: [order_items.number_of_unique_customers, order_items.count_active_customer]
    filters:
      cohort.number_of_months_to_desired_month: '24'
    limit: 500
    query_timezone: America/Denver
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_labels:
      order_items.number_of_unique_customers: Original Number of Customers
      order_items.count_active_customer: Active Number of Customers
    limit_displayed_rows: false
    y_axes: [{label: Customer Count, orientation: left, series: [{id: order_items.number_of_unique_customers,
            name: Order Items Number of Unique Customers, axisId: order_items.number_of_unique_customers},
          {id: order_items.count_active_customer, name: Order Items Count Active Customer,
            axisId: order_items.count_active_customer}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: '100', type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 12
    col: 16
    width: 8
    height: 6
  - title: Traffic Source - Customer Spend Multi-Year
    name: Traffic Source - Customer Spend Multi-Year
    model: sandbox_timg
    explore: order_items
    type: looker_column
    fields: [users.traffic_source, users.created_month, users.average_user_spend]
    filters:
      users.created_year: 3 years
    sorts: [users.traffic_source desc, users.created_month]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      users.average_user_spend: "#928fb4"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: Avg Customer Spend, orientation: left, series: [{id: users.average_user_spend,
            name: User Orders Average Customer Spend, axisId: users.average_user_spend}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 100, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Year Month by Source
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    column_spacing_ratio: 0
    column_group_spacing_ratio: 1
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 18
    col: 0
    width: 8
    height: 6
  - title: Customer Spend Last Year vs Last Month Signup
    name: Customer Spend Last Year vs Last Month Signup
    model: sandbox_timg
    explore: order_items
    type: looker_column
    fields: [users.average_user_spend, users.created_month]
    fill_fields: [users.created_month]
    filters:
      users.created_year: 1 months ago for 1 months,1 years ago for 1 years
    sorts: [users.created_month desc]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: Avg Customer Spend, orientation: left, series: [{id: users.average_user_spend,
            name: User Orders Average Customer Spend, axisId: users.average_user_spend}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: '100', type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Prior Year vs Prior Month Signup
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    row: 18
    col: 8
    width: 8
    height: 6
  - title: Lifetime Spend by Months Since Signup
    name: Lifetime Spend by Months Since Signup
    model: sandbox_timg
    explore: order_items
    type: looker_column
    fields: [users.average_user_spend, users.months_since_signup]
    filters:
      users.months_since_signup: "<=48"
    sorts: [users.average_user_spend desc]
    limit: 500
    query_timezone: America/Denver
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: Average Customer Spend, orientation: left, series: [{id: users.average_user_spend,
            name: User Orders Average Customer Spend, axisId: users.average_user_spend}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: '100', type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Months Since Signup
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 18
    col: 16
    width: 8
    height: 6
  - title: Revenue by Months Signed Up Cohort
    name: Revenue by Months Signed Up Cohort
    model: sandbox_timg
    explore: order_items
    type: looker_column
    fields: [order_items.total_gross_revenue, users.months_since_signup]
    filters:
      users.months_since_signup: "<=12"
    sorts: [users.months_since_signup]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_labels:
      order_items.total_gross_revenue: Gross Revenue
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: order_items.total_gross_revenue,
            name: Gross Revenue, axisId: order_items.total_gross_revenue}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: custom, tickDensityCustom: '100',
        type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Months Since Signup
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 24
    col: 0
    width: 8
    height: 6
