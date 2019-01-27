Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "/:id/items", to: "itemsmerchant#index"
        get "/:id/invoices", to: "invoicesmerchant#index"
        get "/:id/revenue", to: "merchantrevenue#show"
        get "/:id/revenue", to: "merchantrevenue#index"
        get "/most_revenue", to: "revenue#show"
        get "/revenue", to: "revenue#index"
        get "/most_items", to: "most_items#show"
        get "/:id/favorite_customer", to: "favorite_customer#show"
      end
      namespace :items do
        get "/:id/invoice_items", to: "invoice_items#index"
        get "/:id/merchant", to: "merchant#show"
        get "/most_revenue", to: "most_revenue#index"
      end
      namespace :invoices do
        get "/:id/invoice_items", to: "invoice_items#index"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/items", to: "items#index"
        get "/:id/merchant", to: "merchant#show"
        get "/:id/customer", to: "customer#show"
      end
      namespace :customers do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "/:id/invoices", to: "customer_invoices#index"
      end
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end
end
