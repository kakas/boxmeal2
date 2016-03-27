class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :groupon_host_required, only: [:pay_money, :return_money, :pay_money_by_group]

  def index
    @orders = current_user.orders.includes(order_items: :product, groupon: :store).order("id DESC")
  end

  def show
    @order = Order.includes(order_items: [:product, :opts]).find_by_token(params[:id])
    @opts = @order.groupon.store.opts
  end

  def pay_money
    @order = Order.find_by_token(params[:id])
    @order.pay!

    redirect_to :back
  end

  def return_money
    @order = Order.find_by_token(params[:id])
    @order.return_money!

    redirect_to :back
  end

  def pay_money_by_team
    @groupon = Groupon.find_by_token(params[:groupon_id])

    @groupon.orders.each do |order|
      if order.user.team == params[:team]
        order.pay!
      end
    end

    redirect_to :back
  end

  private

  def groupon_host_required
    @groupon = Groupon.find_by_token(params[:groupon_id])

    if !@groupon.hosts.include?(current_user)
      flash[:warning] = "迷路了嗎？需要幫你叫警察嗎？"
      redirect_to groupons_path
    end
  end

end
