class Admin::StoresController < Admin::AdminController

  before_action :find_store, only: [:edit, :edit_products, :show, :update, :destroy]

  def index
    @stores = Store.all
  end

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

  def show

  end

  def edit
  end

  def edit_products
  end

  def update
    if @store.update(store_params)
      flash[:success] = "修改成功。"
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    redirect_to admin_stores_path
  end

  private

  def store_params
    params.require(:store).permit(:name, :phone, :address, :is_drink, products_attributes: [:id, :title, :price, :_destroy], opts_attributes: [:id, :content, :price, :_destroy])
  end


  def find_store
    @store = Store.find(params[:id])
  end

end
