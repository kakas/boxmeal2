class Groupon::ProductsController < ApplicationController

  def index
    @groupon = Groupon.find_by_token(params[:groupon_id])
  end

  def add_to_order
    @groupon = Groupon.find_by_token(params[:groupon_id])
    @product = Product.find(params[:id])

    @my_order = my_order(@groupon, current_user)
    @my_order.add_product_to_order(@product)

    redirect_to groupon_products_path(@groupon.token)
  end

end
