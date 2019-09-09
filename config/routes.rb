Rails.application.routes.draw do
  root to: 'posts#index'
  get 	 '/signup', to: 'users#new'
  get 	 '/login', to: 'sessions#new'
  post 	 '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :posts
  resources :comments, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friendships, only: [:create, :update, :destroy, :index]
  get 'friends', to: 'friendships#index'
end
