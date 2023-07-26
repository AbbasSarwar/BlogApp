Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

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
