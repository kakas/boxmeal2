Rails.application.routes.draw do

  devise_for :users

  root "groupons#index"

  # 管理者
  namespace :admin do
    resources :stores
  end

  # 一般使用者
  resources :stores do
    resources :groupons, only: [:new, :create]
  end

  resources :groupons, only: [:index, :show, :edit, :update, :destroy] do
    resources :products, controller: 'groupon/products' do
      post :add_to_order, on: :member
    end
  end

  resources :orders


end
