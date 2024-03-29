Rails.application.routes.draw do
  namespace :user do
    resources :posts, only: %i[edit update destroy create] do
      resources :comments, only: %i[edit update destroy create]
      resources :likes, only: %i[create destroy]
    end
  end

  devise_for :users

  get 'up' => 'rails/health#show', as: :rails_health_check

  authenticated :user do
    root to: 'user/posts#index', as: :user_root
  end

  root 'home#index'
end
