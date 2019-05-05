Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :users
  resources :health_care_professionals, except: [:show] do
    collection do
      get :index_of_specialty
    end
  end

  resources :appointments, only: [:new, :create, :destroy] do
    collection do
      get :available_slots_between
      get :my
      get :all
    end
  end

end
