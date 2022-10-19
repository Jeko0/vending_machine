Rails.application.routes.draw do

  namespace :api do
    namespace :users do
      resources :sessions, only: :create
      resources :registrations, only: %i[create update destroy]
    end
    resources :products, only: [:index, :create, :update, :destroy]
  end
end
