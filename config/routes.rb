Rails.application.routes.draw do

  root 'games#index'
 
  resources :players
  resources :sessions
  resources :games

  match 'games/join' => 'games#join', :via => :post
  match 'games/match' => 'games#match', :via => :post
  match 'games/submit' => 'games#submit', :via => :post
end
