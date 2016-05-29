Rails.application.routes.draw do

  root "home#show"
  get '/about', to: "home#about", as: "about"
  resources :issues
  resources :repositories
  resources :users
  delete "/logout", to: "sessions#destroy", as: "logout"
  get '/auth/:provider/callback', to: "sessions#create"
  post '/webhooks/receive', to: "webhooks#receive"
end
