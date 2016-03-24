class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def my_order(groupon, user)
    order = groupon.orders.find_by_user_id(user.id)
    if order.blank?
      order = groupon.orders.build(user_id: user.id)
      order.save
      order.update_price
    end
    order
  end

  def admin_required
    if !current_user.is_admin?
      redirect_to root_path
    end
  end

end
