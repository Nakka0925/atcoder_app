Rails.application.routes.draw do
  root to: 'getproblems#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # ログイン周り
  get '/signup', to: 'users#new'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users

  # Defines the root path route ("/")
  # root "articles#index"
end
