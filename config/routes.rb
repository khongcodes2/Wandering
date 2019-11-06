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
  get '/journey', to: 'journeys#new', as: :new_journey
  post '/journeys', to: 'journeys#create', as: :create_journey
  get '/journeys', to: 'journeys#index', as: :journeys
  get '/journeys/:id', to: 'journeys#show', as: :journey
  get '/users/:id/journeys', to: 'journeys#user_index'


  #items
  get '/items/new', to: 'items#new'
  post '/items', to: 'items#create'
  get '/items/:id', to: 'items#show'

end
