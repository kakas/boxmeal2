Rails.application.routes.draw do

  devise_for :users

  root "stores#index"

  # 管理者
  namespace :admin do
    resources :stores
  end

  # 一般使用者
  resources :stores do
    # groupon
    resources :groupons do
      resources :products, controller: 'groupon/products'
    end
  end


end
