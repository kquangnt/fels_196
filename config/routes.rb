Rails.application.routes.draw do
  namespace :admin do
    root "static_pages#home"
    resources :categories, except: :show
    resources :courses, except: :show
    resources :lessons do
      resources :words, except: :show
    end
  end

  root "static_pages#home"
  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
end
