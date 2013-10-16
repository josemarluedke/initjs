window.Initjs =
  initialize: ->
    infos = $("#init-js")
    controllerClass = infos.data("controller-class")
    controllerName = infos.data("controller-name")
    action = infos.data("action")
    this.execFilter('init')
    this.exec(controllerClass, controllerName, action)
    this.execFilter('finish')
    this.appName()

  appName: ->
    appName = $("#init-js").data('app-name') || "App"
    window.App = window[appName]
    if window.App is undefined
      console.log "Initjs: #{appName} is not defined. Run `rails generate initjs` to generate the app file."

  exec: (controllerClass, controllerName, action) ->
    namespace = App
    if controllerClass
      railsNamespace = controllerClass.split("::").slice(0, -1)
    else
      railsNamespace = []

    for name in railsNamespace
      namespace = namespace[name] if namespace

    if namespace and controllerName
      controller = namespace[controllerName]
      if controller and View = controller[action]
        if typeof View is 'function'
          App.currentView = window.view = new View()
        else if View is Object(View) and typeof View.init is 'function'
          App.currentView = window.view = new View.init()

  execFilter: (filterName) ->
    this.appName()
    if App and App.Common and typeof App.Common[filterName] == 'function'
      App.Common[filterName]()

jQuery ->
  window.Initjs.execFilter('initPage') # If you are using the Turbolinks and you need to run a code only once.
  window.Initjs.initialize()

  if window.Turbolinks?
    $(document).bind "page:change", ->
      window.Initjs.initialize()

