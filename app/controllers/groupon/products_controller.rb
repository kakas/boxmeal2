class Groupon::ProductsController < ApplicationController

  before_action :authenticate_user!

  def index
    @groupon = Groupon.includes(store: :products).find_by_token(params[:groupon_id])
    @my_order = my_order(@groupon, current_user)
  end

  def add_to_order
    @groupon = Groupon.find_by_token(params[:groupon_id])
    @product = Product.find(params[:id])

    @my_order = my_order(@groupon, current_user)
    @my_order.add_product_to_order(@groupon, @product)
    flash[:success] = "訂購 #{@product.title} 成功。"

    redirect_to order_path(@my_order.token)
  end

end
