<%= js_app_name %>.<%= @controller_name.camelize %> ?= {}

<%= js_app_name %>.<%= @controller_name.camelize %>.<%= @action_name.camelize %> =
  init: ->

  modules: -> []
