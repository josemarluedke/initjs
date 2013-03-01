Dummy::Application.routes.draw do
  get "posts/index"

  get "posts/new"

  get "posts/show"

  root :to => "home#index"
end
