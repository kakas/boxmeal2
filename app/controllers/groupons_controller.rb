class GrouponsController < ApplicationController

  before_action :authenticate_user!
  before_action :groupon_host_required, only: [:overview]

  before_action :find_store, only: [:new, :create, :show]

  def index
    @groupons = Groupon.includes(:store).where("is_secret = ?", false)
  end

  def new
    @groupon = Groupon.new
  end

  def create
    @groupon = @store.groupons.build(groupon_params)

    if @groupon.save
      @groupon.hosts << current_user
      redirect_to groupon_products_path(@groupon.token)
    else
      render :new
    end
  end

  def edit
    @groupon = Groupon.find_by_token(params[:id])
  end

  def update
    @groupon = Groupon.find_by_token(params[:id])

    if @groupon.update(groupon_params)
      redirect_to groupon_products_path(@groupon.token)
    else
      render :edit
    end
  end

  def destroy
    @groupon = Groupon.find_by_token(params[:id])

    if @groupon.orders.find_by_is_paid(true).blank?
      @groupon.destroy
      flash[:success] = "成功取消團購"
      redirect_to groupons_path
    else
      flash[:warning] = "請退款給所有人再取消"
      redirect_to overview_groupon_path(@groupon.token)
    end
  end

  def overview
    # about the groupon
    @groupon = Groupon.find_by_token(params[:id])
    @orders = @groupon.orders.includes(:order_items)
    @page_title = "團購：#{@groupon.store.name}"

    # about the groupon's orders
    @grouped_orders = @groupon.group_order_by_user_team

    # groups all of order_items by product.title
    @order_items_and_price = @groupon.group_order_items_by_title
  end

  private

  def groupon_params
    params.require(:groupon).permit(:deadline, :is_secret)
  end

  def find_store
    @store = Store.find_by(id: params[:store_id])
  end

  def groupon_host_required
    @groupon = Groupon.find_by_token(params[:id])

    if !@groupon.hosts.include?(current_user)
      flash[:warning] = "迷路了嗎？需要幫你叫警察嗎？"
      redirect_to groupons_path
    end
  end


end
