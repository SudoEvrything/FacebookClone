Rails.application.routes.draw do
	root 	 'home#index'
	get 	 '/home', to: 'home#index'
  get 	 'sessions/new'
  get 	 '/signup', to: 'users#new'
  get 	 'login', to: 'sessions#new'
  post 	 '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :posts, only: [:create, :destroy]
end
