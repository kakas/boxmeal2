Rails.application.routes.draw do

  root "admin/stores#index"

  # 管理者
  namespace :admin do
    resources :stores
  end

  # 一般使用者
  resources :stores

end
