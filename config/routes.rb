Rails.application.routes.draw do
  root to: 'getproblems#top'

  # ホーム関係
  get '/help', to: 'getproblems#help'
  get '/select', to: 'getproblems#select'
  get '/abc', to: 'getproblems#abc'

  # ログイン関係
  get '/signup', to: 'sessions#signup'
  post '/signup', to: 'sessions#create'
  get '/signin', to: 'sessions#signin'
  delete '/logout', to: 'sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
