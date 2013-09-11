TwitterClient::Application.routes.draw do
  get 'auth/twitter/callback', to: 'sessions#create'

  resource  :session,   only: [:new, :create]
  resources :timelines, only: [:show]

  root to: 'timelines#home'
end
