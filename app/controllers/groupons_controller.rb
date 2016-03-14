class GrouponsController < ApplicationController

  before_action :authenticate_user!

  def new
    @groupon = Groupon.new
  end

  def create
    @groupon = Groupon.new(groupon_params)

    if @groupon.save
      @groupon.hosts << current_user
      redirect_to groupon_path(@groupon)
    else
      render :new
    end
  end

  private

  def groupon_params
    params.require(:groupon).permit(:deadline, :is_secret)
  end
end
