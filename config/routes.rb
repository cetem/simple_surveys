SimpleSurveys::Application.routes.draw do
  match 'surveys/info' => 'surveys#info', as: 'surveys_info', via: :get

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
