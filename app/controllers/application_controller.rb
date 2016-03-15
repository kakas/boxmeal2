class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def my_order(groupon, user)
    order = groupon.orders.find_by_user_id(user.id)
    if order.blank?
      order = groupon.orders.build(user_id: user.id)
      order.save
      order.update_price
    end
    order
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        { |u| u.permit(:email, :name, :team, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :name, :team, :password, :password_confirmation, :current_password) }
  end
end
