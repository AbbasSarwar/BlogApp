Rails.application.routes.draw do
  get 'posts/index'
  root to: 'users#index'
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/:id/posts', to: "posts#index", as: 'post'
  get 'users/:id/posts/:id', to: "posts#show"
  get '/posts/new', to: 'posts#new'
  get '/users/:id/posts/:id/comments/new', to: 'comments#new'

  resources :users do
    resources :posts do
      resources :comments
      post 'likes', to: 'likes#create'
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
