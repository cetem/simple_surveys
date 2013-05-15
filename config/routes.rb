SimpleSurveys::Application.routes.draw do
  get 'surveys/info', 'surveys#info', as: 'surveys_info'
  resources :surveys, only: [:index, :show, :new, :create]

  devise_for :users
  
  resources :users do
    member do
      get :edit_profile
      put :update_profile
    end
  end
  
  root to: 'surveys#info'
end
