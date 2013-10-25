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
    this.initModules(App)

    if controllerClass
      railsNamespace = controllerClass.split("::").slice(0, -1)
    else
      railsNamespace = []

    for name in railsNamespace
      if namespace
        namespace = namespace[name]
        console.log namespace
        this.initModules(namespace)

    if namespace and controllerName
      controller = namespace[controllerName]
      this.initModules(controller) if controller?
      App.currentView = this.initView(View) if controller and View = controller[action]


  initView: (view)->
    if typeof view is 'function'
      return new view()
    else if typeof view is 'object'
      this.initModules(view)
      return new view.init() if typeof view.init is 'function'

  initModules: (view)->
    if view.modules?
      App.currentModules = [] unless App.currentModules?

      if typeof view.modules is 'function'
        modules = [].concat(new view.modules())
      else
        modules = [].concat(view.modules)

      for module in modules
        App.currentModules.push this.initView(module)
  config: (name)->
    @App.configs = { turbolinks: true, pjax: false } unless @App.configs
    return @App.configs[name] if @App.configs and @App.configs[name]

  execFilter: (name) ->
   @App[name]() if @App and typeof @App[name] == 'function'


jQuery ->
  window.Initjs.execFilter('initPage') # If you are using the Turbolinks and you need to run a code only once.
  window.Initjs.initialize()

  if window.Turbolinks? and Initjs.config('turbolinks') is true
    $(document).bind 'page:change', ->
      Initjs.initialize()

  if $.fn.pjax? and Initjs.config('pjax') is true
    $(document).bind 'pjax:complete', ->
      Initjs.initialize()
