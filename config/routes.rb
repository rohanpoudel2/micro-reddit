Rails.application.routes.draw do

  namespace :user do
    resources :posts, only: [:edit, :update, :destory, :create]
  end

  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :user do
    root to: "user/posts#index", as: :user_root
  end


  root "home#index"  
  
end
