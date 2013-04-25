SimpleSurveys::Application.routes.draw do
  resources :surveys, only: [:index, :show, :new, :create]

  devise_for :users
  
  resources :users do
    member do
      get :edit_profile
      put :update_profile
    end
  end
  
  root to: 'surveys#new'
end
