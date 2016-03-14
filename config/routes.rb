Rails.application.routes.draw do

  devise_for :users
  root "admin/stores#index"

  namespace :admin do
    resources :stores
  end

end
