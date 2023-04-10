Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root to: "api/v1/days#index"
  namespace :api do
    namespace :v1 do
      resources :days, except: :update
      resources :activities, only: %i[ create destroy ]
      resources :sleeps, only: %i[ create destroy ]
      resources :hydrations, only: %i[update create destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
