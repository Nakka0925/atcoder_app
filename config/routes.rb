Rails.application.routes.draw do
  get 'users/new'
  root to: 'getproblems#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # ログイン周り
  get '/signup', to: 'users#new'

  resources :users

  # Defines the root path route ("/")
  # root "articles#index"
end
