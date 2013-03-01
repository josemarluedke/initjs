Dummy::Application.routes.draw do
  root :to => "home#index"
  resources :posts, only: [:index, :new, :show]

  namespace :blog do
    resources :posts, only: [:index, :new, :show]
  end
end
