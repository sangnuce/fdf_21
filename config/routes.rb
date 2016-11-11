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
  resources :users, only: [:show, :edit, :update] do
    resources :orders
  end
  resources :carts, only: :update
  resources :products, only: [:index, :show] do
    resources :ratings, only: :create
    resources :comments, only: [:create, :destroy]
  end
  resources :product_suggests, only: [:new, :create]

  namespace :admin do
    resources :categories, except: :show
    resources :users, except: :show
    resources :products, except: :show
    resources :orders, except: [:create, :new, :destroy]
    resources :product_suggests, only: [:index, :update, :destroy]
  end
end
