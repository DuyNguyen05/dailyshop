Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :welcome
  root "welcome#index"
  resources :users

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"
end
