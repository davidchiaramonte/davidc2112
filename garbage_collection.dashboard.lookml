- dashboard: garbage_collection_monitoring
  title: Garbage Collection Monitoring
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 0ln1jK6mPIFAbVOGqHVsnA
  elements:
  - title: Scheduled Job Avg Time in Queue Heatmap
    name: Scheduled Job Avg Time in Queue Heatmap
    model: system__activity
    explore: scheduled_plan
    type: looker_grid
    fields: [scheduled_job_stage.started_hour_of_day, scheduled_job_stage.started_day_of_week,
      scheduled_job_stage.avg_runtime, scheduled_job.count]
    pivots: [scheduled_job_stage.started_day_of_week]
    fill_fields: [scheduled_job_stage.started_hour_of_day, scheduled_job_stage.started_day_of_week]
    filters:
      scheduled_job_stage.stage: '"enqueue_for_execute"'
      scheduled_job.created_date: 7 days ago for 7 days
    sorts: [scheduled_job_stage.started_day_of_week 0, scheduled_job_stage.started_hour_of_day]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    series_labels:
      scheduled_job_stage.avg_runtime: Average Time in Queue
    series_cell_visualizations:
      scheduled_job_stage.avg_runtime:
        is_active: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#7d218f",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: afd46b40-e939-4ace-bffd-69d1bb16ee05, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: middle}, max: {type: maximum}}, mirror: true,
            reverse: true, stepped: false}}, bold: false, italic: false, strikethrough: false,
        fields: [scheduled_job_stage.avg_runtime]}, {type: along a scale..., value: !!null '',
        background_color: "#3EB0D5", font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          custom: {id: c092bb30-8fdb-9ce9-1a95-deab2cb82f73, label: Custom, type: continuous,
            stops: [{color: "#ffffff", offset: 0}, {color: "#d10a1b", offset: 100}]},
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [scheduled_job.count]}]
    truncate_column_names: false
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 8
    col: 0
    width: 16
    height: 12
  - title: Outlier Days for Scheduled Jobs
    name: Outlier Days for Scheduled Jobs
    model: system__activity
    explore: scheduled_plan
    type: looker_column
    fields: [scheduled_job.finalized_date, query.count, scheduled_job_stage.avg_runtime]
    fill_fields: [scheduled_job.finalized_date]
    filters:
      scheduled_job.finalized_day_of_week: "-NULL"
    sorts: [scheduled_job.finalized_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: removes_maxmin, label: Removes Max/Min, expression: 'if(${scheduled_job_stage.avg_runtime}=max(${scheduled_job_stage.avg_runtime})
          OR ${scheduled_job_stage.avg_runtime}=min(${scheduled_job_stage.avg_runtime}),
          null, ${scheduled_job_stage.avg_runtime})', value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}, {table_calculation: standard_deviation_without_outliers,
        label: Standard Deviation (without outliers), expression: 'stddev_pop(${removes_maxmin})',
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: outlier, label: Outlier, expression: 'if(${scheduled_job_stage.avg_runtime}
          - mean(${removes_maxmin}) > 1.5*${standard_deviation_without_outliers},
          yes, no)', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: yesno}, {table_calculation: mean_with_no_outliers, label: Mean
          with no Outliers, expression: 'mean(${removes_maxmin})', value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Query Count, orientation: left, series: [{axisId: query.count,
            id: query.count, name: Query}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: scheduled_job_stage.avg_runtime, id: scheduled_job_stage.avg_runtime,
            name: Average Runtime in Seconds}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, type: log}]
    hide_legend: true
    series_types:
      mean_with_no_outliers: line
    series_colors:
      mean_with_no_outliers: "#E57947"
      query.count: "#4276BE"
      scheduled_job_stage.avg_runtime: "#B1399E"
    reference_lines: []
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#7d218f",
        font_color: !!null '', color_application: {collection_id: 306fbe33-6921-4f0a-858c-5a679bc1bf08,
          palette_id: 72105a77-cea2-4d87-83df-00c4f0ab30ba, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: true, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    hidden_fields: [removes_maxmin, standard_deviation_without_outliers, mean_with_no_outliers]
    hidden_points_if_no: [outlier]
    note_state: collapsed
    note_display: hover
    note_text: Outliers are days where Average Runtime exceeds (1.5 * standard deviation)
      of all the days with maximum and minimum Average Runtime values removed.
    defaults_version: 1
    listen: {}
    row: 8
    col: 16
    width: 8
    height: 6
  - title: Scheduled Jobs by Explore
    name: Scheduled Jobs by Explore
    model: system__activity
    explore: scheduled_plan
    type: looker_bar
    fields: [scheduled_job.count, query.view]
    filters:
      group.name: "-All Users"
      scheduled_job_stage.started_date: 7 days
    sorts: [scheduled_job.count desc]
    limit: 15
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: ccba75a3-58c7-4b9c-a931-4ffc59e79cba
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: scheduled_job.count,
            id: scheduled_job.count, name: Scheduled Job}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '25'
    series_types: {}
    series_colors:
      scheduled_job.count: "#9174F0"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#7d218f",
        font_color: !!null '', color_application: {collection_id: 306fbe33-6921-4f0a-858c-5a679bc1bf08,
          palette_id: 72105a77-cea2-4d87-83df-00c4f0ab30ba, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: true, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    listen: {}
    row: 14
    col: 16
    width: 8
    height: 6
  - name: Scheduling-Related Monitoring
    type: text
    title_text: Scheduling-Related Monitoring
    subtitle_text: ''
    body_text: ''
    row: 7
    col: 0
    width: 24
    height: 1
  - name: Dashboard-Related Monitoring
    type: text
    title_text: Dashboard-Related Monitoring
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 1
  - title: Dashboards with >25 Tiles
    name: Dashboards with >25 Tiles
    model: system__activity
    explore: dashboard
    type: looker_grid
    fields: [dashboard.title, dashboard.link, dashboard_element.count_look, dashboard_element.count_lookless,
      dashboard_element.count_text, dashboard_element.count_merge_query, dashboard_element.count,
      query.count]
    filters:
      dashboard_element.count: ">25"
      dashboard.deleted_date: 'NULL'
      dashboard.moved_to_trash: 'No'
    sorts: [query.count desc]
    limit: 100
    dynamic_fields: [{table_calculation: total_query_tiles, label: Total Query Tiles,
        expression: "${dashboard_element.count}-${dashboard_element.count_text}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 592616d0-58e4-4968-9030-928ef38b7b50
      palette_id: e7303a54-e53e-4cf0-abc9-2f175c1128e0
    show_sql_query_menu_options: false
    column_order: [dashboard.title, dashboard.link, total_query_tiles, query.count,
      dashboard_element.count, dashboard_element.count_look, dashboard_element.count_lookless,
      dashboard_element.count_text, dashboard_element.count_merge_query]
    show_totals: true
    show_row_totals: true
    series_labels:
      query.count: Total Queries Generated
      dashboard_element.count_look: Look Tiles
      dashboard_element.count_lookless: Lookless Tiles
      dashboard_element.count_text: Text Tiles
      dashboard_element.count: Total Tiles
      dashboard_element.count_merge_query: Merge Query Tiles
    series_column_widths:
      total_query_tiles: 130
      dashboard_element.count: 89
      dashboard.title: 142
      dashboard.link: 88
      dashboard_element.count_look: 89
      query.count: 194
      dashboard_element.count_text: 89
      dashboard_element.count_lookless: 117
      dashboard_element.count_merge_query: 137
    series_cell_visualizations:
      dashboard_element.count_look:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1D98D3",
        font_color: !!null '', color_application: {collection_id: 592616d0-58e4-4968-9030-928ef38b7b50,
          palette_id: 721299c7-f114-43fc-926f-5bf0462bbfca, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 22}, max: {type: number,
                value: 25}}, mirror: false, reverse: true, stepped: false}}, bold: false,
        italic: false, strikethrough: false, fields: [total_query_tiles]}]
    truncate_column_names: true
    series_types: {}
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Load times and general instance health may be impacted on dashboards
      with more than 25 tiles.
    defaults_version: 1
    listen: {}
    row: 1
    col: 0
    width: 8
    height: 6
  - title: Dashboards with Many Merge Results Queries
    name: Dashboards with Many Merge Results Queries
    model: system__activity
    explore: dashboard
    type: looker_grid
    fields: [dashboard.title, dashboard.link, dashboard_element.count_merge_query,
      dashboard_element.count, query.count, merge_query_source_query.count]
    filters:
      dashboard.deleted_date: 'NULL'
      dashboard.moved_to_trash: 'No'
      dashboard_element.count_merge_query: ">0"
    sorts: [merge_query_source_query.count desc]
    limit: 100
    dynamic_fields: [{table_calculation: total_query_tiles, label: Total Query Tiles,
        expression: "${dashboard_element.count}-${dashboard_element.count_text}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 592616d0-58e4-4968-9030-928ef38b7b50
      palette_id: e7303a54-e53e-4cf0-abc9-2f175c1128e0
    show_sql_query_menu_options: false
    column_order: [dashboard.title, dashboard.link, total_query_tiles, query.count,
      dashboard_element.count, dashboard_element.count_look, dashboard_element.count_lookless,
      dashboard_element.count_text, dashboard_element.count_merge_query]
    show_totals: true
    show_row_totals: true
    series_labels:
      query.count: Total Queries Generated
      dashboard_element.count_look: Look Tiles
      dashboard_element.count_lookless: Lookless Tiles
      dashboard_element.count_text: Text Tiles
      dashboard_element.count: Total Tiles
      dashboard_element.count_merge_query: Merge Query Tiles
    series_column_widths:
      total_query_tiles: 130
      dashboard_element.count: 89
      dashboard.title: 142
      dashboard.link: 88
      dashboard_element.count_look: 89
      query.count: 194
      dashboard_element.count_text: 89
      dashboard_element.count_lookless: 117
      dashboard_element.count_merge_query: 137
    series_cell_visualizations:
      dashboard_element.count_look:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1D98D3",
        font_color: !!null '', color_application: {collection_id: 592616d0-58e4-4968-9030-928ef38b7b50,
          palette_id: 721299c7-f114-43fc-926f-5bf0462bbfca, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 22}, max: {type: number,
                value: 25}}, mirror: false, reverse: true, stepped: false}}, bold: false,
        italic: false, strikethrough: false, fields: []}]
    truncate_column_names: true
    series_types: {}
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Load times and general instance health may be impacted on dashboards
      with more than 25 tiles.
    defaults_version: 1
    listen: {}
    row: 1
    col: 8
    width: 8
    height: 6
  - title: Dashboards with Table Calculations or Custom Fields
    name: Dashboards with Table Calculations or Custom Fields
    model: system__activity
    explore: dashboard
    type: looker_grid
    fields: [dashboard.title, dashboard.link, dashboard_element.count_look, dashboard_element.count_lookless,
      dashboard_element.count_text, dashboard_element.count_merge_query, dashboard_element.count,
      query.count]
    filters:
      dashboard.deleted_date: 'NULL'
      dashboard.moved_to_trash: 'No'
    sorts: [query.count desc]
    limit: 100
    dynamic_fields: [{table_calculation: total_query_tiles, label: Total Query Tiles,
        expression: "${dashboard_element.count}-${dashboard_element.count_text}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    filter_expression: is_null(${merge_query.dynamic_fields})=no OR is_null(${query.dynamic_fields})=no
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 592616d0-58e4-4968-9030-928ef38b7b50
      palette_id: e7303a54-e53e-4cf0-abc9-2f175c1128e0
    show_sql_query_menu_options: false
    column_order: [dashboard.title, dashboard.link, total_query_tiles, query.count,
      dashboard_element.count, dashboard_element.count_look, dashboard_element.count_lookless,
      dashboard_element.count_text, dashboard_element.count_merge_query]
    show_totals: true
    show_row_totals: true
    series_labels:
      query.count: Total Queries Generated
      dashboard_element.count_look: Look Tiles
      dashboard_element.count_lookless: Lookless Tiles
      dashboard_element.count_text: Text Tiles
      dashboard_element.count: Total Tiles
      dashboard_element.count_merge_query: Merge Query Tiles
    series_column_widths:
      total_query_tiles: 130
      dashboard_element.count: 89
      dashboard.title: 142
      dashboard.link: 88
      dashboard_element.count_look: 89
      query.count: 194
      dashboard_element.count_text: 89
      dashboard_element.count_lookless: 117
      dashboard_element.count_merge_query: 137
    series_cell_visualizations:
      dashboard_element.count_look:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1D98D3",
        font_color: !!null '', color_application: {collection_id: 592616d0-58e4-4968-9030-928ef38b7b50,
          palette_id: 721299c7-f114-43fc-926f-5bf0462bbfca, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 22}, max: {type: number,
                value: 25}}, mirror: false, reverse: true, stepped: false}}, bold: false,
        italic: false, strikethrough: false, fields: [total_query_tiles]}]
    truncate_column_names: true
    series_types: {}
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Load times and general instance health may be impacted on dashboards
      with more than 25 tiles.
    defaults_version: 1
    listen: {}
    row: 1
    col: 16
    width: 8
    height: 6
