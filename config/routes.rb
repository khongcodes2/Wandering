Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # users
  resources :users
  
  # sessions
  root 'sessions#home'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  # travelers
  resources :travelers

  # journeys
  resources :journeys, only: [:index, :show, :new]
  post '/journeys/new', to: 'journeys#create'

  # regions and spaces
  # comment out index functions later?
  resources :regions, only: [:show, :index] do
    resources :spaces, only: [:index, :show, :new]
  end
  post '/spaces', to: 'spaces#create'
  get '/spaces', to: 'spaces#total_index'

  # items
  get '/items', to: 'items#index' #comment out later
  get '/items/new', to: 'items#new' 
  post '/items', to: 'items#create'
  get '/items/:id', to: 'items#show', as: :item

end
