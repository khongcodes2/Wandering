Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # users
  resources :users
  
  #sessions
  root 'sessions#home'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  #journeys
  resources :journeys, only: [:index, :show, :new, :create]
  get '/users/:id/journeys', to: 'journeys#user_index'

  #regions
  get '/regions', to: 'regions#index' #comment out later
  get '/regions/:id', to: 'regions#show'

  #spaces
  get '/spaces', to: 'spaces#index' #comment out later
  get '/spaces/:id', to: 'spaces#show'

  #items
  get '/items', to: 'items#index' #comment out later
  get '/items/new', to: 'items#new' 
  post '/items', to: 'items#create'
  get '/items/:id', to: 'items#show'

end
