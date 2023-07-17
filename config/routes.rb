Rails.application.routes.draw do
  get 'posts/all'
  root to: 'users#all'
  get 'users/:id', to: 'users#userid'
  get 'users/:id/posts', to: "posts#all"
  get 'users/:id/posts/:postid', to: "posts#postid"

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
