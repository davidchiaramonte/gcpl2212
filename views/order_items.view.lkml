# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

# Bug test: Expand tables down render html and value format currently
  measure: evol_sales_amount_wo_vat_eur{
    view_label: "2.1 - Supplier Details Measures"
    group_label: "Indicators in value without VAT in EUROS evolution / delta"
    label: "Euros"
    type:number
    sql: ${TABLE}.sale_price ;;

    html: @{evol_color} ;;
    value_format_name: eur
  }

  measure: evol_sales_amount_wo_vat_percent{
    view_label: "2.1 - Supplier Details Measures"
    group_label: "Indicators in value without VAT in EUROS evolution / delta"
    label: "Percent"
    type:number
    sql: ${TABLE}.sale_price ;;

    html: @{evol_color} ;;
    value_format_name: percent_format_1
  }

  measure: evol_sales_amount_wo_vat_placevalue_small{
    view_label: "2.1 - Supplier Details Measures"
    group_label: "Indicators in value without VAT in EUROS evolution / delta"
    label: "Mutli placevalue"
    type:number
    sql: ${TABLE}.sale_price*20 ;;

    html: @{evol_color} ;;
    value_format: "[>=1000000]\"£\"0.00,,\"M\";[>=1000]\"£\"0.00,\"K\";\"£\"0.00"
  }

  measure: evol_sales_amount_wo_vat_placevalue_large{
    view_label: "2.1 - Supplier Details Measures"
    group_label: "Indicators in value without VAT in EUROS evolution / delta"
    label: "Large Mutli placevalue"
    type:number
    sql: ${TABLE}.sale_price*200000 ;;

    html: @{evol_color} ;;
    value_format: "[>=1000000]\"$\"0.00,,\"M\";[>=1000]\"$\"0.00,\"K\";\"\"0.00"

  }
}
