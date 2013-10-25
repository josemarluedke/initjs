# Initjs [![Build Status](https://travis-ci.org/josemarluedke/initjs.png)](https://travis-ci.org/josemarluedke/initjs) [![Code Climate](https://codeclimate.com/github/josemarluedke/initjs.png)](https://codeclimate.com/github/josemarluedke/initjs) [![Dependency Status](https://gemnasium.com/josemarluedke/initjs.png)](https://gemnasium.com/josemarluedke/initjs) [![Gem Version](https://badge.fury.io/rb/initjs.png)](http://badge.fury.io/rb/initjs)

Initjs is a RubyGem that helps your organize your javascript files using Rails' asset pipeline. Providing a simple and automatic way to execute your javascript for a specific page.

Works fine with Turbolinks from Rails.


## Javascript structure example

The structure you need follow is the same of your controller and actions on a Rails app.
You can use a namespace too.

### Simple javascript functions

```coffee
# app/assets/javascripts/app_name/posts/new.js.coffee
AppName.Posts ?= {}

AppName.Posts.New = ->
  # Javascript for the page "posts/new"
```
```coffee
# app/assets/javascripts/app_name/posts/show.js.coffee
AppName.Posts ?= {}

AppName.Posts.Show = ->
  # Javascript for the page "posts/1"
```
```coffee
# app/assets/javascripts/app_name/blog/posts/show.js.coffee
AppName.Blog ?= {}
AppName.Blog.Posts ?= {}

AppName.Blog.Posts.Show = ->
  # Javascript for the page "blog/posts/1"
```

### Using Backbone.js

```coffee
# app/assets/javascripts/app_name/posts/new.js.coffee
AppName.Posts ?= {}

AppName.Posts.New = Backbone.View.extend
  # Javascript for the page "posts/new"
```
```coffee
# app/assets/javascripts/app_name/posts/show.js.coffee
AppName.Posts ?= {}

AppName.Posts.Show = Backbone.View.extend
  # Javascript for the page "posts/1"
```
```coffee
# app/assets/javascripts/app_name/blog/posts/show.js.coffee
AppName.Blog ?= {}
AppName.Blog.Posts ?= {}

AppName.Blog.Posts.Show = Backbone.View.extend
  # Javascript for the page "blog/posts/1"
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

Make sure initjs generator has injected `//= require app_name/app_name.js` and `//= require init.js` to your Javascript manifest file (usually found at `app/assets/javascripts/application.js`).


## Usage

Include the Initjs tag in your application layout (usually found at `app/view/layouts/application.html.erb`) right after the opening of the body tag.

```erb
	<body>
		<%= initjs_tag 'AppName' %>
		…
	</body>
```

### The app file 

If you have a commom javascript that you need execute every page, you can put in `app/assets/javascripts/app_name/app_name.js.coffee`

#### Structure example

```coffee
#= require_self
#= require_tree .

window.AppName =
  Common:
    initPage: ->
      # If you are using the Turbolinks and you need run a code only one time, put something here.
      # if you're not using the turbolinks, there's no difference between init and initPage.
    init: ->
      # Something here. This is called in every page, with or without Turbolinks.
    finish: ->
      # Something here. This is called in every page, with or without Turbolinks.
```

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

### 2.0.0 (Unreleased)

- Add support for objects instead of only fuctions
- Add support for modules
- Add support for configurations
- Add support for pjax
- Remove the default namespace Common on app file
- Lots of refactoring and improvements

### 1.0.1

- Remove the the necessity of pass app_name on initjs_tag
- Change from `=->` to `= ->` on generators
- Fix some typos
- Use `?= {}` instead of `if` statement
- Change  `if` statement for Trubolinks
- Others minor fixes

### 1.0.0

- Add supprot for application name
- Add 'install' generator
- Add 'add' generator
- Improve the specs

### 0.1.3

- Add Rails 4 compatibility

### 0.1.2

- Solve bug on IE in addEventListener

### 0.1.1

- Add initPage support for work better with Turbolinks

### 0.1.0

- First release



## Development environment

You'll need [RVM](https://rvm.io/) to isolate your development environment.

Make sure you install `Ruby 1.9.3` on your [RVM](https://rvm.io/).

Then just checkout the code, configure dependencies and run the tests:

1. Clone the repository:

 `git clone git://github.com/josemarluedke/initjs.git`

2. Enter the repo directory and accept the [RVM](https://rvm.io/):

 `cd initjs`

 `yes` if solicited

3. Install [Bundler](http://gembundler.com/) into our [RVM](https://rvm.io/):

 `gem install bundler`

4. Install all dependencies from [Gemspec](http://docs.rubygems.org/read/chapter/20):

 `bundler install`

### Running tests

1. Go to dummy app folder

	`cd spec/dummy/`

2. Run the rspec

	`rspec spec/`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

I have thanks to @diogob, that is my inspiration for this gem and thanks for core of code ([gist:2321526](https://gist.github.com/2321526))

# License

Copyright (c) 2012-2013 Josemar Davi Luedke

Licensed under the MIT license (see LICENSE.txt file)