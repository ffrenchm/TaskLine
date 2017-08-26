Rails.application.routes.draw do
  root 'pages#home'
  get '/inbox', to: 'pages#inbox'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :teams do
    resources :memberships, only: [:create, :destroy], controller: 'teams/memberships'
  end

  resources :invites

  resources :categories, except: :new do
    resources :tasks, except: [:index, :show],
                      controller: 'categories/tasks'
    patch '/tasks/:id/complete', to: 'categories/tasks#complete', as: :complete
    get '/tasks/:id/move_form', to: 'categories/tasks#move_form', as: :move_form
    patch 'tasks/:id/move', to: 'categories/tasks#move', as: :move
  end
end
