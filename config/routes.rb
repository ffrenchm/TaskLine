Rails.application.routes.draw do
  root 'categories#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :invites, only: [:create, :destroy]

  resources :teams do
    resources :memberships, shallow: true,  only: [:create, :destroy], controller: 'teams/memberships'
    resources :tasks, only: [:new, :create], controller: 'teams/tasks'
  end

  resources :categories, except: [:new, :show] do
    resources :tasks, only: [:new, :create], controller: 'categories/tasks'
  end

  resources :tasks, only: [:edit, :update, :destroy] do
    member do
      get 'move_form'
      patch 'complete'
    end
    resources :allocations, only: [:new, :create], controller: 'tasks/allocations'
  end

  resources :allocations, only: :destroy do
    member do
      get 'accept_form'
      patch 'accept'
    end
  end

end
