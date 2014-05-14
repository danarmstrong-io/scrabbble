Rails.application.routes.draw do

  root 'games#index'
 
  resources :players
  resources :sessions
  resources :games

  match 'games/join' => 'games#join', :via => :post
end
