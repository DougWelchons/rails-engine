Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
      get "/merchants/find_all", to: "merchants/search#index"
      get "/revenue/merchants", to: "merchants#most_revenue"
      get "/merchants/most_items", to: "merchants#most_items"
      resources :items, only: [:index]
      get "/items/find", to: "items/search#show"
    end
  end
end
