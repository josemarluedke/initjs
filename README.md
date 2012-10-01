# Initjs

Init.js is a Ruby Gem that helps run your javascript only in a page that its necessary.

Along with Rails, you can make a good structure for your javascript.
A good example is using the Backbone.js, separating each page into a view of the Backbone.js.

Works fine with Turbolinks from Rails.


## Javascript structure example

The structure you need follow is the same of your controller and action.
You can use a namespace too.

### With Backbone.js

```javascript
App.Posts.New = Backbone.View.extend({
  initialize: function() {
    // Javascript for the page "posts/new"
  }
});

App.Posts.Show = Backbone.View.extend({
  initialize: function() {
    // Javascript for the page "posts/1"
  }
});

// with namespace
App.Blog.Posts.Show = Backbone.View.extend({
  initialize: function() {
    // Javascript for the page "blog/posts/1"
  }
});
```

### Without Backbone.js

```javascript
App.Posts.New = function() {
  // Javascript for the page "posts/new"
};

App.Posts.Show = function() {
  // Javascript for the page "posts/1"
};

// with namespace
App.Blog.Posts.Show = function() {
  // Javascript for the page "blog/posts/1"
};
```


## Installation

Add this line to your application's Gemfile:

    gem 'initjs'

And then execute:

    $ bundle

Run the generator:

    rails generate initjs

Add `//= require init.js` to your Javascript manifest file (usually found at `app/assets/javascripts/application.js`).



## Usage

Include the Initjs tag in your application layout (usually found at `app/view/layouts/application.html.erb`) after the body tag.

```erb
<%= initjs_tag %>
```

### The app.js

If you have a commom javascript that you need execute every page, you can put in `app/assets/javascripts/app.js.coffee`

#### Structure example

```coffee
App = window.App =
  Common:
    init: ->
      # Something here
    finish: ->
      # Something here
```


## Work left to do

* Add proper unit tests


## Thanks

I have thanks to @diogob, that is my inspiration for this gem and thanks for core of code ([gist:2321526](https://gist.github.com/2321526))


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
