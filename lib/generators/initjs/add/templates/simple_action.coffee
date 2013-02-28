<%= js_app_name %>.<%= @controller_name.camelize %> = {} if <%= js_app_name %>.<%= @controller_name.camelize %> is undefined

<%= js_app_name %>.<%= @controller_name.camelize %>.<%= @action_name.camelize %> =->
