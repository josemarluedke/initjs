<%= js_app_name %>.<%= @namespace_name.camelize %> ?= {}
<%= js_app_name %>.<%= @namespace_name.camelize %>.<%= @controller_name.camelize %> ?= {}

<%= js_app_name %>.<%= @namespace_name.camelize %>.<%= @controller_name.camelize %>.<%= @action_name.camelize %> = ->
