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
  resources :items, only: [:index, :show, :new, :create]

  # game flow
  post '/wrapup', to: 'journeys#enter_wrapup', as: :enter_wrapup
  get '/wrapup', to: 'journeys#wrapup', as: :wrapup
  get '/wrapup_cast', to: 'journeys#wrapup_cast', as: :wrapup_cast
  post '/wrapup_cast', to: 'journeys#wrapup_casting', as: :wrapup_casting
  get '/end_journey', to: 'journeys#end_journey'

end