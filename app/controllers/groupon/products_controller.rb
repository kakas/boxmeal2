class Groupon::ProductsController < ApplicationController

  def index
    @groupon = Groupon.includes(store: :products).find_by_token(params[:groupon_id])
    @my_order = my_order(@groupon, current_user)
  end

  def add_to_order
    @groupon = Groupon.find_by_token(params[:groupon_id])
    @product = Product.find(params[:id])

    @my_order = my_order(@groupon, current_user)
    if @my_order.items.include?(@product)
      flash[:warning] = "#{@product.title} 已經下訂過囉～請直接修改數量即可。"
    else
      @my_order.add_product_to_order(@product)
      flash[:success] = "訂購 #{@product.title} 成功。"
    end

    redirect_to order_path(@my_order.token)
  end

end
