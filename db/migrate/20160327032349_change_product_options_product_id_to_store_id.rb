class ChangeProductOptionsProductIdToStoreId < ActiveRecord::Migration
  def change
    rename_column :product_options, :product_id, :store_id
  end
end
