Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :teams
  resources :memberships, only: [:create, :destroy]
  resources :invites

  resources :categories, except: :new do
    resources :items, except: [:index, :show],
                      controller: 'categories/items'
    get '/items/:id/complete', to: 'categories/items#complete', as: :complete
    get '/items/:id/move_form', to: 'categories/items#move_form', as: :move_form
    patch 'items/:id/move', to: 'categories/items#move', as: :move
  end
end
