Rails.application.routes.draw do
  root to: "days#index"
  resources :days, except: :update
  resources :activities, only: %i[ create destroy ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
