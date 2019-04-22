Rails.application.routes.draw do
  get 'appointments/new'
  get 'appointments/create'
  get 'appointments/destroy'
  get 'appointments/my'
  get 'appointments/all'
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
