- dashboard: test_jellyvision
  title: Test jellyvision
  layout: newspaper
  elements:
  - title: department count
    name: department count
    model: local_postgres
    explore: track
    type: looker_column
    fields: [track.department, track.count]
    sorts: [track.count desc]
    limit: 500
    query_timezone: America/Denver
    listen:
      department: track.department
    row: 0
    col: 0
    width: 8
    height: 6
  filters:
  - name: department
    title: department
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: local_postgres
    explore: track
    listens_to_filters: []
    field: track.department
