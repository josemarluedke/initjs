window.Initjs =
  initialize: ($infos)->
    unless $infos?
      $infos = @$infos()

    @appName($infos) unless @App
    @execFilter('init')
    resource = $infos.data('resource').split('/') if $infos.data('resource')
    @exec(resource, $infos.data('action'))

  initializePartial: ->
    $infos = @$partialInfos()
    if $infos.length > 0
      @partial = true
      @initialize($infos)

  $infos: -> $('#init-js')
  $partialInfos: -> $('#init-partial-js')
  partial: false

  appName: ($infos)->
    app_name = $infos.data('app-name') || 'App'
    @App = window[app_name]
    console.log "Initjs: #{app_name} is not defined. Run `rails generate initjs:install` to generate the app file." unless @App?

  exec: (resources, action) ->
    @initModules(@App) unless @partial is true
    return unless resources
    controller_name = resources.pop()
    namespace = @namespace(resources)

    if namespace and controller_name
      controller = namespace[controller_name]
      @initModules(controller) unless @partial is true

      if controller and View = controller[action]
        @App.currentView = @initView(View)
      else if controller and @config('respond_with')
        actions = []
        actions.push k for k of @config('respond_with')

        if $.inArray(action, actions) != -1 and View = controller[@config('respond_with')[action]]
          @App.currentView = @initView(View)

    @partial = false

  namespace: (resources)->
    namespace = @App

    for name in resources
      if namespace
        namespace = namespace[name]
        @initModules(namespace) unless @partial is true
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
    return false unless @App?
    @App.configs = { turbolinks: true, pjax: false, respond_with: { 'Create': 'New', 'Update': 'Edit' } } unless @App.configs
    return @App.configs[name] if @App.configs and @App.configs[name]

  execFilter: (name) ->
   @App[name]() if @App and typeof @App[name] == 'function'

  initApp: ->
    @appName(@$infos())
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
