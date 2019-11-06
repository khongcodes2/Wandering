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
  get '/journey', to: 'journeys#new'
  post '/journey', to: 'journeys#create'
  get '/journeys', to: 'journeys#index'
  get '/journeys/:id', to: 'journeys#show'
  get '/users/:id/journeys', to: 'journeys#user_index'

end
