Rails.application.routes.draw do

  root 'games#index'
 
  resources :players
  resources :sessions
  resources :games
end
