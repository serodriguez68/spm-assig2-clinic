Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :health_care_professionals, except: [:show]
end
