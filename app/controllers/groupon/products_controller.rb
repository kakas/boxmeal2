class Groupon::ProductsController < ApplicationController

  def index
    @store = Store.find_by(id: params[:store_id])
    @groupon = Groupon.find_by_token(params[:groupon_id])
  end

  def add_to_order
    @store = Store.find_by(id: params[:store_id])
    @groupon = Groupon.find_by_token(params[:groupon_id])
    @product = Product.find(params[:id])

    @my_order = my_order(@groupon, current_user)
    @my_order.add_product_to_order(@product)

    redirect_to store_groupon_products_path(@store, @groupon.token)
  end

end
