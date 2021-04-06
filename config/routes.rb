Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
      get "/merchants/find_all", to: "merchants/search#index"
      get "/revenue/merchants", to: "merchants#by_revenue"
      get "/merchants/most_items", to: "merchants#by_items"

      resources :items, only: [:index]
      get "/items/find", to: "items/search#show"
      get "/revenue/items", to: "items#by_revenue"

      get "/revenue/unshipped", to: "invoices#unshipped_revenue"
    end
  end
end
