Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :categories, except: :new do
    resources :items, only: [:create, :edit, :update, :destroy],
                      controller: 'categories/items'
  end
end
