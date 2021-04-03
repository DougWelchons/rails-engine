Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
      resources :items, only: [:index]
      get "items/find", to: "items/search#show"
    end
  end
end
