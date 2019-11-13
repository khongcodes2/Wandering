Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # users
  resources :users
  
  # sessions
  root 'sessions#home'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/about', to: 'sessions#about'

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

  #game flow
  post '/drop_item', to: 'journeys#drop_item', as: :drop_item
  post '/pickup_item', to: 'journeys#pickup_item', as: :pickup_item

  # game flow - end journey
  post '/wrapup', to: 'journeys#enter_wrapup', as: :enter_wrapup
  get '/wrapup', to: 'journeys#wrapup', as: :wrapup
  get '/wrapup_cast', to: 'journeys#wrapup_cast', as: :wrapup_cast
  post '/wrapup_cast', to: 'journeys#wrapup_casting', as: :wrapup_casting
  get '/end_journey', to: 'journeys#end_journey', as: :end_journey

  # game flow - end journey
  get '/auth/twitter/callback' => 'sessions#omniauth_create'

end