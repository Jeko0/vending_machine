Rails.application.routes.draw do
  devise_for :user
  
  namespace :api do
    namespace :users do
      resources :sessions, only: :create
      resources :registrations, only: %i[create update destroy]
    end
  end
end
