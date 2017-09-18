Rails.application.routes.draw do
  root 'categories#index'
  get '/calendar', to: 'pages#calendar'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :teams do
    resources :memberships, shallow: true,  only: [:create, :destroy], controller: 'teams/memberships'
    resources :tasks, except: [:destroy, :show, :index], controller: 'teams/tasks'
    get '/tasks/:id/move_form', to: 'teams/tasks#move_form', as: :move_form
  end

  resources :invites, only: [:create, :destroy]

  resources :categories, except: [:new, :show] do
    resources :tasks, except: [:destroy, :show, :index], controller: 'categories/tasks'
    get '/tasks/:id/move_form', to: 'categories/tasks#move_form', as: :move_form
  end

  resources :tasks, only: [:update, :destroy] do
    resources :allocations, shallow: true, only: [:new, :create, :destroy], controller: 'tasks/allocations'
  end

  patch '/allocations/:id/accept', to: 'allocations#accept', as: :accept
  get '/allocations/:id/accept_form', to: 'allocations#accept_form', as: :accept_form

  patch '/tasks/:id/complete', to: 'tasks#complete', as: :complete
  patch 'tasks/:id/move', to: 'tasks#move', as: :move
end
