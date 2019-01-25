Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "/:id/items", to: "itemsmerchant#index"
        get "/:id/invoices", to: "invoicesmerchant#index"
        get "/most_revenue", to: "revenue#show"
        get "/most_items", to: "most_items#show"
      end
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
    end
  end
end
