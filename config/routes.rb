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
  get '/journeys/continue', to: 'journeys#continue', as: :continue
  resources :journeys, except: [:create]
  post '/journeys/new', to: 'journeys#create'
  

  # regions and spaces
  # comment out index functions later?
  resources :regions, only: [:show, :index] do
    resources :spaces, only: [:index, :show, :new]
  end
  get '/spaces/:id', to: 'spaces#show', as: :space
  get '/spaces', to: 'spaces#total_index'
  resources :spaces, only: [:create, :edit, :update, :destroy]


  # items
  resources :items

  #game flow
  post '/drop_item', to: 'journeys#drop_item', as: :drop_item
  post '/pickup_item', to: 'journeys#pickup_item', as: :pickup_item

  # game flow - end journey
  post '/wrapup', to: 'journeys#enter_wrapup', as: :enter_wrapup
  get '/wrapup', to: 'journeys#wrapup', as: :wrapup
  get '/wrapup_cast', to: 'journeys#wrapup_cast', as: :wrapup_cast
  post '/wrapup_cast', to: 'journeys#wrapup_casting', as: :wrapup_casting
  get '/end_journey', to: 'journeys#end_journey', as: :end_journey

  # omniauth
  get '/auth/twitter/callback' => 'sessions#omniauth_create'

  # admin control panel
  get '/admin', to: 'admin#control_panel', as: :control_panel

end