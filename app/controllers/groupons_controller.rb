class GrouponsController < ApplicationController

  before_action :authenticate_user!

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

  private

  def groupon_params
    params.require(:groupon).permit(:deadline, :is_secret)
  end

  def find_store
    @store = Store.find_by(id: params[:store_id])
  end

end
