Rails.application.routes.draw do

  root "admin/stores#index"

  namespace :admin do
    resources :stores
  end

end
