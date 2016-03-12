class Admin::StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)

    if @store.save
      redirect_to admin_stores_path
    else
      render :new
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :phone, :address)
  end

end
