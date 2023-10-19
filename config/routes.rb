Rails.application.routes.draw do
  root to: 'getproblems#top'

  # 基本機能
  get '/help', to: 'getproblems#help'
  post '/problem_create',    to: 'getproblems#create'

  # API
  get '/problems', to: 'problems_api#new'

  # ログイン周り
  get '/signup', to: 'users#new'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users

  # Defines the root path route ("/")
  # root "articles#index"
end
