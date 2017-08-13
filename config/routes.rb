Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :categories, only: [:create, :destroy, :index, :show] do
    resources :items, only: [:create, :destroy],
                      controller: 'categories/items'
  end
end
