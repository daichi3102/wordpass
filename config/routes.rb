# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tops#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }
  resource :profile, only: %i[show edit update]

  get 'mypage', to: 'mypages#index'
  get 'mypage/profile', to: 'mypages#profile'
  get 'mypage/ai', to: 'mypages#ai'
  get 'mypage/makes', to: 'mypages#makes'
  get 'mypage/likes', to: 'mypages#likes'

  resources :fetch_ais

  resources :makes, only: %i[index new create show edit update destroy] do
    resource :first_part, only: %i[new create edit update]
    resource :second_part, only: %i[new create edit update]
    # makeにネストしたいいね機能のルーティング
    collection do
      get :likes
    end
  end
  # 上のルーティングとは別に、first_partsとsecond_partsのindexアクションを呼び出すためのルーティング
  resources :first_parts, only: [:index]
  resources :second_parts, only: [:index]

  # そもそものいいね機能のルーティングを追加
  resources :likes, only: %i[create destroy]

  resources :informations, only: :index

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/privacy', to: 'tops#privacy'
  get '/terms', to: 'tops#terms'
  get '/thanks', to: 'tops#thanks'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '*path', to: 'application#render404'
end
