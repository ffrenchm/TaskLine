Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post 'signin', to 'sessions#create'

  resources :users
end
