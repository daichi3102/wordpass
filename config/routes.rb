Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resource :profile, only: %i[show edit update]
  resources :fetch_ais
  root to: 'tops#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/terms', to: 'tops#terms'
  get '/privacy', to: 'tops#privacy'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
