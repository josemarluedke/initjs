window.Initjs =
  initialize: ->
    infos = @infos()
    @appName(infos) unless @App
    @execFilter('init')
    @exec(infos.data('controller-class'), infos.data('controller-name'), infos.data('action'))

  infos: -> $('#init-js')

  appName: (infos)->
    console.log('find app name')
    appName = infos.data('app-name') || 'App'
    @App = window[appName]
    console.log "Initjs: #{appName} is not defined. Run `rails generate initjs` to generate the app file." unless @App?

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

  initApp: ->
    @appName(@infos())
    Initjs.execFilter('initPage')
    @initialize()

jQuery ->
  Initjs.initApp()

  if window.Turbolinks? and Initjs.config('turbolinks') is true
    $(document).bind 'page:change', ->
      Initjs.initialize()

  if $.fn.pjax? and Initjs.config('pjax') is true
    $(document).bind 'pjax:complete', ->
      Initjs.initialize()
