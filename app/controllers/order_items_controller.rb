class OrderItemsController < ApplicationController

  def update
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      @order.update_price
      n = order_item_params[:quantity]
      flash[:success] = "#{@order_item.product.title}改為#{n}個"
      redirect_to order_path(@order.token)
    else
      flash[:success] = "變更數量失敗"
      render :back
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end

end
