# Initjs [![Build Status](https://travis-ci.org/josemarluedke/initjs.png)](https://travis-ci.org/josemarluedke/initjs) [![Code Climate](https://codeclimate.com/github/josemarluedke/initjs.png)](https://codeclimate.com/github/josemarluedke/initjs) [![Dependency Status](https://gemnasium.com/josemarluedke/initjs.png)](https://gemnasium.com/josemarluedke/initjs) [![Gem Version](https://badge.fury.io/rb/initjs.png)](http://badge.fury.io/rb/initjs)

Initjs helps you organize your javascript to play nice with Rails' asset pipeline. Providing a simple and automatic way to execute your javascript into a specific page.

Works fine with Turbolinks and pjax.


## Javascript structure example

The structure you need follow is the same of your controller and actions on your Rails application.

### Simple objects

```coffee
AppName.Posts ?= {}

AppName.Posts.New =
  init: ->
    # Javascript for the page "posts/new"
  modules: -> []
```
```coffee
AppName.Posts ?= {}

AppName.Posts.Show =
  init: ->
    # Javascript for the page "posts/1"
   modules: -> []
```

We support namespaces too:

```coffee
AppName.Blog ?= {}
AppName.Blog.Posts ?= {}

AppName.Blog.Posts.Show =
  init: ->
    # Javascript for the page "blog/posts/1"
   modules: -> []
```

Also you can use just a function, if you'll not use modules.

```coffee
AppName.Posts ?= {}

AppName.Posts.New = ->
  # Javascript for the page "posts/new"
```

### Using Backbone.js

```coffee
AppName.Posts ?= {}

AppName.Posts.New =
  init: Backbone.View.extend
    # Javascript for the page "posts/new"
   modules: -> []
```

## Requirements
- Rails 3.1 or higher
- jQuery (`jquery-rails`)
- CoffeeScript (`coffee-rails`)

## Installation

Add this line to your application's Gemfile:

    gem 'initjs'

And then execute:

    $ bundle

Run the generator:

    rails generate initjs:install

Make sure initjs generator has injected `//= require app_name/app_name.js` and `//= require init.js` to your Javascript manifest file (usually in `app/assets/javascripts/application.js`).


## Usage

Include the Initjs tag in your application layout (usually in `app/view/layouts/application.html.erb`) right after the opening of the body tag.

```erb
<body>
  <%= initjs_tag 'AppName' %>
  …
</body>
```

Why this tag? This tag will add the informations about the controller and action that is been executed.


### The app file

The app file is the main file for your application, you can set some configurations and put some common code that you need to run on each page. This app file is usually in `app/assets/javascripts/app_name/app_name.js.coffee`. See the default file below:


```coffee
#= require_self
#= require_tree .

window.AppName =
  configs:
    turbolinks: true # True to use initjs with Turbolinks by default.
    pjax: false # True to use initjs with pjax by default.
    respond_with: # To not use respond_with, just set false.
      'Create': 'New' # Respond the Create action with the New.
      'Update': 'Edit' # Respond the Update action with the Edit.

  initPage: ->
    # If you are using the Turbolinks and you need run a code only one time, put something here.
    # if you're not using the turbolinks, there's no difference between init and initPage.
  init: ->
    # Something here. This is called in every page, with or without Turbolinks.
```

### Modules

How about code that we need over and over again? Initjs was a solution for that: Modules!

Modules is the solution to not repeat the same code in more than one place. We just create a function with the code that we need in more than one place and then in the view we need use it, we just say it.

#### Examples

```coffee
AppName.Tabs = ->
  $('.tabs a').click ->
    # do something when the link is clicked
```

```coffee
AppName.Posts.Show =
  init:

  modules: -> [AppName.Tabs]
```

This `AppName.Tabs` will be automatically called when you access `/posts/1` for example.


You also can declare modules for controller, namespaces and for the app, and even modules:

```coffee
AppName.Posts.modules = -> [AppName.Tabs]
```

This is saying to use the `AppName.Tabs` module on all pages that is on `posts` controller.

```coffee
AppName.Tabs =
  init: ->
    $('.tabs a').click ->
      # do something when the link is clicked
   modules: -> [AppName.SomeOtherModule]
```


To declare modules for entire the app, you can do it on the app file:

```coffee
window.AppName =
  initPage: ->
    # ...

  # ...

  modules: -> [AppName.Tabs]
```

### Partials

Sometimes we need execute a javascript for html that will be rendered from a request using ajax/pjax and then execute the javascript. Initjs give you support for that.

You will need add on your 'partial' the `initjs_tag` and say that is a partial:

```erb
<%= initjs_tag app_name: 'AppName', partial: true %>
```

Then you'll need call the Initjs initialize for the partial. Let's say we are using pjax to request the 'partial'.

```coffee
$('.pjax-content').on 'pjax:complete', ->
  Initjs.initializePartial()
```

Then Initjs will execute the javascript for that 'partial'.

**Important:** Modules in controller, namespace and in the application will not be initialized on partials, only modules in the specific view. The `init` function on the app file will be called on partials.


### Respond with

Let's say we have a `form` for edit a post with validations on the back-end side. My action is `edit` and the javascript is write for that action. When I submit this form and get an error, the action that is executing is `update` and not `edit` anymore. So Initjs should call the `Posts.Update` right? Right! But I need the same code that `Posts.Edit` uses to be executed on `Posts.Update` and I should be able to do it without repeating the code. Since Initjs 2.0.0 we have this feature by default.

On the app file we have a configuration saying the default action that will be executed.

```coffee
window.AppName =
  configs:
	# ...
    respond_with:
      'Create': 'New' # Respond the Create action with the New.
      'Update': 'Edit' # Respond the Update action with the Edit.
```

You can change these actions or add more if you need.

Also you can disable this feature if ypu don't need it, just set `false` to `respond_with` variable.

**Important:** Initjs will take a look to see if is there a function for the view first of executing the respond_with, if so, it will initialize the view and not the respond_with configured action.

## Recomended directory structure

Here is the app folder `app/assets/javascripts/app_name/`.

* app_name
    * [controller]
        * [action].js.coffee
        * [other_action].js.coffee
    * [other_controller]
        * [action].js
        * [other_action].js.coffee
        * [more_action].js.coffee
    * [namespace]
        * [controllers]
            * [action].js.coffee

## Generators

1. Generate a controller folder:
```
rails g initjs:add [controllers]
```
    **Example:**
    ```
    rails g initjs:add posts
    ```

    **Generates:**
    * /app_name
        * /posts


2. Generate an action file:
```
rails g initjs:add [controllers] [action]
```
    **Example:**
    ```
    rails g initjs:add posts new
    ```

    **Generates:**
    * /app_name
        * /posts
            * new.js.coffee


3. Generate multiple actions files:
```
rails g initjs:add [controllers] [action_1] [action_2] ... [action_n]
```
    **Example:**
    ```
    rails g initjs:add posts new create edit update
    ```

    **Generates:**
    * /app_name
        * /posts
            * new.js.coffee
            * create.js.coffee
            * edit.js.coffee
            * update.js.coffee

4. Generate namespaced controller and action:
```
rails g initjs:add [namespace]/[controllers] [action_1] [action_2] ... [action_n]
```

    **Example:**
    ```
    rails g initjs:add blog/posts new
    ```

    **Generates:**
    * /app_name
        * /blog
            * /posts
                * new.js.coffee
                
## Changelog

### 2.1.0
- Fix duplicated initialization with Turbolinks 2.x (It will break your app if you are using Turbolinks 1.x)

### 2.0.0

- Add support for objects instead of only fuctions
- Add support for modules
- Add support for configurations
- Add support for pjax
- Add support to initialize inside a partial (pjax friendly)
- Add support for respond_with
- Remove the default namespace Common on app file
- Remove the finish filter
- Lots of refactoring and improvements

### 1.0.1

- Remove the the necessity of pass app_name on initjs_tag
- Change from `=->` to `= ->` on generators
- Use `?= {}` instead of `if` statement
- Change  `if` statement for Trubolinks
- Others minor fixes

### 1.0.0

- Add support for application name
- Add 'install' generator
- Add 'add' generator
- Improve the specs

### 0.1.3

- Add Rails 4 compatibility

### 0.1.2

- Solve bug on IE in addEventListener

### 0.1.1

- Add initPage support to work better with Turbolinks

### 0.1.0

- First release



## Development environment

Make sure you install `Ruby 2.0.0`.

Then just checkout the code, configure dependencies and run the tests:

1. Clone the repository:

 `git clone git://github.com/josemarluedke/initjs.git`

2. Enter the repo directory.

 `cd initjs`

3. Install [Bundler](http://gembundler.com/).

 `gem install bundler`

4. Install all dependencies from [Gemspec](http://docs.rubygems.org/read/chapter/20):

 `bundler install`

### Running tests

1. Run the rspec

	`rake spec`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

I have thanks to @diogob, that is my inspiration for this gem and thanks for core of code ([gist:2321526](https://gist.github.com/diogob/2321526/326c848e29406743c67fd040d4237ffe7ebcc6cd))

# License

Copyright (c) 2012-2013 Josemar Davi Luedke

Licensed under the [MIT license](LICENSE).