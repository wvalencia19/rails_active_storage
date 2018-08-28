Rails.application.routes.draw do
  resources :profiles

  root to: 'profiles#index'

  resources :sessions, only: [:new, :create, :destroy]

  get '/login' => 'sessions#new', as: 'login'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '/portfolio_api/user_info/:id' => 'profiles#get_api', as: 'get_user_info'
  post '/portfolio_api/modify_user_info/' => 'profiles#update_api', as: 'modify_user_info'
end
