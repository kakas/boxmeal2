class Groupon::ProductsController < ApplicationController

  def index
    @store = Store.find_by(id: params[:store_id])
    @groupon = Groupon.find_by_token(params[:groupon_id])
  end

end
