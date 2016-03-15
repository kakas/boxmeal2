class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(order_items: :product, groupon: :store)
  end

  def show
    @order = Order.includes(order_items: :product).find_by_token(params[:id])
  end

end
