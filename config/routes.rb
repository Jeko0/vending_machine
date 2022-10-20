Rails.application.routes.draw do

  namespace :api do
    namespace :users do
      post '/', to: "registrations#create"
      patch '/', to: "registrations#update"
      delete '/', to: "registrations#destroy"
      post '/login', to: "sessions#create"
    end

    #product routes
    get '/products', to: "products#index"
    get '/products/:product_id', to: "products#show"
    post '/products', to: "products#create"
    patch '/products/:product_id', to: "products#update"
    delete '/products/:product_id', to: "products#destroy"

    #deposit routes 
    get '/deposit', to: "deposits#show"
    patch '/deposit', to: "deposits#update" 
    delete '/reset', to: "deposits#destroy"
    post '/buy', to: "deposits#buy"
  end
end
