Rails.application.routes.draw do
  get 'posts/index'
  root to: 'users#index'
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/:id/posts', to: "posts#index", as: 'post'
  get 'users/:id/posts/:id', to: "posts#show"

  resources :users, :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
