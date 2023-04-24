Rails.application.routes.draw do
  # devise_for :users, defaults: { format: :json }
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root to: "api/v1/days#index"
  devise_for :users, skip: [:sessions, :registrations]#, 
              # controllers: {
              #   sessions: 'users/sessions', 
              #   registrations: 'users/registrations'
              # }

  as :user do
    post '/users/sign_in(.:format)' => 'users/sessions#create', as: 'user_session'
    delete '/users/sign_out(.:format)' => 'users/sessions#destroy', as: 'destroy_user_session'
    post '/users(.:format)' => 'users/registrations#create', as: 'user_registration'
    # delete '/users(.:format)' => 'users/registrations#destroy', as: 'destroy_user_registration' 
  end

  namespace :api do
    namespace :v1 do
      resources :days, except: :update
      # get 'return', action: :ret, controller: 'days'
      resources :activities, only: %i[ create destroy ]
      resources :sleeps, only: %i[ create destroy ]
      resources :hydrations, only: %i[update create destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
