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
    @initModules(@App)
    namespace = @namespace(controllerClass)

    if namespace and controllerName
      controller = namespace[controllerName]
      @initModules(controller)
      @App.currentView = @initView(View) if controller and View = controller[action]

  namespace: (controllerClass)->
    namespace = @App

    if controllerClass
      railsNamespace = controllerClass.split('::').slice(0, -1)
    else
      railsNamespace = []

    for name in railsNamespace
      if namespace
        namespace = namespace[name]
        @initModules(namespace)
    return namespace

  initView: (view)->
    if typeof view is 'function'
      return new view()
    else if typeof view is 'object'
      @initModules(view)
      return new view.init() if typeof view.init is 'function'

  initModules: (obj)->
    if obj? and obj.modules?
      @App.currentModules = [] unless @App.currentModules?

      if typeof obj.modules is 'function'
        modules = [].concat(new obj.modules())
      else
        modules = [].concat(obj.modules)

      for module in modules
        @App.currentModules.push @initView(module)

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
