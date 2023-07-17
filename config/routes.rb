Rails.application.routes.draw do
  get 'posts/index'
  root to: 'users#index'
  get 'users/:id', to: 'users#show'
  get 'users/:id/posts', to: "posts#index"
  get 'users/:id/posts/:id', to: "posts#show"

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
