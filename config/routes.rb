Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root "groupons#index"

  # 管理者
  namespace :admin do
    resources :stores
    resources :users do
      member do
        post :to_admin
        post :to_normal
      end
    end

  end

  # 一般使用者
  resources :stores do
    resources :groupons, only: [:new, :create]
  end

  resources :groupons, only: [:index, :show, :edit, :update, :destroy] do
    get :overview, on: :member

    resources :products, controller: 'groupon/products' do
      post :add_to_order, on: :member
    end

    resources :orders do
      member do
        post :pay_money
        post :return_money
      end

      collection do
        post :pay_money_by_team
      end
    end
  end

  resources :orders do
    resources :order_items
  end

  resources :users, only: [:edit, :update]


end
