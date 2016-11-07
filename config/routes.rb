Rails.application.routes.draw do
  root "static_pages#show", page: "home"
  get "/static_pages/*page", to: "static_pages#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  resources :account_activations, only: :edit
  resources :password_resets, except: [:index, :show, :destroy]
  resources :users, only: [:show, :edit, :update]
  resources :products, only: [:index, :show] do
    resources :ratings, only: :create
  end

  namespace :admin do
    resources :categories, except: :show
    resources :users, except: :show
    resources :products, except: :show
  end
end
