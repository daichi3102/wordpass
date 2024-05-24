Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resource :profile, only: %i[show edit update]

  get 'mypage', to: 'mypages#index'

  resources :fetch_ais

  resources :makes, only: %i[index new create show edit update destroy] do
    resource :first_part, only: %i[new create edit update]
    resource :second_part, only: %i[new create edit update]
    # makeにネストしたいいね機能のルーティングを追加
    collection do
      get :likes
    end
  end

  # 上のルーティングとは別に、first_partsとsecond_partsのindexアクションを呼び出すためのルーティングを追加
  resources :first_parts, only: [:index]
  resources :second_parts, only: [:index]

  # そもそものいいね機能のルーティングを追加
  resources :likes, only: %i[create destroy]

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
