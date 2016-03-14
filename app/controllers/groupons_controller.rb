class GrouponsController < ApplicationController

  before_action :authenticate_user!

  before_action :find_store, only: [:new, :create, :show]
  before_action :find_groupon, only: [:show]

  def new
    @groupon = Groupon.new
  end

  def create
    @groupon = @store.groupons.build(groupon_params)

    if @groupon.save
      @groupon.hosts << current_user
      redirect_to store_groupon_path(@store, @groupon.token)
    else
      render :new
    end
  end

  def show
    @groupon = Groupon.find_by_token(params[:id])
  end

  private

  def groupon_params
    params.require(:groupon).permit(:deadline, :is_secret)
  end

  def find_store
    @store = Store.find_by(id: params[:store_id])
  end
end
