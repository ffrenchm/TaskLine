Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :users

  resources :categories, except: :new do
    resources :items, except: [:index, :show],
                      controller: 'categories/items'
  end
  get '/categories/:category_id/items/:id', to: 'categories/items#complete', as: :complete
end
