class OrdersController < ApplicationController


  def show
    @order = Order.includes(order_items: :product).find_by_token(params[:id])
  end

end
