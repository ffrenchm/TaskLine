Rails.application.routes.draw do
  root 'pages#home'
  get '/inbox', to: 'pages#inbox'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :teams do
    resources :memberships, shallow: true,  only: [:create, :destroy], controller: 'teams/memberships'
    resources :tasks, only: [:new, :create], controller: 'teams/tasks'
  end

  resources :invites, only: [:create, :destroy]

  resources :categories, except: :new do
    resources :tasks, only: [:new, :create], controller: 'categories/tasks'
  end

  resources :tasks, except: [:new, :create] do
    resources :allocations, shallow: true, only: [:new, :create, :destroy], controller: 'tasks/allocations'
  end
  patch '/tasks/:id/complete', to: 'tasks#complete', as: :complete
  get '/tasks/:id/move_form', to: 'tasks#move_form', as: :move_form
  patch 'tasks/:id/move', to: 'tasks#move', as: :move
end
