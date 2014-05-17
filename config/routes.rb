Rails.application.routes.draw do

  root 'games#index'
  resources :players
  resources :sessions
  resources :games do
    member do
      post 'join'
      post 'match'
      post 'submit'
      post 'forfeit'
    end
  end

end
