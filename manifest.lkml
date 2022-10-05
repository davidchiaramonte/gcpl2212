# project_name: "david_c_test"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

# Bug test: Expand tables down render html and value format
constant: evol_color {
  value : "
  {% if value > 0 %}
  {{ rendered_value }} <font color= \"green\"> &#8599; </font>
  {% elsif value <0 %}
  {{ rendered_value }} <font color= \"red\"> &#8600; </font>
  {% else %}
  {{ rendered_value }}<font color= \"black\"> &#8674;</font>
  {% endif %}"
}
