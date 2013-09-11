TwitterClient::Application.routes.draw do
  get 'auth/twitter/callback', to: 'sessions#create'
  resource   :session

  resources :tweets, only: :create
  resources :users, only: [:show, :create]
  resources :timelines, only: [:show]

  root to: 'timelines#home'
end
